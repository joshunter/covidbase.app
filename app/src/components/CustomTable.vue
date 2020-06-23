<template>
	<div class="Datatable" id="Datatable">
		<CustomFilter @search="search($event)"/>
		<div class="row headerRow" id="headerRow">
			<div class="rowNumber headerElement expend1">
				<div id="rank" class="rowRankB">#
				</div>
			</div>
			<div class="rowElement headerElement">
				<button id="name" class="country nameButton" @click="sortBy('name')">State
				</button>
			</div>
			<div class="rowElement headerElement">
				<button id="total" class="totalButton" @click="sortBy('total')">Total Cases
				</button>
			</div>
			<div class="rowElement headerElement">
				<button id="active" class="active activeButton" @click="sortBy('active')">Active
				</button>
			</div>
			<div class="rowElement headerElement">
				<button id="deaths" class="deaths deathsButton" @click="sortBy('deaths')">Deaths
				</button>
			</div>
			<div class="rowElement headerElement tests expend1">
				<button id="tests" class="tests testsButton" @click="sortBy('tests')">Tests
				</button>
			</div>
			<div class="rowElement headerElement expend2">
				<button id="casesPM" class="casesPMButton" @click="sortBy('casesPM')">Cases/1M
				</button>
			</div>
			<div class="rowElement headerElement expend3">
				<button id="deathsPM" class="deaths deathsPMButton" @click="sortBy('deathsPM')">Deaths/1M
				</button>
			</div>
			<div class="rowElement headerElement expend4">
				<button id="testsPM" class="tests testsPMButton" @click="sortBy('testsPM')">Tests/1M
				</button>
			</div>
		</div>
		<div class="countryRowPar" v-bind:key="datum._id+'global'" v-for="(datum, index) in data">
				<DataRow v-bind:index="index+1" v-bind:data="datum" v-show="show=='all' && index < showing"/>
		</div>
		<div class="countryRowPar" v-bind:key="datum._id+'search'" v-for="(datum, index) in searchedData">
				<DataRow v-bind:index="index+1" v-bind:data="datum" v-show="show=='search' && index < showing"/>
		</div>
		<div class="bottomRow">
			<span><button class="showButton" id="min" style="left: 7%;" @click="showMin()">Minimize</button></span>
			<span><button class="arrowButton" id="more" @click="showMore()"><i class="Arrow down"></i></button></span>
			<span><button class="arrowButton" id="less" @click="showLess()"><i class="Arrow up"></i></button></span>
			<span><button class="showButton" id="all" style="right: 7%;" @click="showAll()">All</button></span>
		</div>
	</div>
</template>

<script>
import DataRow from './DataRow.vue';
import CustomFilter from './layout/CustomFilter.vue';

