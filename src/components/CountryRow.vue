<template>
	<div class="row">
		<div class="rowNumber">{{country.rank}}</div>
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
		<div class="rowElement">{{country.total}}</div>
		<div class="rowElement">{{country.tests}}</div>
	</div>
</template>

<script>
export default {
	name: "CountryRow",
	props: ["country"]
}
</script>


<style scoped>
.row {
	display:inline-block;
	width: 100%;
    padding-top: 7px;
    padding-bottom: 7px;
    text-align: center;
    vertical-align: top;
    font-size: 80%
}
.rowElement {
	display: inline-block;
    vertical-align: top;
	width: 14%;
	padding-left: 1%;
}
.rowNumber {
	display: inline-block;
	width: 2%;
	padding-right: 1%;
}
.subNumber {
	font-size: 81%;
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

</style>