<template>
  <div id="app" class="app">
    <Header @changeTheme="setTheme($event)"/>
    <transition name="fade">
      <router-view :worldData="worldData" :countryData="countryData"></router-view>
    </transition>
    <div @click="toTop()" id="ArrowBox" class="ArrowBox ArrowBox--hidden"><i class="arrow"></i></div>
  </div>
</template>

<script>
import Header from './components/layout/Header.vue';

export default {
  name: 'App',
  components: {
    Header,
  },
  data(){
    return {
      countryData: {},
      worldData: {},
    }
  },
  updated() {
    this.getTheme();
  },
  mounted () {
    window.addEventListener('scroll', this.onScroll)
    this.getTheme();
    },
  created(){
    this.fetchCountryData();
    this.fetchWorldData();
  },
  beforeDestroy () {
    window.removeEventListener('scroll', this.onScroll)
  },
  methods: {
    fetchCountryData(){
      fetch('https://db.covidbase.app/api/data')
        .then(response => { 
          if(response.ok){
            return response.json()
          } else {
          alert("Server returned " + response.status + " : " + response.statusText);
          }                
        })
        .then(response => {
          sessionStorage.setItem('sortedBy', 'totalD');
          this.countryData = response;
        })
        .catch(err => {
          console.log(err);
        });
    },
    fetchWorldData: function(){
      fetch('https://db.covidbase.app/api/wData')
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
    },
    getTheme(){
      const currTheme = localStorage.getItem("theme");

      if(currTheme==null) {
        localStorage.setItem("theme","dark");
      }
      else {
        this.setTheme(currTheme);
      }
    },
    setTheme(Theme){
      const classNames = ["app","header","ArrowBox","Datatable","searchBar","continentSel", "ArrowBox","worldTable"];
      const Ids = ["name","population","total","active","recovered","critical","deaths","tests","casesPM","deathsPM","testsPM"];

      if(Theme == "dark") {
        document.getElementById("dmCheck").checked = true;

        try{
          for(const className of classNames) {
            document.getElementsByClassName(className)[0].classList.remove("lightMode");
          }
        } catch (err){
          console.log(err.message);
        } finally {
          try{
            for(var i of Ids) {
              document.getElementById(i).classList.remove("lightMode");
            }
          } catch (err) {
            console.log(err.message);
          }

        }
      }
      else {
        document.getElementById("dmCheck").checked = false;

        try {
          for(const className of classNames) {
            document.getElementsByClassName(className)[0].classList.add("lightMode");
          }
        } catch (err){
          console.log(err.message);
        } finally {
          try{
            for(var id of Ids) {
              document.getElementById(id).classList.add("lightMode");
            }
          } catch (err) {
            console.log(err.message);
          }
        }
      }

    },
    onScroll () { 
      const currentScrollPosition = window.pageYOffset || document.documentElement.scrollTop;

      //Display arrowbox after down scroll past 138 px.
      if (currentScrollPosition < 0) {
        return
      }
      if (currentScrollPosition > 138){
        document.getElementById("ArrowBox").classList.remove("ArrowBox--hidden");
      }
      if (currentScrollPosition < 138){
        document.getElementById("ArrowBox").classList.add("ArrowBox--hidden");
      }
    },
    toTop() { //On click of arrow box, go to top smoothly.
      window.scrollTo({ top: 0, behavior: 'smooth' });
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

.app {
  display: block;
  min-height: 100vh;
  padding-bottom: 30px;
  min-width: 320px;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color:  #1a2c47;
  color: #d8dbe2;
}

.router-view {
  padding-top: 25px;
}

.arrow {
  border: solid #d8dbe2;
  border-width: 0 5px 5px 0;
  display: inline-block;
  padding: 5px;
  transform: rotate(-135deg);
  -webkit-transform: rotate(-135deg);
  position: fixed;
  bottom: 105px;
  right: 32px
}
.ArrowBox {
  border-radius: 7px;
  height: 50px;
  width: 50px;
  background-color:  #3061a1;
  color: #d8dbe2;
  position: fixed;
  bottom: 90px;
  right: 15px;
}
.ArrowBox.ArrowBox--hidden {
  display: none;
}
.ArrowBox:hover {
  background-color:  #24497a;
  color: #bcc1cd;
  cursor: pointer;
  box-shadow: 0px 0px 10px 3px #182a43;
}
.ArrowBox.lightMode {
  box-shadow: 0px 0px 10px 0px #e1e1e1;
}
.ArrowBox.lightMode:hover {
  background-color:  #f8f8f8;
  box-shadow: 0px 0px 5px 0px #e1e1e1;;
}
.lightMode {
  background-color: #FFFFFF;
  color: #3C3C3C;
}
.fade-enter-active {
  transition: opacity 1.25s;
}
.fade-leave-active {
  transition: opacity 0.1s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>
