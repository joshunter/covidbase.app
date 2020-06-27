<template>
	<div class="dataRow row" id="row">
		<div class="rowNumber expend1">{{index}}</div>
<!-- 		<router-link :to={path:data.name} class="rowElement link">{{data.name}}
			<div class="subNumber" v-show="data.population">{{data.population}}</div>
		</router-link> -->
		<router-link v-show="data.name=='USA'" :to={path:data.name} class="rowElement link">{{data.name}}
			<div class="subNumber" v-show="data.population">{{data.population}}</div>
		</router-link>
		<div v-show="data.name!='USA'" class="rowElement">{{data.name}}
			<div class="subNumber" v-show="data.population">{{data.population}}</div>
		</div>
		<div class="rowElement" v-show="data.total">{{data.total}}
			<div class="subNumber" v-show="data.newActive">{{data.newActive}}</div>
		</div>
		<div class="rowElement active" v-show="data.active">{{data.active}}</div>
		<div class="rowElement recovered" v-show="data.recovered">{{data.recovered}}
			<div class="subNumber" v-show="data.newRecovered">{{data.newRecovered}}</div>
		</div>
		<div class="rowElement critical" v-show="data.critical">{{data.critical}}</div>
		<div class="rowElement deaths" v-show="data.deaths">{{data.deaths}}
			<div class="subNumber" v-show="data.newDeaths">{{data.newDeaths}}</div>
		</div>
		<div class="rowElement tests expend1" v-show="data.tests">{{data.tests}}</div>
		<div class="rowElement expend2" v-show="data.casesPM">{{data.casesPM}}</div>
		<div class="rowElement deaths expend3" v-show="data.deathsPM">{{data.deathsPM}}</div>
		<div class="rowElement tests expend4" v-show="data.testsPM">{{data.testsPM}}</div>
	</div>
</template>

<script>
export default {
	name: "DataRow",
	props: [
		"data",
		"index"
	]
}
</script>

<style>
.link {
	color: #fff;
	text-decoration: none;
	outline: 0;
}
.link:hover {
	color: #ffffff;
	text-decoration: underline;
}
.lightMode .link {color: #3C3C3C;}

.dataRow {background-color: transparent;}

.dataRow:hover {
	color: #ffffff;
	background-color: #234776;
}
.lightMode .dataRow:hover {
	background-color: #eaeaea;
	color: #000000;
}

.row {
	width: 100%;
	min-height: 47px; 
    padding-top: 5px;
	padding-bottom: 5px;
	display: block;
}

.rowElement {
	vertical-align: top;
	display: inline-block;
	width: calc(96%/10);
	padding-top: 1.5px;
	padding-bottom: 1.5px;
	padding-left: 3px;
	padding-right: 3px;
}

.rowNumber {
	display: inline-block;
	width: 3%;
	padding-top: 3px;
	padding-bottom: 1.5px;
	padding-left: 3px;
	padding-right: 3px;
}

.subNumber {font-size: 81%;}

.active {color: #58A4B0;}
.lightMode .active {color: #00a1e0;}
.recovered {color:  #a0ed8c;}
.lightMode .recovered {color: #2ab754;}
.critical {color:  #ffaf3f;}
.lightMode .critical {color:  #ff9f1a;}
.deaths {color: #ff6575;}
.lightMode .deaths {color: #ff4d5e;}
.tests {color: #2fc3da;}
.lightMode .tests {color: #22aabf;}

/*smaller screens*/
@media only screen and (max-width: 1200px){
	.row > .expend4{display: none;}
	.row > .rowElement{width: calc(97%/9);}
}
@media only screen and (max-width: 1100px){
	.row > .expend3{display: none;}
	.row > .rowElement{width: calc(97%/8);}
}
@media only screen and (max-width: 1000px){
	.row > .expend2{display: none;}
	.row > .rowElement{width: calc(97%/7);}
}
@media only screen and (max-width: 811px){
	.row > .expend1{display: none;}
	.row > .rowElement{width: calc(100%/6);}
}
@media only screen and (max-width: 550px){
	.row {font-size: 85%;}
	.row > .rowElement{padding-top: 2px;}
	.rowElement > .subNumber {font-size: 69%;}
}
@media only screen and (max-width: 465px){.row {font-size: 70%;}}
@media only screen and (max-width: 400px){.row {font-size: 65%;}}
@media only screen and (max-width: 360px){.row {font-size: 62%;}}
@media only screen and (max-width: 340px){.row {font-size: 58%;}}

</style>