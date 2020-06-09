<template>
  <div id="app" class="app">
    <Header/>
<!--     <transition name="fade">
      <router-view></router-view>
    </transition> -->
    <Homepage/>
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
  transition: opacity .75s;
}
.fade-leave-active {
  transition: opacity 0.25s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}


</style>
