#!/bin/bash

# Start clean
rm worldometerUS.html
rm usStateData
rm usInfo
rm cutUSInfo

# Pull the site with new data
curl https://www.worldometers.info/coronavirus/country/us/ > worldometerUS.html

# Files used to hold data temporarily
input="worldometerUS.html"
usFile="usInfo"
usFile2="cutUSInfo"
newFile="file"
data=""

found=0

# Keys that let me know when to start/stop saving data
table='<table id="usa_table_countries_today"'
tableEnd='<td><strong>Total:</strong></td'

# Regular Expression to grab data
regex='\+?(\s?\w+|\d*,?\d*,?\d*\s*)+</(a|td)>'

while IFS= read -r line
do
	if [[ $line =~ $regex && $found -eq 1 ]]; then
		echo "${BASH_REMATCH[0]//'</td>'/}" >> $usFile
	fi

	# find main table<table id="usa_table_countries_today"
	if [[ $line =~ $table ]]; then
		found=1
	fi

	if [[ $line =~ $tableEnd ]]; then
		break
	fi
done < "$input"

# Remove extranious info
while IFS= read -r line
do
	if [[ $line == *"projections"* ]]; then
		:
	else
		newLine="${line/'</a>'/}"
		line=`echo $newLine | sed 's/ *$//g'`
	 	echo "$line" >> $usFile2
	fi
done < "$usFile"

tail -n +13 $usFile2 > $usFile
# Data is now cut into a format to package and upload.

i=0
declare -a dataFields=("name" "total" "newActive" "deaths" "newDeaths" "active" "casesPM" "deathsPM" "tests" "testsPM")
states=()

while IFS= read -r line
do
	if [[ i -eq 0 ]]; then
		name=$line
		states[${#states[@]}]=$name
	fi

	if [[ $line == "N/A" ]]; then
		line=""
	fi

	if [[ $line == "" ]]; then
		if [[ i -eq 3 || i -eq 5 || i -eq 6 || i -eq 7 || i -eq 8 || i -eq 9 ]] ; then
			line="N/A"
		fi
	fi

	if [[ i -lt 9 ]]; then
		data+="${dataFields[$i]} : \"$line\", "
	fi

	if [[ i -eq 9 ]]; then
		data+="${dataFields[$i]} : \"$line\""


		toEval='db.usData.update({ name: "'$name'" }, {'$data'},{upsert: true});'
		# echo $toEval >> $usFile2
 		mongo --eval "$toEval" world >> usStateData

		data=""
	fi

	let "i=i+1"

	if [[ i -eq 12 ]]; then
		let "i=0"
	fi
done < "$usFile"

declare -a dataFields=("name" "total" "newActive" "deaths" "newDeaths" "active" "tests")
input="worldometerUSstate.html"

for state in "${states[@]}"
do
	rm $usFile
	rm $usFile2
	URLstate="${state//' '/'-'}"
	curl https://www.worldometers.info/coronavirus/usa/$URLstate/ > worldometerUSstate.html

	while IFS= read -r line
	do
		if [[ $line =~ $regex && $found -eq 1 ]]; then
			echo "${BASH_REMATCH[0]//'</td>'/}" >> $usFile
		fi

		# find main table<table id="usa_table_countries_today"
		if [[ $line =~ $table ]]; then
			found=1
		fi

		if [[ $line =~ $tableEnd ]]; then
			break
		fi
	done < "$input"


	# Remove extranious info
	while IFS= read -r line
	do
		if [[ $line == *"</a>"* ]]; then
			:
		else
			newLine="${line/'</a>'/}"
			line=`echo $newLine | sed 's/ *$//g'`
		 	echo "$line" >> $usFile2
		fi
	done < "$usFile"

	tail -n +9 $usFile2 > $usFile
	head -n -2 $usFile > $usFile2
	# Data is now cut into a format to package and upload.

	data="state: \"$state\", data : ["
	i=0
	while IFS= read -r line
	do
		if [[ i -eq 0 ]]; then
			name=$line
			data+="{"
		fi

		if [[ $line == "N/A" ]]; then
			line=""
		fi

		if [[ $line == "" ]]; then
			if [[ i -eq 1 || i -eq 3 || i -eq 5 || i -eq 6 ]] ; then
				line="N/A"
			fi
		fi

		if [[ i -lt 6 ]]; then
			data+="${dataFields[$i]} : \"$line\", "
		fi

		if [[ i -eq 6 ]]; then
			data+="${dataFields[$i]} : \"$line\"},"


		fi

		let "i=i+1"

		if [[ i -eq 7 ]]; then
			let "i=0"
		fi
	done < "$usFile2"

	data="${data%?}]"
	toEval='db.statesDat.aupdate({ state: "'$state'" }, {'${data%?}']},{upsert: true});'
	echo $toEval >> $newFile
	mongo --eval "$toEval" world >> statesData

done


# Remove empty
# toEval='db.countryData.remove({ state: "" });'
# mongo --eval "$toEval" world >> dbCounty


# Clean up
rm worldometerUS.html
rm worldometerUSstate.html
rm usStateData
rm usInfo
rm cutUSInfo
