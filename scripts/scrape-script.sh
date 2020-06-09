#!/bin/bash

# Start clean
rm worldometer.html
rm countryData
rm worldInfo
rm cutData
rm cutWorldInfo

# Pull the site with new data
curl https://www.worldometers.info/coronavirus/ >> worldometer.html

# Files used to hold data temporarily
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

# Start parsing global information.
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
toEval='db.worldData.update({ name: "World" }, '$data',{upsert: true});'

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

		toEval='db.countryData.update({ name: "'$name'" }, '$data',{upsert: true});'
		# echo $toEval >> $file2

		mongo --eval "$toEval" world >> dbCounty

		data=""
		let "i=0"
	else
		data+="${dataFields[$i]}$line\","
		let "i=i+1"
	fi

done < "$file"

# Remove ships
toEval='db.countryData.remove({ name: "" });'
mongo --eval "$toEval" world >> dbCounty


# Clean up
rm cutWorldInfo
rm worldometer.html
rm countryData
rm worldInfo
rm cutData
rm dbCounty
rm dbWorld