<template>
	<div class="dataTable">
		<div class="title">{{title}}</div>
		<div class="population" v-show="data.population">Population: {{data.population}}</div>
		<DataDisplay v-bind:data="data"/>
		<div class="bottomRow" v-show="moreData">
			<div class="countryRowPar2" v-bind:key="continent._id" v-for="continent in moreData">
				<DataDisplay v-bind:data="continent" v-show="showMore"/>
			</div>
			<button class="arrowButton" id="arrowButton" @click="toggleExpand()"><i id="icon" class="Arrow down"></i></button>
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
			document.getElementById("arrowButton").blur();

			if(this.showMore == false){
				document.getElementById("icon").classList.remove("down");
				document.getElementById("icon").classList.add("up");

				this.showMore=true;
			}
			else {
				document.getElementById("icon").classList.remove("up");
				document.getElementById("icon").classList.add("down");

				this.showMore=false;
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
	height: 24px;
}
button.arrowButton{
    background-color: #1b395d;
	color: #d8dbe2;
	border: 0;
	height: 17px;
	width: 25px;
}
button.arrowButton:hover{
	cursor: pointer;
}
button.arrowButton:focus {
	outline: 1px solid #FFFFFF;
}
button.arrowButton:active {
	outline: 0;
}
button.arrowButton:-moz-focusring {
	color: transparent;
}
.lightMode button.arrowButton:focus {
	outline: 2px solid #3C3C3C;
}
.lightMode button.arrowButton:active {
	outline: 0;
}
.lightMode .arrowButton {
	background-color: #ffffff;
	border: none;
	box-shadow: none;
}
.Arrow {
	border: solid #d8dbe2;
	border-width: 0 3px 3px 0;
	display: inline-block;
	padding: 4px;
}

.down {
	transform: rotate(45deg);
	-webkit-transform: rotate(45deg);
}

.up {
	transform: rotate(-135deg);
	-webkit-transform: rotate(-135deg);
}
</style>
