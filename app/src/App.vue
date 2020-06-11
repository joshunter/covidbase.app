<template>
  <div id="app" class="app">
    <Header/>
    <transition name="fade">
      <router-view></router-view>
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
  mounted () {
    window.addEventListener('scroll', this.onScroll)
  },
  beforeDestroy () {
    window.removeEventListener('scroll', this.onScroll)
  },
  methods: {
    onScroll () {
      const currentScrollPosition = window.pageYOffset || document.documentElement.scrollTop

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
    toTop() {
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
  background-color:  #1b2e4b;
  color: #d8dbe2;
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
.ArrowBox:hover {
  background-color:  #24497a;
  color: #bcc1cd;
  box-shadow: 0px 0px 10px 3px #182a43;
}
.ArrowBox.ArrowBox--hidden {
  display: none;
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
}
.fade-enter-active {
  transition: opacity 1.25s;
}
.fade-leave-active {
  transition: opacity 0.25s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}


</style>
