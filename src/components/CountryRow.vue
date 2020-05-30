<template>
	<div class="row" id="row">
		<div class="rowNumber expend1">{{country.rank}}</div>
		<div class="rowElement">{{country.name}}
			<div class="subNumber">{{country.population}}</div>
		</div>
		<div class="rowElement active">{{country.active}}
			<div class="subNumber">{{country.newActive}}</div>
		</div>
		<div class="rowElement recovered">{{country.recovered}}
			<div class="subNumber">{{country.newRecovered}}</div>
		</div>
		<div class="rowElement critical">{{country.critical}}</div>
		<div class="rowElement deaths">{{country.deaths}}
			<div class="subNumber">{{country.newDeaths}}</div>
		</div>
		<div class="rowElement deaths expend4">{{country.deathsPM}}</div>
		<div class="rowElement">{{country.total}}</div>
		<div class="rowElement expend2">{{country.casesPM}}</div>
		<div class="rowElement tests expend1">{{country.tests}}</div>
		<div class="rowElement tests expend3">{{country.testsPM}}</div>
	</div>
</template>

<script>
export default {
	name: "CountryRow",
	props: [
		"country"
	]
}
</script>


<style>
.expend4{
	display: visible;
}
.expend3{
	display: visible;
}
.expend2{
	display: visible;
}
.expend1{
	display: visible;
}
.row {
	width: 100%;
    padding-top: 5px;
	padding-bottom: 5px;
	display: block;
    vertical-align: top;
    font-size: 100%
}
.row > .rowElement {
	vertical-align: top;
	display: inline-block;
	width: calc(96%/10);
	padding-top: 4px;
	padding-left: 3px;
	padding-right: 3px;
}
.subNumber {
	font-size: 81%;
}
.row > .rowNumber {
	vertical-align: top;
	display: inline-block;
	width: 3%;
	padding-top: 4px;
	padding-left: 3px;
	padding-right: 3px;
}
.active {
	color: #58A4B0;
}
.recovered {
	color:  #a0ed8c;
}
.critical {
	color:  #ffaf3f;
}
.deaths {
	color: #ff6575;
}
.tests {
	color: #2fc3da;
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
@media only screen and (max-width: 500px){
	.row {
		font-size: 75%;
	}

	.row > .rowElement{
		padding-top: 2px;
	}

	.rowElement > .subNumber {
		font-size: 69%;
	}
}
@media only screen and (max-width: 370px){
  .row {
    font-size: 65%;
  }
}
</style>