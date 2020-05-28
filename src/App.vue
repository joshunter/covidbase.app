<template>
  <div id="app" class="app">
    <Header/>
    <br>
    <transition name="fade">
      <Homepage/>
    </transition>

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
  min-width: 350px;
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
  transition: opacity .6s;
}
.fade-leave-active {
  transition: opacity .1s
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}


</style>