export default{
name:"CustomTable",
components: {
	DataRow
,	CustomFilter
},
props: [ "data", "searchedData" ],
data(){
	return {
		show: 'all',
		showing: 20
	};
},
mounted() {
		sessionStorage.setItem('prevShow', this.show);
		sessionStorage.setItem('sortedBy', 'totalD');
},
methods: {
	showMin(){
		document.getElementById("min").blur();
		this.showing = 20;
	},
	showMore(){
		document.getElementById("more").blur();
		this.showing += 20;

		if(this.showing > 214)
			this.showing = 214;
	},
	showLess(){
		document.getElementById("less").blur();
		if(this.showing-20 >= 20)
			this.showing -= 20;
		else
			this.showing = 20;
	},
	showAll(){
		document.getElementById("all").blur();
		this.showing = 214;
	},
	search(query) {
		this.show='search';
		if(query=='') {
			this.show='all';
		}


		this.$store.dispatch('searchStatesData');
	},
	sortBy(type){
		let sortedBy = sessionStorage.getItem('sortedBy');
		let id = sortedBy.substring(0, sortedBy.length - 1);

		let el = document.getElementById(id);
		//replace arrows for current column.
		el.style.fontWeight = "normal";
		el.innerHTML = el.innerHTML.substring(0, el.innerHTML.length - 1);

		switch(type){
			case "name":
				el = document.getElementById("name");

				el.style.fontWeight = "bold";
				if(sortedBy=='nameA'){
					el.innerHTML='State&#8593;'
				} else {
					el.innerHTML='State&#8595;'
				}
				this.data.sort(function (a, b) {
					if(sortedBy=='nameA'){
						sessionStorage.setItem('sortedBy', 'nameD');
						if (a.name < b.name) {
							return 1;
						}
						if (a.name > b.name) {
							return -1;
						}
					}
					sessionStorage.setItem('sortedBy', 'nameA');
					if (a.name < b.name) {
						return -1;
					}
					if (a.name > b.name) {
						return 1;
					}
				});
				break;
			case "population":
				el = document.getElementById("population");

				el.style.fontWeight = "bold";

				if(sortedBy=='populationD'){
					el.innerHTML='Population&#8593;'
				} else {
					el.innerHTML='Population&#8595;'
				}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.population.replace(/\D/g,''));
					var num2 = parseInt(b.population.replace(/\D/g,''));

					if(num1=='' || isNaN(num1))
						num1=0;
					if(num2=='' || isNaN(num2))
						num2=0;

					if(sortedBy=='populationD'){
						sessionStorage.setItem('sortedBy', 'populationA');
						return num1 - num2;
					}
					sessionStorage.setItem('sortedBy', 'populationD');
					return num2 - num1;
				});
				break;
			case "active":
				el = document.getElementById("active");

				el.style.fontWeight = "bold";

				if(sortedBy=='activeD'){
					el.innerHTML='Active&#8593;'
				} else {
					el.innerHTML='Active&#8595;'
				}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.active.replace(/,/g,''));
					var num2 = parseInt(b.active.replace(/,/g,''))

					if(num1=='' || isNaN(num1))
						num1=0;
					if(num2=='' || isNaN(num2))
						num2=0;

					if(sortedBy=='activeD'){
						sessionStorage.setItem('sortedBy', 'activeA');
						return num1 - num2;
					}
					sessionStorage.setItem('sortedBy', 'activeD');
					return num2 - num1;
				});
				break;
			case "recovered":
				el = document.getElementById("recovered");

				el.style.fontWeight = "bold";

				if(sortedBy=='recoveredD'){
					el.innerHTML='Recovered&#8593;'
				} else {
					el.innerHTML='Recovered&#8595;'
				}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.recovered.replace(/,/g,''));
					var num2 = parseInt(b.recovered.replace(/,/g,''))

					if(num1=='' || isNaN(num1))
						num1=0;
					if(num2=='' || isNaN(num2))
						num2=0;

					if(sortedBy=='recoveredD'){
						sessionStorage.setItem('sortedBy', 'recoveredA');
						return num1 - num2;
					}
					sessionStorage.setItem('sortedBy', 'recoveredD');
					return num2 - num1;
				});
				break;
			case "critical":
				el = document.getElementById("critical");

				el.style.fontWeight = "bold";

				if(sortedBy=='criticalD'){
					el.innerHTML='Critical&#8593;'
				} else {
					el.innerHTML='Critical&#8595;'
				}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.critical.replace(/,/g,''));
					var num2 = parseInt(b.critical.replace(/,/g,''));

					if(num1=='' || isNaN(num1))
						num1=0;
					if(num2=='' || isNaN(num2))
						num2=0;

					if(sortedBy=='criticalD'){
						sessionStorage.setItem('sortedBy', 'criticalA');
						return num1 - num2;
					}
					sessionStorage.setItem('sortedBy', 'criticalD');
					return num2 - num1;
				});
				break;
			case "deaths":
				el = document.getElementById("deaths");

				el.style.fontWeight = "bold";

				if(sortedBy=='deathsD'){
					el.innerHTML='Deaths&#8593;'
				} else {
					el.innerHTML='Deaths&#8595;'
				}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.deaths.replace(/,/g,''));
					var num2 = parseInt(b.deaths.replace(/,/g,''));

					if(num1=='' || isNaN(num1))
						num1=0;
					if(num2=='' || isNaN(num2))
						num2=0;

					if(sortedBy=='deathsD'){
						sessionStorage.setItem('sortedBy', 'deathsA');
						return num1 - num2;
					}
					sessionStorage.setItem('sortedBy', 'deathsD');
					return num2 - num1;
				});
				break;
			case "deathsPM":
				el = document.getElementById("deathsPM");

				el.style.fontWeight = "bold";

				if(sortedBy=='deathsPMD'){
					el.innerHTML='Deaths/1M&#8593;'
				} else {
					el.innerHTML='Deaths/1M&#8595;'
				}

				this.data.sort(function (a, b) {
					var num1 = parseFloat(a.deathsPM.replace(/[^\d.-]/g,''));
					var num2 = parseFloat(b.deathsPM.replace(/[^\d.-]/g,''));

					if(num1=='' || isNaN(num1))
						num1=0;
					if(num2=='' || isNaN(num2))
						num2=0;

					if(sortedBy=='deathsPMD'){
						sessionStorage.setItem('sortedBy', 'deathsPMA');
						return num1 - num2;
					}
					sessionStorage.setItem('sortedBy', 'deathsPMD');
					return num2 - num1;
				});
				break;
			case "total":
				el = document.getElementById("total");

				el.style.fontWeight = "bold";

				if(sortedBy=='totalD'){
					el.innerHTML='Total Cases&#8593;'
				} else {
					el.innerHTML='Total Cases&#8595;'
				}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.total.replace(/,/g,''));
					var num2 = parseInt(b.total.replace(/,/g,''))

					if(num1=='' || isNaN(num1))
						num1=0;
					if(num2=='' || isNaN(num2))
						num2=0;

					if(sortedBy=='totalD'){
						sessionStorage.setItem('sortedBy', 'totalA');
						return num1 - num2;
					}
					sessionStorage.setItem('sortedBy', 'totalD');
					return num2 - num1;
				});
				break;
			case "casesPM":
				el = document.getElementById("casesPM");

				el.style.fontWeight = "bold";

				if(sortedBy=='casesPMD'){
					el.innerHTML='Cases/1M&#8593;'
				} else {
					el.innerHTML='Cases/1M&#8595;'
				}

				this.data.sort(function (a, b) {
					var num1 = parseFloat(a.casesPM.replace(/,/g,''));
					var num2 = parseFloat(b.casesPM.replace(/,/g,''))

					if(num1=='' || isNaN(num1))
						num1=0;
					if(num2=='' || isNaN(num2))
						num2=0;

					if(sortedBy=='casesPMD'){
						sessionStorage.setItem('sortedBy', 'casesPMA');
						return num1 - num2;
					}
					sessionStorage.setItem('sortedBy', 'casesPMD');
					return num2 - num1;
				});
				break;
			case "tests":
				el = document.getElementById("tests");

				el.style.fontWeight = "bold";

				if(sortedBy=='testsD'){
					el.innerHTML='Tests&#8593;'
				} else {
					el.innerHTML='Tests&#8595;'
				}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.tests.replace(/,/g,''));
					var num2 = parseInt(b.tests.replace(/,/g,''))

					if(num1=='' || isNaN(num1))
						num1=0;
					if(num2=='' || isNaN(num2))
						num2=0;

					if(sortedBy=='testsD'){
						sessionStorage.setItem('sortedBy', 'testsA');
						return num1 - num2;
					}
					sessionStorage.setItem('sortedBy', 'testsD');
					return num2 - num1;
				});
				break;
			case "testsPM":
				el = document.getElementById("testsPM");

				el.style.fontWeight = "bold";

				if(sortedBy=='testsPMD'){
					el.innerHTML='Tests/1M&#8593;'
				} else {
					el.innerHTML='Tests/1M&#8595;'
				}

				this.data.sort(function (a, b) {
					var num1 = parseFloat(a.testsPM.replace(/,/g,''));
					var num2 = parseFloat(b.testsPM.replace(/,/g,''))

					if(num1=='' || isNaN(num1))
						num1=0;
					if(num2=='' || isNaN(num2))
						num2=0;

					if(sortedBy=='testsPMD'){
						sessionStorage.setItem('sortedBy', 'testsPMA');
						return num1 - num2;
					}
					sessionStorage.setItem('sortedBy', 'testsPMD');
					return num2 - num1;
				});
				break;
		}

		this.$store.dispatch('searchStatesData');

		el.blur();
	}
}
}
</script>

