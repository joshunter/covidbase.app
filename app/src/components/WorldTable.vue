<template>
	<div class="worldTable">
		<div class="title">Global Info</div>
		<div class="worldRow" id="worldRow">
			<div class="rowElement">Total Cases
				<div>{{worldData.total}}</div>
				<div class="subNumber">{{worldData.newActive}}</div>
			</div>
			<div class="rowElement active">Active
					<div>{{worldData.active}}</div>
			</div>
			<div class="rowElement recovered">Recovered
				<div>{{worldData.recovered}}</div>
				<div class="subNumber">{{worldData.newRecovered}}</div>
			</div>
			<div class="rowElement critical">Critical
				<div>{{worldData.critical}}</div>
			</div>
			<div class="rowElement deaths">Deaths
				<div>{{worldData.deaths}}</div>
				<div class="subNumber">{{worldData.newDeaths}}</div>
			</div>
			<div class="rowElement expend1">Cases/1M
				<div>{{worldData.casesPM}}</div>
			</div>
			<div class="rowElement deaths expend2">Deaths/1M
				<div>{{worldData.deathsPM}}</div>
			</div>
		</div>
	</div>
</template>


<script>
export default {
	name: "WorldTable",
	props: ["worldData"]
}
</script>


<style scoped>

.worldTable {
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
.worldRow {
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
.rowElement {
    text-align: center;
	width: calc(100%/7);
	padding-left: 2%;
	padding-right: 2%;
	vertical-align: top;
	display: inline-block;
}
.subNumber {
	font-size: 81%;
}

@media only screen and (max-width: 1100px){
	.worldRow > .expend2{
		display: none;
	}
	.worldRow > .rowElement{
		width: calc(100%/6);
	}
}

@media only screen and (max-width: 811px){
	.worldRow > .expend1{
		display: none;
	}
	.worldRow > .rowElement{
		width: calc(100%/5);
	}
}

@media only screen and (max-width: 550px){
  .worldRow {
    font-size: 85%;
  }
  .title{font-size: 105%;}
}

@media only screen and (max-width: 450px){
  .worldRow {
    font-size: 70%;
  }
}
@media only screen and (max-width: 390px){
  .worldRow {
    font-size: 65%;
  }
}
@media only screen and (max-width: 320px){
  .worldRow {
    font-size: 62%;
  }
}

</style>
