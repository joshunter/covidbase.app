<template>
	<div class="customTable">
		<RegionFilter v-show="data[0].continent && data[0].name" @searchCountry="searchCountry()" @changeContinent="changeCont($event)"/>
		<CustomFilter v-show="!data[0].continent && data[0].name" @search="search($event)"/>
		<div class="row headerRow" id="headerRow">
			<div class="rowNumber expend1" v-show="data[0].name">
				<div id="rank" class="rowRankB">#
				</div>
			</div>
			<div class="rowElement" v-show="data[0].name">
				<button id="name" class="country nameButton" @click="sortBy('name')">{{type}}
				</button>
				<button id="population" class="subNumber populationButton" v-show="data[0].population" @click="sortBy('population')">Population
				</button>
			</div>
			<div class="rowElement" v-show="data[0].total">
				<button id="total" class="totalButton" @click="sortBy('total')">Total Cases
				</button>
				<button id="newCases" class="totalButton subNumber" @click="sortBy('newCases')">New Cases
				</button>
			</div>
			<div class="rowElement" v-show="data[0].active" >
				<button id="active" class="active activeButton" @click="sortBy('active')">Active
				</button>
			</div>
			<div class="rowElement" v-show="data[0].recovered" >
				<button id="recovered" class="recovered recoveredButton" @click="sortBy('recovered')">Recovered
				</button>
				<button id="newRecovered" class="recovered recoveredButton subNumber" @click="sortBy('newRecovered')">New Rec.
				</button>
			</div>
			<div class="rowElement" v-show="data[0].critical" >
				<button id="critical" class="critical criticalButton" @click="sortBy('critical')">Critical
				</button>
			</div>
			<div class="rowElement" v-show="data[0].deaths" >
				<button id="deaths" class="deaths deathsButton" @click="sortBy('deaths')">Deaths
				</button>
				<button id="newDeaths" class="deaths deathsButton subNumber" @click="sortBy('newDeaths')">New Deaths
				</button>
			</div>
			<div class="rowElement tests expend1" v-show="data[0].tests">
				<button id="tests" class="tests testsButton" @click="sortBy('tests')">Tests
				</button>
			</div>
			<div class="rowElement expend2" v-show="data[0].casesPM" >
				<button id="casesPM" class="casesPMButton" @click="sortBy('casesPM')">Cases/1M
				</button>
			</div>
			<div class="rowElement expend3" v-show="data[0].deathsPM" >
				<button id="deathsPM" class="deaths deathsPMButton" @click="sortBy('deathsPM')">Deaths/1M
				</button>
			</div>
			<div class="rowElement expend4" v-show="data[0].testsPM" >
				<button id="testsPM" class="tests testsPMButton" @click="sortBy('testsPM')">Tests/1M
				</button>
			</div>
		</div>
		<div class="countryRowPar2" v-bind:key="index+'global'" v-for="(datum, index) in data">
				<DataRow v-bind:index="index+1" v-bind:data="datum" v-show="show=='Global Data' && index < showing"/>
		</div>
		<div class="countryRowPar" v-bind:key="index+'filtered'" v-for="(datum, index) in filteredData">
				<DataRow v-bind:index="index+1" v-bind:data="datum" v-show="show==datum.continent  && index < showing"/>
		</div>		
		<div class="countryRowPar" v-bind:key="index+'search'" v-for="(datum, index) in searchedData">
				<DataRow v-bind:index="index+1" v-bind:data="datum" v-show="show=='search' && index < showing"/>
		</div>
		<div class="bottomRow">
			<button class="showButton hidden" id="min" style="right: 90px;" @click="showMin()">min</button>
			<button class="showButton addremoveButton hidden" id="less"  style="right: 5px;" @click="showLess()">-</button>
			<button class="showButton addremoveButton" id="more" style="left: 5px;" @click="showMore()">+</button>
			<button class="showButton" id="all" style="left: 90px;" @click="showAll()">all</button>
		</div>
	</div>
</template>

<script>
import DataRow from './DataRow.vue';
import RegionFilter from './RegionFilter.vue';
import CustomFilter from './CustomFilter.vue';

