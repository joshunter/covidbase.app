<template>
	<div class="Datatable" id="Datatable">
		<RegionFilter @changeContinent="changeCont($event)" @searchCountry="searchCountry($event)"/>
		<div class="row headerRow" id="headerRow">
			<div class="rowNumber headerElement expend1">
				<div id="rank" class="rowRankB">#
				</div>
			</div>
			<div class="rowElement">
				<button id="name" class="country" @click="sortBy('name')">Country
				</button>
				<button id="population" class="subNumber" @click="sortBy('population')">Population
				</button>
			</div>
			<div class="rowElement headerElement">
				<button id="total" @click="sortBy('total')">Total Cases
				</button>
			</div>
			<div class="rowElement headerElement">
				<button id="active" class="active" @click="sortBy('active')">Active
				</button>
			</div>
			<div class="rowElement headerElement">
				<button id="recovered" class="recovered" @click="sortBy('recovered')">Recovered
				</button>
			</div>
			<div class="rowElement headerElement">
				<button id="critical" class="critical" @click="sortBy('critical')">Critical
				</button>
			</div>
			<div class="rowElement headerElement">
				<button id="deaths" class="deaths" @click="sortBy('deaths')">Deaths
				</button>
			</div>
			<div class="rowElement headerElement tests expend1">
				<button id="tests" class="tests" @click="sortBy('tests')">Tests
				</button>
			</div>
			<div class="rowElement headerElement expend2">
				<button id="casesPM" @click="sortBy('casesPM')">Cases/1M
				</button>
			</div>
			<div class="rowElement headerElement expend3">
				<button id="deathsPM" class="deaths" @click="sortBy('deathsPM')">Deaths/1M
				</button>
			</div>
			<div class="rowElement headerElement expend4">
				<button id="testsPM" class="tests" @click="sortBy('testsPM')">Tests/1M
				</button>
			</div>
		</div>
		<transition name="fade">
			<div v-show="show=='Global Data'">
				<div class="countryRowPar" v-bind:key="country._id+'global'" v-for="(country, index) in countryData">
					<CountryRow v-bind:index="index+1" v-bind:country="country" />
				</div>
			</div>
		</transition>
		<div class="countryRowPar" v-bind:key="country._id" v-for="(country, index) in countryData">
			<transition name="fade">
				<CountryRow v-bind:index="index+1" v-show="show==country.continent" v-bind:country="country"/>
			</transition>
		</div>
		<div class="countryRowPar" v-bind:key="country._id+'search'" v-for="(country, index) in countryData">
			<transition name="fade">
				<CountryRow v-bind:index="index+1" v-show="show=='search' && (currentCont == country.continent || currentCont == 'Global Data') && country.name.toLowerCase().includes(searchReq)" v-bind:country="country"/>
			</transition>
		</div>
	</div>
</template>

<script>
import CountryRow from './CountryRow.vue';
import RegionFilter from './layout/RegionFilter.vue';

export default{
name:"CountryTable",
components: {
	CountryRow,
	RegionFilter
},
props : ["countryData"],
data(){
	return {
		ContFiltered: [],
		show: 'Global Data',
		searchReq: '',
		currentCont: 'Global Data'
	};
},
methods: {
	changeCont(continent) {
		this.show=continent;
		// Remove content of searchBar
		var search = document.getElementById('searchBar'); 
		search.value = '';

		document.getElementById('continentSel').blur();

		sessionStorage.setItem('prevShow', this.show);
	},
	searchCountry(country) {
		if(this.show!='search'){
			this.currentCont = this.show;
			sessionStorage.setItem('prevShow', this.show);
			this.show = 'search'; 
		}

		if(country=='') {
			this.show=sessionStorage.getItem('prevShow');
		}

		this.searchReq = country.toLowerCase();

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
					el.innerHTML='Country&#8593;'
				} else {
					el.innerHTML='Country&#8595;'
				}
				this.countryData.sort(function (a, b) {
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

				this.countryData.sort(function (a, b) {
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

				this.countryData.sort(function (a, b) {
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

				this.countryData.sort(function (a, b) {
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

				this.countryData.sort(function (a, b) {
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

				this.countryData.sort(function (a, b) {
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

				this.countryData.sort(function (a, b) {
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

				this.countryData.sort(function (a, b) {
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

				this.countryData.sort(function (a, b) {
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

				this.countryData.sort(function (a, b) {
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

				this.countryData.sort(function (a, b) {
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
		el.blur();
	},
	created(){
		sessionStorage.setItem("prevShow", this.show);
		// const Africa, Asia, Australia, Europe, NorthAmerica, SouthAmerica

		// for(const country of this.countryData){
		// 	if
		// }
		// create continent filter
		// for(var country of this.countryData){
		// 	this.ContFiltered.push({"Asia":Asia})
		// }
		// console.log(this.ContFiltered)
	}
}
}
</script>

<style scoped>
.fade-enter-active {
  transition: opacity 0.6s;
}
.fade-leave-active {
  transition: opacity 0.1s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
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
/*.countryRowPar:nth-child(odd) {
	background-color: #183353;
}
.lightMode .countryRowPar:nth-child(odd) {
	background-color: #f8f8f8;
}*/
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
button.subNumber{
	font-size: 81%;
}

	/*button:focus {
		outline: 1px solid #FFFFFF;
	}*/
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