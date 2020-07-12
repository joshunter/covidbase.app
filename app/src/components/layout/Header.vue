<template>
	<header>
		<div class="header">
			<router-link class="title button" id="title" @click.native="blur()" :to="{ name: 'Homepage' }">covidbase</router-link>
			<router-link class="about button" id="about" @click.native="blur()" :to="{ name: 'about' }">about</router-link>
			<br>
			<button @click="toggleDM()" class="darkmode" id="darkmode">
				dark mode
				<label id="dmButton" class="switch">
					<input id="dmCheck" type="checkbox" @change="toggleDM()" checked>
					<span class="slider round"></span>
				</label>
			</button>
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
			document.getElementById("darkmode").blur();
		},
		blur() {
			document.getElementById('title').blur();
			document.getElementById('about').blur();
		}
	}
}
</script>

<style scoped>
.header {
	display: inline-block;
	width: 100%;
	top: 0px;
	left: 0px;
	height: 48px;
	padding: 4px;
	vertical-align: center;
	background-color:  #1b1b1e;
}
.button {
	color: #d8dbe2;
	text-decoration: none;
	outline: 0;
}
.button:focus {
	outline: 1px solid #FFFFFF;
}
.lightMode .button:focus {
	outline: 2px solid #fff;
}
.button:active {
	outline: 0;
}
.lightMode .button:active {
	outline: 0;
}
.button:hover {
	color: #ffffff;
	cursor: pointer;
}
.lightMode .button:hover {
	color: #e0e0e0;
}
.lightMode .button{
	color: #ffffff;
}

.about {
	position: absolute;
	right: 8%;
	top: 8px;
}
.title {
	font-size: 135%;
	position: absolute;
	left: 7%;
}
.darkmode {
	position: absolute;
	left: 7%;
	top: 31px;
	width: 90px;
	font-size: 85%;
	background-color: #1b1b1e;
	outline: 0;
	border:0;
	color: #d8dbe2;
}
.darkmode:hover {
	color: #ffffff;
	cursor: pointer;
}
.darkmode:focus {
	outline: 1px solid #fff;
}
.darkmode:active {
	outline: 0;
	color: transparent;
	text-shadow: 0 0 0 #d8dbe2;
}
.darkmode:-moz-focusring {
	color: transparent;
	text-shadow: 0 0 0 #d8dbe2;
}

.lightMode button.darkmode {
	background-color: #1f40ff;
	color: #ffffff;
}

.lightMode button.darkmode:hover {
	color: #e0e0e0;
}
.lightMode button.darkmode:-moz-focusring {
  color: transparent;
  text-shadow: 0 0 0 #ffffff;
}
.lightMode{
	background-color: #1f40ff;
	color: #ffffff;
}
/*.covfefeIcon{
	position: relative;
	right: 37px;
}
.covfefePicture {
	width:27.6px;
	height:18px;
}*/
input:focus {
	outline: 1px solid #FFF;
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