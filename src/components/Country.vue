<template>
	<div class="row">
		<div class="name">{{country.name}}</div>
		<div class="active">{{country.active}}</div>
		<div class="recovered">{{country.recovered}}</div>
		<div class="deaths">{{country.deaths}}</div>
		<div class="total">{{country.total}}</div>
	</div>
</template>

<script>
export default {
	name: "Country",
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
    font-size: 80%
}
.row > .name {
	display:inline-block;
	width: 16%;
	margin-left: 2%;
	margin-right: 2%;
	text-align: center;
}
.row > .active {
	display:inline-block;
	width: 16%;
	margin-left: 2%;
	margin-right: 2%;
	text-align: center;
	color: #58A4B0;
}
.row > .recovered {
	display:inline-block;
	width: 16%;
	margin-left: 2%;
	margin-right: 2%;
	text-align: center;
	color:  #a0ed8c;
}
.row > .deaths {
	display:inline-block;
	width: 16%;
	margin-left: 2%;
	margin-right: 2%;
	text-align: center;
	color: #ff6575;
}
.row > .total {
	display:inline-block;
	width: 16%;
	margin-left: 2%;
	margin-right: 2%;
	text-align: center;
}
</style>