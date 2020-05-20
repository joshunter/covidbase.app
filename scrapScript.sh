#!/bin/bash

rm worldometer.html
rm worlddata
rm cutData

curl https://www.worldometers.info/coronavirus/ >> worldometer.html

input="worldometer.html"
file="worlddata"
file2="cutData"

found=0
done=0

i=0
table='<table id="main_table_countries_today"'
tableEnd='<td><strong>Total:</strong></td'
regex='\+?(\w+\s?\w*|\d*,?\d*,?\d*\s*)+</(a|td)>'

while IFS= read -r line
do
	if [[ $line =~ $regex && $found -eq 2 && $done -eq 0 ]]; then
		echo "${BASH_REMATCH[0]//'</td>'/''}" >> $file
	fi
	# find <table id="main_table_countries_today"
	if [[ $line =~ $table ]]; then
		found=1
	fi
	# find country (case sensitive)
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

rm worlddata
# cut data is done
i=0
declare -a dataFields=( "{rank: \"" "name: \"" "total: \"" "newActive: \"" "deaths: \"" "newDeaths: \"" "recovered: \"" "active: \"" "critical: \"" "casesPM: \"" "deathsPM: \"" "tests: \"" "testsPM: \"" "population: \"" "continent: \"")

while IFS= read -r line
do
	if [[ i -eq 14 ]]; then
		echo "${dataFields[$i]}$line\"}," >> $file
		let "i=0"
	else
		echo "${dataFields[$i]}$line\"," >> $file
		let "i=i+1"
	fi

done < "$file2"
