<template>
  <div id="app" class="app">
    <Header/>
    <br>
    <WorldTable v-bind:worldData="worldData"/>
    <CountriesTable v-bind:countries="countryData"/>
  </div>
</template>

<script>
import Header from './components/layout/Header.vue';
import WorldTable from './components/WorldTable.vue';
import CountriesTable from './components/CountriesTable.vue';

export default {
  name: 'App',
  components: {
    Header,
    WorldTable,
    CountriesTable
  },
  data(){
    return {
      countryData: this.fetchCountryData(),
      worldData: this.fetchWorldData()
    }
  },
  methods: {
    fetchWorldData: function(){
      fetch('http://192.168.1.2:5000/api/wData')
      .then(response => { 
          if(response.ok){
              return response.json()    
          } else{
              alert("Server returned " + response.status + " : " + response.statusText);
          }                
      })
      .then(response => {
          this.worldData = response[0]; 
      })
      .catch(err => {
          console.log(err);
      });
    },
    fetchCountryData(){
      fetch('http://192.168.1.2:5000/api/data')
      .then(response => { 
          if(response.ok){
              return response.json()    
          } else{
              alert("Server returned " + response.status + " : " + response.statusText);
          }                
      })
      .then(response => {
          this.countryData = response; 
      })
      .catch(err => {
          console.log(err);
      });
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
  height: 100%
;  min-width: 350px;
  padding-bottom: 100px;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color:  #1b2e4b;
  color: #d8dbe2;
}


</style>
