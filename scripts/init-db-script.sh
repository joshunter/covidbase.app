#!/bin/bash

# This is the initialization script. All existing collections in world database will be dropped.
# Upon dropping, they are re-established with fresh data.rm worldometer.html

# Since this script relys on appending, all files have to be clear.
rm worldometer.html
rm worldInfo
rm cutWorldInfo
rm countryData
rm cutData
rm dbCounty

# If the world database exists, it will be dropped to ensure a clean start.
mongo --eval "db.dropDatabase();" world

# Pull the site with new data
curl https://www.worldometers.info/coronavirus/ >> worldometer.html

# Files that will be used
input="worldometer.html"
wFile="worldInfo"
wFile2="cutWorldInfo"
file="countryData"
file2="cutData"

data=""
cData=""

found=0
done=0
i=0

# Keys that let me know when to start/stop saving data
worldinfoStart='<td style="display:none;" data-continent=""></td>'
table='<table id="main_table_countries_today"'
tableEnd='<td><strong>Total:</strong></td'

# Regular Expression to grab data
regex='\+?(\w+\.?\s?/?\w*|\d*,?\d*,?\d*\s*)+</(a|td)>'

while IFS= read -r line
do
	if [[ $line =~ $regex && $found -eq 1 && $done -eq 0 ]]; then
		echo "${BASH_REMATCH[0]//'</td>'/''}" >> $wFile
	fi
	if [[ $line =~ $regex && $found -eq 2 && $done -eq 0 ]]; then
		echo "${BASH_REMATCH[0]//'</td>'/''}" >> $file
	fi
	# find <table id="main_table_countries_today"
	if [[ $line =~ $worldinfoStart ]]; then
		found=1
	fi
	if [[ $line == *"All</td>"* ]]; then
		found=2
	fi
	if [[ $line =~ $tableEnd ]]; then
		done=1
	fi
done < "$input"


while IFS= read -r line
do
	echo "${line//'</a>'/''}" >> $file2
done < "$file"

# Data is now cut into a format to package.

# Global information
tail -n +4 $wFile > $wFile2

i=0
declare -a dataFields=( "{rank: \"0" "name: \"" "total: \"" "newActive: \"" "deaths: \"" "newDeaths: \"" "recovered: \"" "newRecovered: \"" "active: \"" "critical: \"" "casesPM: \"" "deathsPM: \"")

while IFS= read -r line
do
	if [[ i -eq 1 ]]; then
		name=$line
	fi

	if [[ i -eq 11 ]]; then
		data+="${dataFields[$i]}$line\"}"
		break
	else
		data+="${dataFields[$i]}$line\","
		let "i=i+1"
	fi

done < "$wFile2"

# Update database
toEval='db.worldData.insert('$data');'

# echo $toEval >> $wFile

mongo --eval "$toEval" world >> dbWorld

tail -n +4 $file2 > $file

# Parse country info
data=""
i=0
declare -a dataFields=( "{rank: \"" "name: \"" "total: \"" "newActive: \"" "deaths: \"" "newDeaths: \"" "recovered: \"" "newRecovered: \"" "active: \"" "critical: \"" "casesPM: \"" "deathsPM: \"" "tests: \"" "testsPM: \"" "population: \"" "continent: \"" "casePP: \"")

while IFS= read -r line
do
	if [[ i -eq 1 ]]; then
		if [[ $line == 'union' ]]; then
			line='Réunion'
		fi
		if [[ $line == 'ao' ]]; then
			line='Curaçao'
		fi

		name=$line
	fi

	if [[ i -eq 16 ]]; then
		data+="${dataFields[$i]}$line\"}"

		toEval='db.countryData.insert('$data');'

		# echo $toEval >> $file2

		mongo --eval "$toEval" world >> dbCounty

		data=""
		let "i=0"
	else
		data+="${dataFields[$i]}$line\","
		let "i=i+1"
	fi

done < "$file"

# Clean up
rm dbCounty
rm cutWorldInfo
rm worldometer.html
rm countryData
rm worldInfo
rm cutData