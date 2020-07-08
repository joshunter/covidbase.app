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
cFile="continentInfo"
cFile2="cutContinentInfo"
file="countryData"
file2="cutData"

data=""
cData=""

found=0
i=0

# Keys that let me know when to start/stop saving data
contInfoStart='<tr class="total_row_world row_continent" data-continent="North America"'
worldinfoStart='<td style="display:none;" data-continent=""></td>'
table='<table id="main_table_countries_today"'
tableEnd='<td><strong>Total:</strong></td'

# Regular Expression to grab data
regex='\+?(\w+\.?\s?/?\w*|\d*,?\d*,?\d*\s*)+</(a|td)>'

while IFS= read -r line
do
	if [[ $line =~ $regex && $found -eq 1 ]]; then
		echo "${BASH_REMATCH[0]//'</td>'/''}" >> $cFile
	fi
	if [[ $line =~ $regex && $found -eq 2 ]]; then
		echo "${BASH_REMATCH[0]//'</td>'/''}" >> $wFile
	fi
	if [[ $line =~ $regex && $found -eq 3 ]]; then
		echo "${BASH_REMATCH[0]//'</td>'/''}" >> $file
	fi
	# find <table id="main_table_countries_today"
	if [[ $line =~ $contInfoStart ]]; then
		found=1
	fi
	if [[ $line =~ $worldinfoStart ]]; then
		found=2
	fi
	if [[ $line == *"All</td>"* ]]; then
		found=3
	fi
	if [[ $line =~ $tableEnd ]]; then
		break
	fi
done < "$input"

# Remove extranious information
while IFS= read -r line
do
	newLine="${line/'</a>'/}"
	line=`echo $newLine | sed 's/ *$//g'`
	echo "$line" >> $file2
	# echo "${line//'</a>'/''}" >> $file2
done < "$file"

tail -n +4 $wFile > $wFile2
tail -n +3 $cFile > $cFile2

# Data is now cut into a format to package.

# Parsing continent information.
declare -a dataFields=("total" "newActive" "deaths" "newDeaths" "recovered" "newRecovered" "active" "critical" "name")

while IFS= read -r line
do
	if [[ i -lt 8 ]]; then
		data+="${dataFields[$i]}: \"$line\", "
	fi

	if [[ i -eq 13 ]]; then
		data+="name: \"$line\""
		name=$line
	fi

	if [[ i -eq 18 ]]; then
		let "count=count+1"
		let "i=0"

		# add to world database
		toEval='db.worldData.update({ name: "'$name'" }, {'$data'},{upsert: true});'
		mongo --eval "$toEval" world >> dbWorld
		# echo $toEval >> $cFile

		data=""
	else
		let "i=i+1"
	fi

	if [[ count -eq 6 ]]; then
		break
	fi

done < "$cFile2"



# Parsing World information.
i=0
declare -a dataFields=( "rank" "name" "total" "newActive" "deaths" "newDeaths" "recovered" "newRecovered" "active" "critical" "casesPM" "deathsPM")

while IFS= read -r line
do
	if [[ i -eq 1 ]]; then
		name=$line
	fi

	if [[ i -eq 11 ]]; then
		data+="${dataFields[$i]}: \"$line\""
		break
	else
		data+="${dataFields[$i]}: \"$line\","
		let "i=i+1"
	fi

done < "$wFile2"

# Update database
toEval='db.worldData.update({ name: "World" }, {'$data'},{upsert: true});'

# echo $toEval >> $wFile

mongo --eval "$toEval" world >> dbWorld

tail -n +4 $file2 > $file

# Parse country info
data=""
i=0
declare -a dataFields=( "rank" "name" "total" "newActive" "deaths" "newDeaths" "recovered" "newRecovered" "active" "critical" "casesPM" "deathsPM" "tests" "testsPM" "population" "continent" "casePP")

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

	if [[ $line == "N/A" ]]; then
		line=""
	fi
	if [[  $line == "" ]]; then
		if [[ i -eq 4 || i -eq 6 || i -eq 8 || i -eq 9 || i -eq 11 || i -eq 12 || i -eq 13 ]]; then
			line="N/A"
		fi
	fi

	if [[ i -eq 16 ]]; then
		data+="${dataFields[$i]}: \"$line\""

		toEval='db.countryData.update({ name: "'$name'" }, {'$data'},{upsert: true});'
		# echo $toEval >> $file2

		mongo --eval "$toEval" world >> dbCounty

		data=""
		let "i=0"
	else
		data+="${dataFields[$i]}: \"$line\","
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
rm continentInfo
rm cutContinentInfo
rm worldInfo
rm cutData
rm dbCounty
rm dbWorld