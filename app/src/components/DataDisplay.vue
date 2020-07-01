<template>
	<div class="displayRow" id="displayRow">
		<div class="rowElement population2" v-show="data.population">
			Population
			<div>{{data.population}}</div>
		</div>
		<div class="rowElement" v-show="data.total">Total Cases
			<div>{{data.total}}</div>
			<div class="subNumber">{{data.newActive}}</div>
		</div>
		<div class="rowElement active" v-show="data.active">Active
				<div>{{data.active}}</div>
		</div>
		<div class="rowElement recovered" v-show="data.recovered">Recovered
			<div>{{data.recovered}}</div>
			<div class="subNumber">{{data.newRecovered}}</div>
		</div>
		<div class="rowElement critical" v-show="data.critical">Critical
			<div>{{data.critical}}</div>
		</div>
		<div class="rowElement deaths" v-show="data.deaths">Deaths
			<div>{{data.deaths}}</div>
			<div class="subNumber">{{data.newDeaths}}</div>
		</div>
		<div class="rowElement tests" v-show="data.tests"> Tests
			<div>{{data.tests}}</div>
		</div>
		<div class="rowElement expend1" v-show="data.casesPM">Cases/1M
			<div>{{data.casesPM}}</div>
		</div>
		<div class="rowElement deaths expend2" v-show="data.deathsPM">Deaths/1M
			<div>{{data.deathsPM}}</div>
		</div>
		<div class="rowElement tests" v-show="data.testsPM">Tests/1M
			<div>{{data.testsPM}}</div>
		</div>
	</div>
</template>


<script>
export default {
	name: "DataDisplay",
	props: ["data"]
}
</script>


<style scoped>
.lightMode {
	background-color: #ffffff;
	color: #3C3C3C;
	box-shadow: 0px 0px 10px 1px #e1e1e1;
}

.displayRow {
	width: 100%;
	display: inline-block;
	font-size: 100%;
	text-align: center;
	padding-bottom: 5px;
}

.title {
	text-align: center;
	font-size: 140%;
	padding-top: 5px;
}

.population {font-size: 110%;}

.subNumber {font-size: 81%;}

.rowElement {
	display: inline-block;
	text-align: center;
	vertical-align: top;
	width: calc(100%/7);
	padding-left: 2%;
	padding-right: 2%;
	padding-top: 1.5%;
}

</style>
