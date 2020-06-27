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
      showArrow: false,
    }
  },
  beforeCreate(){
    this.$store.dispatch('fetchData');
    this.$store.dispatch('fetchUSData');
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
      const classNames = ["header", "nameButton","populationButton","totalButton","activeButton","recoveredButton","criticalButton","deathsButton","testsButton","casesPMButton","deathsPMButton","testsPMButton", "searchBar", "arrowButton", "showButton", "customTable", "dataTable", "continentSel"];
      const Ids = ["app", "name","population","total","active","recovered","critical","deaths","tests","casesPM","deathsPM","testsPM", "continentSel", "USDataTotal","ArrowBox"];
      var errorMessages = "";

      if(Theme == "dark") {
        document.getElementById("dmCheck").checked = true;

        for(const className of classNames) {
          const elements = document.getElementsByClassName(className);
          for(var i=0, length=elements.length|0; i<length; i=i+1|0){
            try{
              elements[i].classList.remove("lightMode");
            } catch (err){
              errorMessages += err.message + ": " + className +"; ";
            }
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
          const els = document.getElementsByClassName(className);
          for(var ii=0, len=els.length|0; ii<len; ii=ii+1|0){
            try {
              els[ii].classList.add("lightMode");
            } catch (err){
              errorMessages += err.message + ": " + className +"; ";
            }            
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
/* latin-ext */
@font-face {
  font-family: 'Lato';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: local('Lato Regular'), local('Lato-Regular'), url(https://fonts.gstatic.com/s/lato/v16/S6uyw4BMUTPHjxAwXjeu.woff2) format('woff2');
  unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB, U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}
/* latin */
@font-face {
  font-family: 'Lato';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: local('Lato Regular'), local('Lato-Regular'), url(https://fonts.gstatic.com/s/lato/v16/S6uyw4BMUTPHjx4wXg.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

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

/*Fade Transitions between pages*/
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
