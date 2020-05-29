#!/bin/bash

# On start script, cd {{projectname}} then
# gnome-terminal -e "node server/index.js"
# gnome-terminal -e "npm run serve"
# 52.13.183.45
# bash scrapScript; end of startscript

rm worldometer.html
rm countryData
rm worldInfo
rm cutData
rm cutWorldInfo

curl https://www.worldometers.info/coronavirus/ >> worldometer.html

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
worldinfoStart='<td style="display:none;" data-continent=""></td>'
table='<table id="main_table_countries_today"'
tableEnd='<td><strong>Total:</strong></td'
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

# rm countryData
# cut data is done

# Global information
tail -n +4 $wFile > $wFile2

i=0
declare -a dataFields=( "{rank: \"0" "name: \"" "total: \"" "newActive: \"" "deaths: \"" "newDeaths: \"" "recovered: \"" "newRecovered: \"" "active: \"" "critical: \"" "casesPM: \"" "deathsPM: \"")

while IFS= read -r line
do
	if [[ i -eq 11 ]]; then
		data+="${dataFields[$i]}$line\"}"
		break
	else
		data+="${dataFields[$i]}$line\","
		let "i=i+1"
	fi

done < "$wFile2"
#update database
toEval='db.worldData.insert('$data');'
# toEval='db.worldData.update({ name: "World" }, '$data');'
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

		# toEval='db.countryData.update({ name: "'$name'" }, '$data');'
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


rm worldometer.html
rm countryData
rm worldInfo
rm cutData