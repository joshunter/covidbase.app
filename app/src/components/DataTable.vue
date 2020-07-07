<template>
	<div class="dataTable">
		<div class="title">{{title}}</div>
		<div class="population" v-show="data.population">Population: {{data.population}}</div>
		<DataDisplay v-bind:data="data"/>
<!-- 		<div class="countryRowPar2" v-bind:key="index" v-for="(continent, index) in moreData">
			<DataDisplay v-bind:data="moreData.data" v-bind:title="moreData.name" v-show="showMore"/>
		</div>  -->
<!-- 		<div class="countryRowPar2" v-show="showMore">
			<DataDisplay v-bind:data="data" v-bind:title="data.name" />
			<DataDisplay v-bind:data="data" v-bind:title="'Asia'"/>
			<DataDisplay v-bind:data="data" v-bind:title="'Australia'"/>
			<DataDisplay v-bind:data="data" v-bind:title="'Europe'"/>
			<DataDisplay v-bind:data="data" v-bind:title="'North America'"/>
			<DataDisplay v-bind:data="data" v-bind:title="'South America'"/>
		</div>  -->
		<div class="bottomRow" v-show="moreData">
			<button class="showButton" id="showMoreButton" @click="toggleExpand()">+</button>
		</div>
	</div>
</template>


<script>
import DataDisplay from './DataDisplay.vue';

export default {
	name: "DataTable",
	components: {
		DataDisplay
	},
	props: ["data", "moreData", "title"],
	data(){
		return {
			showMore: false
		}
	},
	methods: {
		toggleExpand(){
			document.getElementById("showMoreButton").blur();

			if(this.showMore == false){
				this.showMore=true;
				document.getElementById("showMoreButton").innerHTML = "-";
			}
			else {
				this.showMore=false;
				document.getElementById("showMoreButton").innerHTML = "+";
			}

		}
	}
}
</script>


<style scoped>
.dataTable {
    width:90%;
	display: inline-block;
	margin-top: 1.25%;
	margin-bottom: 1.25%;
    border-radius: 7px;
    background-color: #1b395d;
	color: #d8dbe2;
    box-shadow: 0px 0px 10px 1px #182a43;
}
.lightMode {
	background-color: #ffffff;
	color: #3C3C3C;
    box-shadow: 0px 0px 10px 1px #e1e1e1;
}
.title {
	text-align: center;
	font-size: 140%;
	padding-top: 5px;
}
.population {
	font-size: 110%;
}
.bottomRow {
	height: 30px;
}

button.showButton {
	position: static;
	background-color: #24497a;
	color: #d8dbe2;
	border-radius: 10px;
	font-size: 110%;
	width: 20px;
	height: 20px;
	margin: 5px;
	outline: 0;
	border: none;
	vertical-align: center;
	text-decoration: none;
}
button.showButton:hover {
	cursor: pointer;
}

.showButton:hover {
	background-color:  #20406a;
	color: #bcc1cd;
}

.showButton:active {
	background-color:  #183353;
}
.showButton:-moz-focusring {
	color: transparent;
	text-shadow: 0 0 0 #bcc1cd;
}

.lightMode .showButton {
	background-color:  #fff;
	color: #3C3C3C;
    box-shadow: 0px 0px 3px 1px #e1e1e1;
}

.lightMode .showButton:hover {
	background-color:  #fcfcfc;
    box-shadow: 0px 0px 3px 0px #e1e1e1;
}

.lightMode .showButton:active {
	background-color:  #fcfcfc;
    box-shadow: none;
    border: 1px solid #e1e1e1;
}

.lightMode .showButton:-moz-focusring {
	text-shadow: 0 0 0 #3C3C3C;
}

button:focus {outline: 1px solid #FFF;}
.lightMode button:focus {outline: 1px solid #000;}
button:active {outline: 0;}
.lightMode button:active {outline: 0;}

button:-moz-focusring {
  color: transparent;
  text-shadow: 0 0 0 #d8dbe2;
}

@media only screen and (max-width: 550px){.showButton{font-size: 105%;}}
@media only screen and (max-width: 465px){.showButton{font-size: 100%;}}
@media only screen and (max-width: 400px){.showButton{font-size: 97%;}}
@media only screen and (max-width: 360px){.showButton{font-size: 96%;}}
@media only screen and (max-width: 340px){.showButton{font-size: 88%;}}
</style>
