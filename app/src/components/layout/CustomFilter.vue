<template>
	<div class="FilterRow">
		<input class="searchBar" id="stateSearchBar" v-model="searchQuery" placeholder="Search for State">
	</div>
</template>

<script>

export default {
	name: "CustomFilter",
	data(){
		return {
			searchQuery: ''
		};
	},
	watch: {
		searchQuery: function (){
			this.$store.dispatch('setStatesQuery', this.searchQuery.toLowerCase());
			this.$emit('search',this.searchQuery);
		}
	}
}
</script>

<style scoped>
.FilterRow {
	width: 100%;
	display: inline-block;
	padding-top: 7px;
	padding-bottom: 2px;
	background-color: transparent;
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
	right: 22%;
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

@media only screen and (max-width: 465px){
	input.searchBar {
		padding-left: 6px;
		font-size: 80%;
	}
}
</style>
