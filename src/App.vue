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
        {
          id: 1,
          name: "United States",
          active: "1,034,892",
          newActive: "+17,346",
          recovered: "310,259",
          critical: "16,349",
          deaths: "87,965",
          newDeaths: "+3",
          total: "1,474,806",
          tests: "10,269,996"
        },
        {
          id: 2,
          name: "Spain",
          active: "60,764",
          newActive: "",
          recovered: "183,227",
          critical: "1,534",
          deaths: "27,104",
          newDeaths: "",
          total: "271,095",
          tests: "2,467,761"
        },
        {
          id: 1,
          name: "United States",
          active: "1,034,892",
          newActive: "+17,346",
          recovered: "310,259",
          critical: "16,349",
          deaths: "87,965",
          newDeaths: "+3",
          total: "1,474,806",
          tests: "10,269,996"
        },
        {
          id: 2,
          name: "Spain",
          active: "60,764",
          newActive: "",
          recovered: "183,227",
          critical: "1,534",
          deaths: "27,104",
          newDeaths: "+2",
          total: "271,095",
          tests: "2,467,761"
        }
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
  text-align: center;
  margin-left: auto;
  margin-right: auto;
  vertical-align:middle
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
