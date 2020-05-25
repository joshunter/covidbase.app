<template>
	<div class="row">
		<input class="searchBar" id="searchBar" placeholder="Search for Country">
		<select @change="sendContChange()" id="continentSel" class="continentSel">
			<option value="Global Data" selected="selected">Global Data</option>
			<option value="Africa">Africa</option>
			<option value="Antarctica">Antarctica</option>
			<option value="Asia">Asia</option>
			<option value="Australia/Oceania">Australia/Oceania</option>
			<option value="Europe">Europe</option>
			<option value="North America">North America</option>
			<option value="South America">South America</option>
		</select>
	</div>
</template>

<script>

export default {
	name: "RegionFilter",
	// data(){
	// 	return {
	// 		searchBar: document.getElementById('searchBar').value
	// 	};
	// },
	methods: {
		sendContChange() {
			const sel = document.getElementById("continentSel");
			const option = sel.options[sel.selectedIndex].value;
			this.$emit('changeContinent',option);
		},
		sendSearch() {
			// var search = document.getElementById("searchBar").value;
			// this.$emit('searchCountry', search);
			console.log(this.searchBar);
		}
	}
	// watch: {
	// 	searchBar : {
	// 		handler: 'sendSearch',
	// 		immediate: false
	// 	}
	// }
}
</script>

<style>
input.searchBar {
	background-color:  #1b395d;
	color: #d8dbe2;
	border: 1px solid #152b47;
	border-radius: 15px;
	text-align: left;
	padding-left: 10px;
	width: 38%;
}

.continentSel {
	width: 62%;
	position: relative;
	border: none;
	background-color:  #1b395d;
	color: #d8dbe2;
    border-radius: 15px;
	padding-top: 7px;
	padding-bottom: 7px;

	/* styling */
	display: inline-block;
	line-height: 1.5em;
	padding: 0.5em 3.5em 0.5em 1em;

	/* reset */

	margin: 0;      
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	-webkit-appearance: none;
	-moz-appearance: none;
}

select.continentSel {
	background-image:
		linear-gradient(45deg, transparent 50%, #d8dbe2 50%),
		linear-gradient(135deg, #d8dbe2 50%, transparent 50%),
		linear-gradient(to right, #d8dbe2, #d8dbe2);
	background-position:
		calc(100% - 20px) calc(1em + 2px),
		calc(100% - 15px) calc(1em + 2px),
		calc(100% - 2.5em) 0.5em;
	background-size:
		5px 5px,
		5px 5px,
		1px 1.5em;
	background-repeat: no-repeat;
}

select.continentSel:focus {
	background-image:
		linear-gradient(45deg, #d8dbe2 50%, transparent 50%),
		linear-gradient(135deg, transparent 50%, #d8dbe2 50%),
		linear-gradient(to right, #d8dbe2, #d8dbe2);
	background-position:
		calc(100% - 15px) 1em,
		calc(100% - 20px) 1em,
		calc(100% - 2.5em) 0.5em;
	background-size:
		5px 5px,
		5px 5px,
		1px 1.5em;
	background-repeat: no-repeat;
	border-color: #1b395d;
	outline: 0;
}

select:hover {
	background-color:  #152b47;
	cursor: pointer;
}

select:-moz-focusring {
  color: transparent;
  text-shadow: 0 0 0 #d8dbe2;
}
</style>