export default{
name:"CustomTable",
components: {
	DataRow,
	RegionFilter,
	CustomFilter
},
props:[
	"data",
	"filteredData",
	"searchedData",
	"type"
],
data(){
	return {
		show: 'Global Data',
		showing: 20,
		path: ''
	};
},
computed: {
	currentState() {return this.$store.state.us.currentState}
},
mounted() {
	sessionStorage.setItem('prevShow', this.show);
	sessionStorage.setItem('sortedBy', 'totalD');
},
methods: {
	showMin(){
		document.getElementById("min").classList.add("hidden");
		document.getElementById("less").classList.add("hidden");

		document.getElementById("all").classList.remove("hidden");
		document.getElementById("more").classList.remove("hidden");

		this.showing = 20;
	},
	showMore(){
		this.showing += 20;
		const moreButton = document.getElementById("more")
		moreButton.blur();
		document.getElementById("less").classList.remove("hidden");
		document.getElementById("min").classList.remove("hidden");

		if(this.showing >= this.data.length){
			moreButton.classList.add("hidden");
			document.getElementById("all").classList.add("hidden");
			this.showing = this.data.length;
		}
		moreButton.scrollIntoView();
	},
	showLess(){
		if(this.showing-20 > 20){
			this.showing -= 20;
			document.getElementById("all").classList.remove("hidden");
			document.getElementById("more").classList.remove("hidden");
		}
		else{
			this.showing = 20;
			document.getElementById("less").classList.add("hidden");
			document.getElementById("min").classList.add("hidden");
		}
		document.getElementById("less").blur();
	},
	showAll(){
		document.getElementById("min").classList.remove("hidden");
		document.getElementById("less").classList.remove("hidden");

		document.getElementById("all").classList.add("hidden");
		document.getElementById("more").classList.add("hidden");

		this.showing = this.data.length;
	},
	changeCont(continent) {
		this.show=continent;
		this.$store.dispatch('filterData');

		// Remove content of searchBar
		var search = document.getElementById('searchBar'); 
		search.value = '';

		document.getElementById('continentSel').blur();

		sessionStorage.setItem('prevShow', this.show);
	},
	searchCountry() {
		if(this.show!='search'){
			sessionStorage.setItem('prevShow', this.show);
			this.show='search';
		}

		if(this.$store.state.world.query=='') {
			this.show=sessionStorage.getItem('prevShow');
		}

		this.$store.dispatch('searchCountry');

		const node = document.getElementById("searchBar");
		node.addEventListener("keyup", function(event) {
			if (event.key === "Enter") {
				node.blur()
			}
		})

	},
	search(query) {
		this.show='search';
		if(query=='') {
			this.show='Global Data';
		}

		if(this.currentState === '')
			this.$store.dispatch('searchStatesData');
		else
			this.$store.dispatch('searchCitiesData');

		const node = document.getElementById("stateSearchBar");
		node.addEventListener("keyup", function(event) {
			if (event.key === "Enter") {
				node.blur()
			}
		})

	},
	sortBy(type){
		let sortedBy = sessionStorage.getItem('sortedBy');
		let id = sortedBy.substring(0, sortedBy.length - 1);

		let el = document.getElementById(id);
		//replace arrows for current column
		el.style.fontWeight = "normal";
		el.innerHTML = el.innerHTML.substring(0, el.innerHTML.length - 1);

		switch(type){
			case "name":
				el = document.getElementById("name");

				el.style.fontWeight = "bold";
				if(sortedBy=='nameA') {el.innerHTML=this.type+'&#8593;'}
				else {el.innerHTML=this.type+'&#8595;'}
				
				this.data.sort(function (a, b) {
					if(sortedBy=='nameA'){
						sessionStorage.setItem('sortedBy', 'nameD');
						if (a.name < b.name) {return 1;}
						if (a.name > b.name) {return -1;}
					}

					sessionStorage.setItem('sortedBy', 'nameA');
					if (a.name < b.name) {return -1;}
					if (a.name > b.name) {return 1;}
				});
				break;
			case "population":
				el = document.getElementById("population");

				el.style.fontWeight = "bold";

				if(sortedBy=='populationD') {el.innerHTML='Population&#8593;'}
				else {el.innerHTML='Population&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.population.replace(/\D/g,''));
					var num2 = parseInt(b.population.replace(/\D/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

					if(sortedBy=='populationD'){
						sessionStorage.setItem('sortedBy', 'populationA');
						return num1 - num2;
					}

					sessionStorage.setItem('sortedBy', 'populationD');
					return num2 - num1;
				});
				break;
			case "total":
				el = document.getElementById("total");

				el.style.fontWeight = "bold";

				if(sortedBy=='totalD') {el.innerHTML='Total Cases&#8593;'}
				else {el.innerHTML='Total Cases&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.total.replace(/,/g,''));
					var num2 = parseInt(b.total.replace(/,/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

					if(sortedBy=='totalD'){
						sessionStorage.setItem('sortedBy', 'totalA');
						return num1 - num2;
					}

					sessionStorage.setItem('sortedBy', 'totalD');
					return num2 - num1;
				});
				break;
			case "newCases":
				el = document.getElementById("newCases");

				el.style.fontWeight = "bold";

				if(sortedBy=='newCasesD') {el.innerHTML='New Cases&#8593;'}
				else {el.innerHTML='New Cases&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.newActive.replace(/(\+|,)/g,''));
					var num2 = parseInt(b.newActive.replace(/(\+|,)/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

					if(sortedBy=='newCasesD'){
						sessionStorage.setItem('sortedBy', 'newCasesA');
						return num1 - num2;
					}

					sessionStorage.setItem('sortedBy', 'newCasesD');
					return num2 - num1;
				});
				break;
			case "active":
				el = document.getElementById("active");

				el.style.fontWeight = "bold";

				if(sortedBy=='activeD'){el.innerHTML='Active&#8593;'}
				else {el.innerHTML='Active&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.active.replace(/,/g,''));
					var num2 = parseInt(b.active.replace(/,/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

					if(sortedBy=='activeD') {
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

				if(sortedBy=='recoveredD') {el.innerHTML='Recovered&#8593;'}
				else {el.innerHTML='Recovered&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.recovered.replace(/,/g,''));
					var num2 = parseInt(b.recovered.replace(/,/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

					if(sortedBy=='recoveredD'){
						sessionStorage.setItem('sortedBy', 'recoveredA');
						return num1 - num2;
					}

					sessionStorage.setItem('sortedBy', 'recoveredD');
					return num2 - num1;
				});
				break;
			case "newRecovered":
				el = document.getElementById("newRecovered");

				el.style.fontWeight = "bold";

				if(sortedBy=='newRecoveredD') {el.innerHTML='New Rec.&#8593;'}
				else {el.innerHTML='New Rec.&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.newRecovered.replace(/(\+|,)/g,''));
					var num2 = parseInt(b.newRecovered.replace(/(\+|,)/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

					if(sortedBy=='newRecoveredD'){
						sessionStorage.setItem('sortedBy', 'newRecoveredA');
						return num1 - num2;
					}

					sessionStorage.setItem('sortedBy', 'newRecoveredD');
					return num2 - num1;
				});
				break;
			case "critical":
				el = document.getElementById("critical");

				el.style.fontWeight = "bold";

				if(sortedBy=='criticalD') {el.innerHTML='Critical&#8593;'}
				else {el.innerHTML='Critical&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.critical.replace(/,/g,''));
					var num2 = parseInt(b.critical.replace(/,/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

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

				if(sortedBy=='deathsD') {el.innerHTML='Deaths&#8593;'}
				else {el.innerHTML='Deaths&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.deaths.replace(/,/g,''));
					var num2 = parseInt(b.deaths.replace(/,/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

					if(sortedBy=='deathsD'){
						sessionStorage.setItem('sortedBy', 'deathsA');
						return num1 - num2;
					}

					sessionStorage.setItem('sortedBy', 'deathsD');
					return num2 - num1;
				});
				break;
			case "newDeaths":
				el = document.getElementById("newDeaths");

				el.style.fontWeight = "bold";

				if(sortedBy=='newDeathsD') {el.innerHTML='New Deaths&#8593;'}
				else {el.innerHTML='New Deaths&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.newDeaths.replace(/(\+|,)/g,''));
					var num2 = parseInt(b.newDeaths.replace(/(\+|,)/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

					if(sortedBy=='newDeathsD'){
						sessionStorage.setItem('sortedBy', 'newDeathsA');
						return num1 - num2;
					}

					sessionStorage.setItem('sortedBy', 'newDeathsD');
					return num2 - num1;
				});
				break;
			case "deathsPM":
				el = document.getElementById("deathsPM");

				el.style.fontWeight = "bold";

				if(sortedBy=='deathsPMD') {el.innerHTML='Deaths/1M&#8593;'}
				else {el.innerHTML='Deaths/1M&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseFloat(a.deathsPM.replace(/[^\d.-]/g,''));
					var num2 = parseFloat(b.deathsPM.replace(/[^\d.-]/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

					if(sortedBy=='deathsPMD') {
						sessionStorage.setItem('sortedBy', 'deathsPMA');
						return num1 - num2;
					}

					sessionStorage.setItem('sortedBy', 'deathsPMD');
					return num2 - num1;
				});
				break;
			case "casesPM":
				el = document.getElementById("casesPM");

				el.style.fontWeight = "bold";

				if(sortedBy=='casesPMD') {el.innerHTML='Cases/1M&#8593;'}
				else {el.innerHTML='Cases/1M&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseFloat(a.casesPM.replace(/,/g,''));
					var num2 = parseFloat(b.casesPM.replace(/,/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

					if(sortedBy=='casesPMD') {
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

				if(sortedBy=='testsD') {el.innerHTML='Tests&#8593;'}
				else {el.innerHTML='Tests&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseInt(a.tests.replace(/,/g,''));
					var num2 = parseInt(b.tests.replace(/,/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

					if(sortedBy=='testsD') {
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

				if(sortedBy=='testsPMD') {el.innerHTML='Tests/1M&#8593;'}
				else {el.innerHTML='Tests/1M&#8595;'}

				this.data.sort(function (a, b) {
					var num1 = parseFloat(a.testsPM.replace(/,/g,''));
					var num2 = parseFloat(b.testsPM.replace(/,/g,''));

					if(num1=='' || isNaN(num1)) {num1=0;}
					if(num2=='' || isNaN(num2)) {num2=0;}

					if(sortedBy=='testsPMD'){
						sessionStorage.setItem('sortedBy', 'testsPMA');
						return num1 - num2;
					}

					sessionStorage.setItem('sortedBy', 'testsPMD');
					return num2 - num1;
				});
				break;
		}

		this.$store.dispatch('filterData');
		this.$store.dispatch('searchCountry');
		this.$store.dispatch('searchStatesData');

		el.blur();
	}
}
}
</script>

<style scoped>

.customTable {
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

.countryRowPar:nth-child(odd) {background-color: #183353;}
.countryRowPar2:nth-child(even) {background-color: #183353;}
.lightMode .countryRowPar:nth-child(odd) {background-color: #f8f8f8;}
.lightMode .countryRowPar2:nth-child(even) {background-color: #f8f8f8;}

.bottomRow{
	border-bottom-left-radius: 7px;
	border-bottom-right-radius: 7px;
	background: linear-gradient(90deg, #183353 0%, #1b395d 50%, #183353 100%); 
	height: 38px;
}
.lightMode .bottomRow{
	background: linear-gradient(90deg, #f8f8f8 0%, #ffffff 50%, #f8f8f8 100%); 
}
.lightMode {
	background-color: #ffffff;
	color: #3C3C3C;
	box-shadow: 0px 0px 10px 1px #e1e1e1;
}

/*buttons != div*/
.active {color: #58A4B0;}
button.active:-moz-focusring {text-shadow: 0 0 0 #58A4B0;}
.lightMode .active {color: #00a1e0;}
.lightMode button.active:-moz-focusring {text-shadow: 0 0 0 #00a1e0;}

.recovered {color:  #a0ed8c;}
button.recovered:-moz-focusring {text-shadow: 0 0 0 #a0ed8c;}
.lightMode .recovered {color: #2ab754;}
.lightMode button.recovered:-moz-focusring {text-shadow: 0 0 0 #2ab754;}

.critical {color:  #ffaf3f;}
button.critical:-moz-focusring {text-shadow: 0 0 0 #ffaf3f;}
.lightMode .critical {color:  #ff9f1a;}
.lightMode button.critical:-moz-focusring {text-shadow: 0 0 0 #ff9f1a;}

.deaths {color: #ff6575;}
button.deaths:-moz-focusring {text-shadow: 0 0 0 #ff6575;}
.lightMode .deaths {color: #ff4d5e;}
.lightMode button.deaths:-moz-focusring {text-shadow: 0 0 0 #ff4d5e;}

.tests {color: #2fc3da;}
button.tests:-moz-focusring {text-shadow: 0 0 0 #2fc3da;}
.lightMode .tests {color: #22aabf;}
.lightMode button.tests:-moz-focusring {text-shadow: 0 0 0 #22aabf;}

button.subNumber{font-size: 81%;}

.showButton {
	position: static;
	background-color: #24497a;
	box-shadow: 0px 0px 4px 0px #182a43;
	border-radius: 14px;
	width: 60px;
	height: 28px;
	margin: 5px;
}

.showButton:hover {
	background-color:  #20406a;
	color: #bcc1cd;
	text-decoration: none;
	box-shadow: 0px 0px 2px 0px #182a43;
}

.showButton:active {
	background-color:  #183353;
	box-shadow: none;
	border: 1px solid #182a43;
}
.showButton:-moz-focusring {
	color: transparent;
	text-shadow: 0 0 0 #bcc1cd;
}

.lightMode .showButton {
	background-color:  #fff;
	color: #3C3C3C;
    box-shadow: 0px 0px 3px 1px #e1e1e1;
}

.lightMode .showButton:hover {
	background-color:  #fcfcfc;
    box-shadow: 0px 0px 3px 0px #e1e1e1;
}

.lightMode .showButton:active {
	background-color:  #fcfcfc;
    box-shadow: none;
    border: 1px solid #e1e1e1;
}

.lightMode .showButton:-moz-focusring {
	color: transparent;
	text-shadow: 0 0 0 #3C3C3C;
}

.addremoveButton{
	font-size: 130%;
	width: 28px;
}

button {
	outline: 0;
	font-size: 100%;
	border: none;
	border-collapse: collapse;
	display: inline-block;
    vertical-align: center;
	width: 100%;
    background-color: transparent;
	color: #d8dbe2;
}

button:focus {outline: 1px solid #FFF;}
.lightMode button:focus {outline: 1px solid #000;}
button:active {outline: 0;}
.lightMode button:active {outline: 0;}
button:hover {
	text-decoration: underline;
	cursor: pointer;
}
button:-moz-focusring {
	color: transparent;
	text-shadow: 0 0 0 #d8dbe2;
}
button.lightMode {
	background-color: transparent;
	border: none;
	box-shadow: none;
}
.lightMode:-moz-focusring {
	color: transparent;
	text-shadow: 0 0 0 #3C3C3C;
}

.hidden {
	background-color: transparent;
	color: transparent;
	box-shadow: none;
}
.hidden:hover {
	background-color: transparent;
	color: transparent;
	pointer-events:none;
	box-shadow:none;
}
.hidden:focus {outline: none; border:none;}
.hidden:active {
	background-color: transparent;
	color: transparent;
	pointer-events:none;
}
.hidden:-moz-focusring {text-shadow:none;}

.lightMode .hidden {
	background-color: transparent;
	color: transparent;
	box-shadow: none;
}
.lightMode .hidden:hover {
	background-color: transparent;
	color: transparent;
	pointer-events:none;
	box-shadow:none;
}
.lightMode .hidden:focus {outline: none; border:none;}
.lightMode .hidden:active {
	background-color: transparent;
	color: transparent;
	pointer-events:none;
}
.lightMode .hidden:-moz-focusring {text-shadow:none;}

@media only screen and (max-width: 550px){.showButton {font-size: 85%;} .addremoveButton{font-size: 105%;}}
@media only screen and (max-width: 465px){.showButton {font-size: 70%;} .addremoveButton{font-size: 100%;}}
@media only screen and (max-width: 400px){.showButton {font-size: 67%;} .addremoveButton{font-size: 97%;}}
@media only screen and (max-width: 360px){.showButton {font-size: 66%;} .addremoveButton{font-size: 96%;}}
@media only screen and (max-width: 340px){.showButton {font-size: 58%;} .addremoveButton{font-size: 88%;}}

</style>