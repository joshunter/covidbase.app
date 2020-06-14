<template>
	<div class="dataRow row" id="row">
		<div class="rowNumber expend1">{{index}}</div>
		<router-link :to={name:country.name} class="rowElement link">{{country.name}}
			<div class="subNumber">{{country.population}}</div>
		</router-link>
		<div class="rowElement">{{country.total}}
			<div class="subNumber">{{country.newActive}}</div>
		</div>
		<div class="rowElement active">{{country.active}}</div>
		<div class="rowElement recovered">{{country.recovered}}
			<div class="subNumber">{{country.newRecovered}}</div>
		</div>
		<div class="rowElement critical">{{country.critical}}</div>
		<div class="rowElement deaths">{{country.deaths}}
			<div class="subNumber">{{country.newDeaths}}</div>
		</div>
		<div class="rowElement tests expend1">{{country.tests}}</div>
		<div class="rowElement expend2">{{country.casesPM}}</div>
		<div class="rowElement deaths expend3">{{country.deathsPM}}</div>
		<div class="rowElement tests expend4">{{country.testsPM}}</div>
	</div>
</template>

<script>
export default {
	name: "CountryRow",
	props: [
		"country",
		"index"
	]
}
</script>

<style>
.link {
	color: #d8dbe2;
	text-decoration: none;
	outline: 0;
}
.link:focus {
	font-weight: bolder;
	color: #ffffff;
}
.link:hover {
	font-weight: bold;
	color: #ffffff;
}
.lightMode .link {
	color: #3C3C3C;
}
.dataRow:hover {
	background-color: #234776;
}
.lightMode .dataRow:hover {
	background-color: #eaeaea;
	color: #000000;
}
.row {
	width: 100%;
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
	padding-top: 1.5px;
	padding-bottom: 1.5px;
	padding-left: 3px;
	padding-right: 3px;
}
.subNumber {
	font-size: 81%;
}
.active {
	color: #58A4B0;
}
.lightMode .active {
	color: #00a1e0;
}
.recovered {
	color:  #a0ed8c;
}
.lightMode .recovered {
	color: #2ab754;
}
.critical {
	color:  #ffaf3f;
}
.lightMode .critical {
	color:  #ff9f1a;
}
.deaths {
	color: #ff6575;
}
.lightMode .deaths {
	color: #ff4d5e;
}
.tests {
	color: #2fc3da;
}
.lightMode .tests {
	color: #22aabf;
}
/*smaller screens*/
@media only screen and (max-width: 1200px){
	.row > .expend4{
		display: none;
	}
	.row > .rowElement{
		width: calc(97%/9);
	}
}

@media only screen and (max-width: 1100px){
	.row > .expend3{
		display: none;
	}
	.row > .rowElement{
		width: calc(97%/8);
	}
}

@media only screen and (max-width: 1000px){
	.row > .expend2{
		display: none;
	}
	.row > .rowElement{
		width: calc(97%/7);
	}
}

@media only screen and (max-width: 811px){
	.row > .expend1{
		display: none;
	}
	.row > .rowElement{
		width: calc(100%/6);
	}
}

@media only screen and (max-width: 550px){
	.row {
		font-size: 85%;
	}

	.row > .rowElement{
		padding-top: 2px;
	}

	.rowElement > .subNumber {
		font-size: 69%;
	}
}

@media only screen and (max-width: 450px){
  .row {
    font-size: 70%;
  }
}
@media only screen and (max-width: 390px){
  .row {
    font-size: 65%;
  }
}
@media only screen and (max-width: 320px){
  .row {
    font-size: 62%;
  }
}
</style>