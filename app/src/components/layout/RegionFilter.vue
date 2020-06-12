<template>
	<div class="FilterRow">
		<input class="searchBar" id="searchBar" v-model="searchRequest" placeholder="Search for Country">
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
	data(){
		return {
			searchRequest: ''
		};
	},
	methods: {
		sendContChange() {
			const sel = document.getElementById("continentSel");
			const option = sel.options[sel.selectedIndex].value;
			this.$emit('changeContinent',option);
		}
	},
	updated: function(){
		this.$emit('searchCountry', this.searchRequest);
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

input.searchBar {
	font-size: 100%;
	background-color:  #1b395d;
	color: #d8dbe2;
	border: 1px solid #152b47;
	border-radius: 15px;
	text-align: left;
	width: 40%;
	padding-left: 12px;
	padding-top: 7px;
	padding-bottom: 7px;
	margin-left: 3%;
	margin-right: 2%;
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
input.lightMode:hover {
    box-shadow: 0px 0px 4px 0px #e1e1e1;
    border:none;
}

select.continentSel {
	margin-top: 3px;
	padding-bottom: 3px;
	font-size: 100%;
	width: 50%;
	position: relative;
	border: none;
	background-color:  #1b395d;
	color: #d8dbe2;
    border-radius: 15px;
	padding-top: 7px;
	padding-bottom: 7px;
	border: 1px solid #152b47;

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
select.continentSel:hover {
	cursor: pointer;
    box-shadow: 0px 0px 4px 0px #152b47;
    border:none;
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
select.lightMode:hover {
    box-shadow: 0px 0px 4px 0px #e1e1e1;
    border:none;
}

@media only screen and (max-width: 500px){
	input.searchBar {
		padding-left: 6px;
		font-size: 75%;
	}
	.continentSel {
		font-size: 75%;
	}
}
</style>
