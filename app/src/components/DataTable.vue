<template>
	<div class="dataTable">
		<div class="title">{{title}}</div>
		<div class="population" v-show="data.population">Population: {{data.population}}</div>
		<DataDisplay v-bind:data="data"/>
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
	box-shadow: 0px 0px 4px 0px #182a43;
	border-radius: 10px;
	width: 20px;
	height: 20px;
	font-size: 110%;
	margin: 5px;
	outline: 0;
	border: none;
	vertical-align: center;
	text-decoration: none;
}
.showButton:hover {
	cursor: pointer;
	box-shadow: 0px 0px 2px 0px #182a43;
	background-color:  #20406a;
	color: #bcc1cd;
}

.showButton:active {
	background-color:  #183353;
	box-shadow: none;
	border: 1px solid #182a43;
}
.showButton:-moz-focusring {
	color: transparent;
	text-shadow: 0 0 0 #bcc1cd;
}

.lightMode .showButton {
	background-color: #FFFFFF;
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

@media only screen and (max-width: 550px){button.showButton{font-size: 85%;}}

@media only screen and (max-width: 465px){button.showButton{font-size: 75%;}}

@media only screen and (max-width: 360px){button.showButton{font-size: 66%;}}
</style>
