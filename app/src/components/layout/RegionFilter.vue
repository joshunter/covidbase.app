<template>
	<div class="FilterRow">
		<input class="searchBar" v-model="searchQuery" placeholder="Search for Country">
		<select @change="sendContChange()" id="continentSel" class="continentSel">
			<option value="Global Data" selected="selected">Global Data</option>
			<option value="Africa">Africa</option>
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
	data(){
		return {
			searchQuery: ''
		};
	},
	watch: {
		searchQuery: function (){
			this.$store.dispatch('setCountryQuery', this.searchQuery.toLowerCase());
			this.$emit('searchCountry');
		}
	},
	methods: {
		sendContChange() {
			const sel = document.getElementById("continentSel");
			const continent = sel.options[sel.selectedIndex].value;

			this.$store.dispatch('setContinent',continent);

			this.$emit('changeContinent',continent);
		}
	}
}
</script>

<style>
.FilterRow {
	width: 100%;
	display: inline-block;
	padding-top: 7px;
	padding-bottom: 2px;
}

input {
	font-size: 100%;
	background-color:  #1b395d;
	color: #d8dbe2;
	border: 1px solid #152b47;
	border-radius: 15px;
	text-align: left;
	width: 40%;
	height: 33px;
	padding-left: 12px;
	position: relative;
	right: 3.3%;
}
input:focus {
    box-shadow: 0px 0px 4px 0px #152b47;
    border:none;
}
input:hover{
    box-shadow: 0px 0px 4px 0px #152b47;
    border:none;
}
input.lightMode {
	background-color: #ffffff;
	color: #3C3C3C;
	border: 1px solid #e1e1e1;
}
input.lightMode:focus {
    box-shadow: 0px 0px 4px 0px #e1e1e1;
    border:none;
}
input.lightMode:hover {
    box-shadow: 0px 0px 4px 0px #e1e1e1;
    border:none;
}

select.continentSel {
	height: 33px;
	width: 40%;
	position: relative;
	background-color:  #1b395d;
	color: #d8dbe2;
	border-radius: 15px;
	border: 1px solid #152b47;
	left: 3.3%;
	text-align: center;

	/* styling */
	padding: 0.5em 3.5em 0.5em 1em;

	/* reset */
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	-webkit-appearance: none;
	-moz-appearance: none;

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
	box-shadow: 0px 0px 4px 0px #152b47;
	border: 1px solid #1b395d;

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
	outline: 0;
}
select.continentSel:hover {
	cursor: pointer;
	box-shadow: 0px 0px 4px 0px #152b47;
	border: 1px solid #1b395d;
}
select:-moz-focusring {
	color: transparent;
	text-shadow: 0 0 0 #d8dbe2;
}
select.lightMode {
	background-color: #ffffff;
	color: #3C3C3C;
	border: 1px solid #e1e1e1;
}
select.lightMode:focus {
	box-shadow: 0px 0px 4px 0px #e1e1e1;
	border: 1px solid #ffffff;
	outline: 0;
}
select.lightMode:hover {
	box-shadow: 0px 0px 4px 0px #e1e1e1;
	border: 1px solid #ffffff;
}
select.lightMode:-moz-focusring {
	color: transparent;
	text-shadow: 0 0 0 #3C3C3C;
}
@media only screen and (max-width: 515px){
	input.searchBar {
		padding-left: 6px;
		font-size: 75%;
	}
	.continentSel {
		font-size: 75%;
	}
}
</style>
