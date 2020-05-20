<template>
  <div id="app" class="app">
    <Header/>
    <br>
    <RegionFilter/>
    <CountryData v-bind:countries="countries"/>
  </div>
</template>

<script>
import Header from './components/layout/Header.vue';
import RegionFilter from './components/layout/RegionFilter.vue';
import CountryData from './components/CountryData.vue';

export default {
  name: 'App',
  components: {
    Header,
    RegionFilter,
    CountryData
  },
  data(){
    return{
      countries: [
        {rank: "1",
        name: "USA",
        total: "1,570,583",
        newActive: "",
        deaths: "93,533 ",
        newDeaths: "",
        recovered: "361,180",
        active: "1,115,870",
        critical: "17,249",
        casesPM: "4,748",
        deathsPM: "283",
        tests: "12,645,473",
        testsPM: "38,229",
        population: "330,779,957",
        continent: "North America"},
        {rank: "2",
        name: "Russia",
        total: "299,941",
        newActive: "",
        deaths: "2,837 ",
        newDeaths: "",
        recovered: "76,130",
        active: "220,974",
        critical: "2,300",
        casesPM: "2,055",
        deathsPM: "19",
        tests: "7,352,316",
        testsPM: "50,383",
        population: "145,927,463",
        continent: "Europe"},
        {rank: "3",
        name: "Spain",
        total: "278,803",
        newActive: "",
        deaths: "27,778 ",
        newDeaths: "",
        recovered: "196,958",
        active: "54,067",
        critical: "1,152",
        casesPM: "5,963",
        deathsPM: "594",
        tests: "3,037,840",
        testsPM: "64,977",
        population: "46,752,753",
        continent: "Europe"},
        {rank: "4",
        name: "Brazil",
        total: "271,885",
        newActive: "",
        deaths: "17,983 ",
        newDeaths: "",
        recovered: "106,794",
        active: "147,108",
        critical: "8,318",
        casesPM: "1,280",
        deathsPM: "85",
        tests: "735,224",
        testsPM: "3,462",
        population: "212,385,054",
        continent: "South America"},
        {rank: "5",
        name: "UK",
        total: "248,818",
        newActive: "",
        deaths: "35,341 ",
        newDeaths: "",
        recovered: "N/A",
        active: "N/A",
        critical: "1,559",
        casesPM: "3,667",
        deathsPM: "521",
        tests: "2,772,552",
        testsPM: "40,866",
        population: "67,845,213",
        continent: "Europe"},
        {rank: "6",
        name: "Italy",
        total: "226,699",
        newActive: "",
        deaths: "32,169 ",
        newDeaths: "",
        recovered: "129,401",
        active: "65,129",
        critical: "716",
        casesPM: "3,749",
        deathsPM: "532",
        tests: "3,104,524",
        testsPM: "51,338",
        population: "60,471,682",
        continent: "Europe"},
        {rank: "7",
        name: "France",
        total: "180,809",
        newActive: "",
        deaths: "28,022 ",
        newDeaths: "",
        recovered: "62,563",
        active: "90,224",
        critical: "1,894",
        casesPM: "2,771",
        deathsPM: "429",
        tests: "1,384,633",
        testsPM: "21,218",
        population: "65,257,220",
        continent: "Europe"},
        {rank: "8",
        name: "Germany",
        total: "177,827",
        newActive: "",
        deaths: "8,193 ",
        newDeaths: "",
        recovered: "156,900",
        active: "12,734",
        critical: "1,115",
        casesPM: "2,123",
        deathsPM: "98",
        tests: "3,147,771",
        testsPM: "37,584",
        population: "83,753,585",
        continent: "Europe"},
        {rank: "9",
        name: "Turkey",
        total: "151,615",
        newActive: "",
        deaths: "4,199 ",
        newDeaths: "",
        recovered: "112,895",
        active: "34,521",
        critical: "882",
        casesPM: "1,800",
        deathsPM: "50",
        tests: "1,675,517",
        testsPM: "19,892",
        population: "84,232,553",
        continent: "Asia"},
        {rank: "10",
        name: "Iran",
        total: "124,603",
        newActive: "",
        deaths: "7,119 ",
        newDeaths: "",
        recovered: "97,173",
        active: "20,311",
        critical: "2,698",
        casesPM: "1,486",
        deathsPM: "85",
        tests: "716,176",
        testsPM: "8,540",
        population: "83,865,579",
        continent: "Asia"},
        {rank: "11",
        name: "India",
        total: "106,886",
        newActive: "+411",
        deaths: "3,303 ",
        newDeaths: "+1",
        recovered: "42,309",
        active: "61,274",
        critical: "N/A",
        casesPM: "78",
        deathsPM: "2",
        tests: "2,512,388",
        testsPM: "1,823",
        population: "1,378,418,813",
        continent: "Asia"},
        {rank: "12",
        name: "Peru",
        total: "99,483",
        newActive: "",
        deaths: "2,914 ",
        newDeaths: "",
        recovered: "36,524",
        active: "60,045",
        critical: "883",
        casesPM: "3,022",
        deathsPM: "89",
        tests: "679,582",
        testsPM: "20,645",
        population: "32,917,154",
        continent: "South America"},
        {rank: "13",
        name: "Canada",
        total: "79,112",
        newActive: "",
        deaths: "5,912 ",
        newDeaths: "",
        recovered: "40,050",
        active: "33,150",
        critical: "502",
        casesPM: "2,098",
        deathsPM: "157",
        tests: "1,339,971",
        testsPM: "35,540",
        population: "37,703,672",
        continent: "North America"}
      ]
    }
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Lato&display=swap');

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Lato', sans-serif;
  vertical-align:middle;
  text-align: center;
  margin-left: auto;
  margin-right: auto;
}

.app {;
  display: block;
  min-height: 100%;
  min-width: 520px;
  padding-bottom: 100px;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color:  #1b2e4b;
  color: #d8dbe2;
}
</style>
