<template>
	<table>
		<div class="row">
			<div class="rowRank">
				<button id="rank" class="rowRankB" @click="sortBy('rank')">#
				</button>
			</div>
			<div class="rowElement">
				<button id="name" class="country" @click="sortBy('name')">Country
				</button>
				<button id="population" class="subElement" @click="sortBy('population')">Population
				</button>
			</div>
			<div class="rowElement">
				<button id="active" class="active" @click="sortBy('active')">Active
				</button>
			</div>
			<div class="rowElement">
				<button id="recovered" class="recovered" @click="sortBy('recovered')">Recovered
				</button>
			</div>
			<div class="rowElement">
				<button id="critical" class="critical" @click="sortBy('critical')">Critical
				</button>
			</div>
			<div class="rowElement">
				<button id="deaths" class="deaths" @click="sortBy('deaths')">Deaths
				</button>
			</div>
			<div class="rowElement">
				<button id="total" @click="sortBy('total')">Total
				</button>
			</div>
			<div class="rowElement">
				<button id="tests" @click="sortBy('tests')">Tests
				</button>
			</div>
		</div>
		<div v-bind:key="country._id" v-for="country in countryData">
			<CountryRow v-bind:country="country" />
		</div>
	</table>
</template>

<script>
import CountryRow from './CountryRow.vue';
export default{
name:"CountryTable",
components: {
	CountryRow
},
data(){
	return {
		countryData: this.fetchCountryData(),
	};
},
methods: {
	fetchCountryData(){
		fetch('http://192.168.1.2:5000/api/data')
		.then(response => { 
			if(response.ok){
				return response.json()
			} else {
				alert("Server returned " + response.status + " : " + response.statusText);
			}                
		})
		.then(response => {
			document.getElementById("rank").innerHTML='#&#8595;';
			sessionStorage.setItem('sortedBy', 'rankA');
			this.countryData = response;
		})
		.catch(err => {
			console.log(err);
		});
	},
	sortBy: function(type){
		let sortedBy = sessionStorage.getItem('sortedBy');
		let id = sortedBy.substring(0, sortedBy.length - 1);

		let el = document.getElementById(id);
		//replace arrows for current column.
		el.style.fontWeight = "normal";
		el.innerHTML = el.innerHTML.substring(0, el.innerHTML.length - 1);
		// el.innerHTML +='&#8597;';

		switch(type){
			case "rank":
				el = document.getElementById("rank");

				el.style.fontWeight = "bold";

				if(sortedBy=='rankA'){
					el.innerHTML='#&#8593;'
				} else {
					el.innerHTML='#&#8595;'
				}

				this.countryData.sort(function (a, b) {
					if(sortedBy=='rankA'){
						sessionStorage.setItem('sortedBy', 'rankD');
						return b.rank -a.rank;
					}
					sessionStorage.setItem('sortedBy', 'rankA');
					return (a.rank) - (b.rank);
				});
				break;
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
					var num1 = parseInt(a.population.replace(/,/g,''));
					var num2 = parseInt(b.population.replace(/,/g,''))

					if(num1=='')
						num1=0;
					if(num2=='')
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
					var num2 = parseInt(b.critical.replace(/,/g,''))

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
					var num2 = parseInt(b.deaths.replace(/,/g,''))

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
			case "total":
				el = document.getElementById("total");

				el.style.fontWeight = "bold";

				if(sortedBy=='totalD'){
					el.innerHTML='Total&#8593;'
				} else {
					el.innerHTML='Total&#8595;'
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
		}
	}
}
}
</script>

<style scoped>
table {
	border-collapse: collapse;
	text-align: center;
    width:90%;
    margin-top: 2px;
    border-radius: 15px;
    background-color: #1b395d;
	color: #d8dbe2;
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
.subElement {
	font-size: 81%;
}
.rowRank {
	padding-top: 1%;
	width: 3%;
    vertical-align: top;
}

.rowElement {
	padding-top: 1%;
	display: inline-block;
    vertical-align: top;
	width: 14%;
}
button:focus {
	outline:0;
}
button.change:hover {
	cursor: pointer;
}
button:active {
	outline: none;
	border: none;
}
button {
	border: none;
	border-collapse: collapse;
	display: inline-block;
    vertical-align: top;
	width: 100%;
	text-align: center;
    background-color: #1b395d;
	color: #d8dbe2;
}
</style>