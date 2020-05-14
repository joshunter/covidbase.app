<template>
  <div id="app" class="app">
    <Header/>
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
          id: 0,
          name: "Country",
          active: "Active",
          recovered: "Recovered",
          deaths: "Deaths",
          total: "Total"
        },
        {
          id: 1,
          name: "United States",
          active: "12",
          recovered: "42,144",
          deaths: "124",
          total: "253,522"
        },
        {
          id: 2,
          name: "China",
          active: "12",
          recovered: "444",
          deaths: "124",
          total: "2,522"
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
}

.app {
  position: relative;
  height: 100%;
  padding-bottom: 100px;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color:  #1b2e4b;
  color: #d8dbe2;
}
</style>
