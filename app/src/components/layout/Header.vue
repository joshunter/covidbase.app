<template>
	<header>
		<div class="header">
			<router-link class="title button" :to="{ name: 'Homepage' }">covidbase</router-link>
			<router-link class="about button" :to="{ name: 'about' }">about</router-link>
			<br>
			<span @click="toggleDM()" class="darkmode" id="darkmode">
				dark mode
				<label id="dmButton" class="switch">
					<input id="dmCheck" type="checkbox" @change="toggleDM()" checked>
					<span class="slider round"></span>
				</label>
			</span>
			<a class="covfefeIcon" href="https://ko-fi.com/joshunter"><img class="covfefePicture" src="./kofi(small).png" alt="Covfefe"></a>
		</div>
	</header>
</template>

<script type="text/javascript">
export default {
	name: "Header",
	methods: {
		toggleDM(){
			var currTheme = localStorage.getItem("theme");

			if(currTheme == "dark") {
				localStorage.setItem("theme","light");
				currTheme = "light";
			} else {
				localStorage.setItem("theme","dark");
				currTheme = "dark";
			}

			this.$emit('changeTheme',currTheme);
		}
	}
}
</script>

<style scoped>
.header {
	display: inline-block;
	width: 100%;
	padding: 3px;
	vertical-align: center;
	background-color:  #1b1b1e;
}
.button {
	color: #d8dbe2;
	text-decoration: none;
	outline: 0;
}
.button:hover {
	text-decoration: underline;
	cursor: pointer;
}
.lightMode .button{
	color: #ffffff;
}

.about {
	position: relative;
	left: 25%;
}
.title {
	font-size: 135%;
	position: relative;
	right: 32%;
}
.darkmode {
	position: relative;
	right: 32%;
	width: 90px;
	font-size: 85%;
}
.darkmode:hover {
	text-decoration: underline;
	cursor: pointer;
}
.lightMode{
	background-color: #1f40ff;
	color: #ffffff;
}
.covfefeIcon{
	position: relative;
	right: 37px;
}
.covfefePicture {
	width:27.6px;
	height:18px;
}
input:checked + .slider {
  background-color: #1b2e4b;
}
input:focus + .slider {
  box-shadow: 0 0 1px #1b2e4b;
}
input:checked + .slider:before {
  -webkit-transform: translateX(6.5px);
  -ms-transform: translateX(6.5px);
  transform: translateX(6.5px);
}

.switch {
	position: relative;
	display: inline-block;
	width: 15px;
	height: 8.5px;
}
.switch input {
  opacity: 0;
  width: 0;
  height: 0;
}
.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}
.slider:before {
  position: absolute;
  content: "";
  height: 6.5px;
  width: 6.5px;
  left: 1px;
  bottom: 1px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}
.slider.round {
  border-radius: 34px;
}
.slider.round:before {
  border-radius: 50%;
}
</style>