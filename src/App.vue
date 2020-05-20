<template>
  <div id="app" class="app">
    <Header/>
    <br>
    <WorldTable v-bind:worldInfo="worldInfo"/>
  </div>
</template>

<script>
import Header from './components/layout/Header.vue';
import WorldTable from './components/WorldTable.vue';

export default {
  name: 'App',
  components: {
    Header,
    WorldTable
  },
  data(){
    return{
      worldInfo: {
          rank: "0",
          name: "World",
          total: "5,045,467",
          newActive: "+62,530",
          deaths: "327,462",
          newDeaths: "+2,908",
          recovered: "1,999,734",
          active: "2,718,271",
          critical: "45,281",
          casesPM: "647",
          deathsPM: "0"
        }
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
  height: 100%;
  min-width: 350px;
  padding-bottom: 100px;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color:  #1b2e4b;
  color: #d8dbe2;
}


</style>
