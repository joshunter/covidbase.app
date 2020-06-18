<template>
  <div id="app" class="app">
    <Header @changeTheme="setTheme($event)"/>
    <transition name="fade">
      <router-view></router-view>
    </transition>
    <transition name="fade">
        <span @click="toTop()" v-if="showArrow" id="ArrowBox" class="ArrowBox"><i v-if="showArrow" class="arrow"></i>
        </span>
    </transition>
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
      USData: {},
      showArrow: false
    }
  },
  beforeCreate(){
    this.$store.dispatch('fetchData');
  },
  updated() {
    this.getTheme();
  },
  mounted () {
    window.addEventListener('scroll', this.onScroll);
    this.getTheme();
  },
  beforeDestroy () {
    window.removeEventListener('scroll', this.onScroll);
  },
  methods: {
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
      const classNames = ["app","header","ArrowBox","Datatable","searchBar","continentSel"];
      const Ids = ["name","population","total","active","recovered","critical","deaths","tests","casesPM","deathsPM","testsPM", "WorldTable", "USDataTable"];
      var errorMessages = "";

      if(Theme == "dark") {
        document.getElementById("dmCheck").checked = true;

        for(const className of classNames) {
          try{
            document.getElementsByClassName(className)[0].classList.remove("lightMode");
          } catch (err){
            errorMessages += err.message + ": " + className +"; ";
          }
        }

        for(const id of Ids) {
          try{
              document.getElementById(id).classList.remove("lightMode");
            } catch (err) {
            errorMessages += err.message + ": " + id +"; ";
          }
        }
      }
      else {
        document.getElementById("dmCheck").checked = false;

        for(const className of classNames) {
          try {
            document.getElementsByClassName(className)[0].classList.add("lightMode");
          } catch (err){
            errorMessages += err.message + ": " + className +"; ";
          }
        } 

        for(const id of Ids) {
          try{
              document.getElementById(id).classList.add("lightMode");
          } catch (err) {
            errorMessages += err.message + ": " + id +"; ";
          }
        }
      }

      console.log(errorMessages);
    },
    onScroll () { 
      const currentScrollPosition = window.pageYOffset || document.documentElement.scrollTop;

      //Display arrowbox after down scroll past 138 px.
      if (currentScrollPosition < 0) {
        return
      }
      if (currentScrollPosition > 138){
        this.showArrow = true;
      }
      if (currentScrollPosition < 138){
        this.showArrow = false;
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
  box-shadow: 0px 0px 10px 3px #182a43;
}
.ArrowBox:hover {
  background-color:  #24497a;
  color: #bcc1cd;
  cursor: pointer;
}
.ArrowBox.lightMode {
  box-shadow: 0px 0px 10px 0px #e1e1e1;
}
.ArrowBox.lightMode:hover {
  background-color:  #f8f8f8;
}
.lightMode {
  background-color: #FFFFFF;
  color: #3C3C3C;
}

/*Fade Transitions*/
.ArrowBox.fade-enter-active {
  transition: opacity 1.25s;
}
.ArrowBox.fade-leave-active {
  transition: opacity 0.5s;
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