<style scoped>
.Datatable {
	border-collapse: collapse;
	text-align: center;
    width:90%;
    border-radius: 7px;
    background-color: #1b395d;
	color: #d8dbe2;
    box-shadow: 0px 0px 10px 1px #182a43;
}
.headerRow {
	position: -webkit-sticky;
	position: sticky;
	top: 0;
	background-color: #1b395d;
	border-bottom: 1px solid #183353;
}
.lightMode .headerRow{
	background-color: #ffffff;
	color: #3C3C3C;
	border-bottom: 1px solid #e1e1e1;
}
.countryRowPar:nth-child(odd) {
	background-color: #183353;
}
.countryRowPar2:nth-child(even) {
	background-color: #183353;
}
.lightMode .countryRowPar:nth-child(odd) {
	background-color: #f8f8f8;
}
.lightMode .countryRowPar2:nth-child(even) {
	background-color: #f8f8f8;
}
.lightMode {
	background-color: #ffffff;
	color: #3C3C3C;
    box-shadow: 0px 0px 10px 1px #e1e1e1;
}
.headerElement {
    padding-top: 9px;
}
/*buttons != div*/
.active {
	color: #58A4B0;
}
button.active:-moz-focusring {
	text-shadow: 0 0 0 #58A4B0;
}
.lightMode .active {
	color: #00a1e0;
}
.lightMode button.active:-moz-focusring {
	text-shadow: 0 0 0 #00a1e0;
}
.recovered {
	color:  #a0ed8c;
}
button.recovered:-moz-focusring {
	text-shadow: 0 0 0 #a0ed8c;
}
.lightMode .recovered {
	color: #2ab754;
}
.lightMode button.recovered:-moz-focusring {
	text-shadow: 0 0 0 #2ab754;
}
.critical {
	color:  #ffaf3f;
}
button.critical:-moz-focusring {
	text-shadow: 0 0 0 #ffaf3f;
}
.lightMode .critical {
	color:  #ff9f1a;
}
.lightMode button.critical:-moz-focusring {
	text-shadow: 0 0 0 #ff9f1a;
}
.deaths {
	color: #ff6575;
}
button.deaths:-moz-focusring {
	text-shadow: 0 0 0 #ff6575;
}
.lightMode .deaths {
	color: #ff4d5e;
}
.lightMode button.deaths:-moz-focusring {
	text-shadow: 0 0 0 #ff4d5e;
}
.tests {
	color: #2fc3da;
}
button.tests:-moz-focusring {
	text-shadow: 0 0 0 #2fc3da;
}
.lightMode .tests {
	color: #22aabf;
}
.lightMode button.tests:-moz-focusring {
	text-shadow: 0 0 0 #22aabf;
}
.bottomRow{
	border-bottom-left-radius: 7px;
	border-bottom-right-radius: 7px;
	height: 25px;
}
.showButton {
	background-color: transparent;
	position: absolute;
	padding-top: 2px;
	width: 80px;
}
.arrowButton{
	width: 20px;
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


button.subNumber{
	font-size: 81%;
}
button {
	outline: 0;
	font-size: 100%;
	border: none;
	border-collapse: collapse;
	display: inline-block;
    vertical-align: center;
	width: 100%;
    background-color: #1b395d;
	color: #d8dbe2;
}
button:focus {
	outline: 1px solid #FFF;
}
.lightMode button:focus {
	outline: 1px solid #000;
}
button:active {
	outline: 0;
}
.lightMode button:active {
	outline: 0;
}
button:hover {
	text-decoration: underline;
	cursor: pointer;
}
button:-moz-focusring {
  color: transparent;
  text-shadow: 0 0 0 #d8dbe2;
}
button.lightMode {
	background-color: #ffffff;
	border: none;
	box-shadow: none;
}
.lightMode button:-moz-focusring {
  color: transparent;
  text-shadow: 0 0 0 #3C3C3C;
}
</style>