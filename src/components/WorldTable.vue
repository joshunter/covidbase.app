<template>
	<div class="worldTable">
		<div class="title">Global Data</div>
		<div class="top row">
			<div class="rowElement active">Active
					<div>{{worldInfo.active}}</div>
				<div class="subNumber">{{worldInfo.newActive}}</div>
			</div>
			<div class="rowElement recovered">Recovered
				<div>{{worldInfo.recovered}}</div>
			</div>
			<div class="rowElement critical">Critical
				<div>{{worldInfo.critical}}</div>
			</div>
			<div class="rowElement deaths">Deaths
				<div>{{worldInfo.deaths}}</div>
				<div class="subNumber">{{worldInfo.newDeaths}}</div>
			</div>
			<div class="rowElement">Total
				<div>{{worldInfo.total}}</div>
			</div>
		</div>
	</div>
</template>


<script>
export default {
	name: "WorldTable",
	props: ["worldInfo"]
}
</script>


<style>

.worldTable {
    width:90%;
    border-radius: 15px;
    background-color: #1b395d;
	color: #d8dbe2;
}

.row {
	display: flex;
    font-size: 80%;
    text-align: center;
    padding-bottom: 5px;
    padding-left: 3.5%;
    padding-right: 4%;
    padding-top: 5px;
}
.title {
    text-align: center;
	font-size: 125%;
    padding-top: 5px;
}
.rowElement {
	display: block;
    text-align: center;
	width: 20%;
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
