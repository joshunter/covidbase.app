<template>
	<div class="row">
		<div class="rowElement generic">{{country.name}}</div>
		<div class="rowElement active">{{country.active}}
			<div class="subNumber">{{country.newActive}}</div>
		</div>
		<div class="rowElement recovered">{{country.recovered}}</div>
		<div class="rowElement critical">{{country.critical}}</div>
		<div class="rowElement deaths">{{country.deaths}}
			<div class="subNumber">{{country.newDeaths}}</div>
		</div>
		<div class="rowElement generic">{{country.total}}</div>
		<div class="rowElement generic">{{country.tests}}</div>
	</div>
</template>

<script>
export default {
	name: "Country",
	props: ["country"]
}
</script>


<style scoped>
.subNumber {
	font-size: 81%;
}
</style>