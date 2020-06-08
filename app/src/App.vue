<template>
  <div id="app" class="app">
    <Header/>
    <transition name="fade">
      <router-link to="About">About</router-link>
      <router-link to="Homepage">Homepage</router-link>
      <router-view/>
    </transition>
    <Homepage v-bind:countryData="countryData" v-bind:worldData="worldData"/>

  </div>
</template>

<script>
import Header from './components/layout/Header.vue';
import Homepage from './components/Homepage.vue';

export default {
  name: 'App',
  components: {
    Header,
    Homepage
  },
  data(){
    return {
      countryData: this.fetchCountryData(),
      worldData: this.fetchWorldData()
    }
  },
  methods :  {
    fetchCountryData(){
      fetch('http://18.223.121.212:5000/api/data')
      .then(response => { 
        if(response.ok){
          return response.json()
        } else {
          alert("Server returned " + response.status + " : " + response.statusText);
        }                
      })
      .then(response => {
        sessionStorage.setItem('sortedBy', 'rankD');
        sessionStorage.setItem('prevShow', this.show);
        this.countryData = response;
        this.sortBy('rank');
      })
      .catch(err => {
        console.log(err);
      });
    },
    fetchWorldData: function(){
      fetch('http://18.223.121.212:5000/api/wData')
      .then(response => { 
        if(response.ok){
          return response.json()    
        } else {
          alert("Server returned " + response.status + " : " + response.statusText);
        }
      })
      .then(response => {
        this.worldData = response[0]; 
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
  min-height: 100vh;
  padding-bottom: 30px;
  min-width: 320px;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color:  #1b2e4b;
  color: #d8dbe2;
}

body {
  background-color:  #1b2e4b;
  color: #d8dbe2;
}

.fade-enter-active {
  transition: opacity 0.6s;
}
.fade-leave-active {
  transition: opacity 0.1s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}


</style>
