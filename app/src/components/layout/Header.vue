<template>
	<header>
		<div class="header">
			<router-link class="title button" to="/">covidbase</router-link>
			<router-link class="about button" to="/About">About</router-link>
			<div class="darkmode">
				Dark mode
				<label id="dmButton" class="switch">
					<input id="dmCheck" type="checkbox" @change="lightmode()" checked>
					<span class="slider round"></span>
				</label>
			</div>
		</div>
	</header>
</template>

<script type="text/javascript">
export default {
	name: "Header",
	methods: {
		lightmode() {
			const classNames = ["header","title","about","worldTable","Datatable","searchBar","continentSel"];

			const Ids = ["app","dmButton","name","population","total","active","recovered","critical","deaths","tests","casesPM","deathsPM","testsPM","data"];

			for(const className of classNames) {
				document.getElementsByClassName(className)[0].classList.toggle("lightMode");
			}

			for(var id of Ids) {
				document.getElementById(id).classList.toggle("lightMode");
			}

		}
	}
}
</script>

<style scoped>
.header {
	/*display: inline-block;*/
	width: 100%;
	background-color:  #1b1b1e;
	padding: 10px;
}
.about {
	background-color:  #1b1b1e;
	color: #d8dbe2;
	border: none;
	margin-left: 25%;
}

.title {
	font-size: 135%;
	background-color:  #1b1b1e;
	color: #d8dbe2;
	margin-right: 25%;
	border: none;

}

.lightMode {
	background-color: #758BFD;
	color: #FFFFFF;
}

.button {
	text-decoration: none;
	outline: 0;
}
.button:hover {
	text-decoration: underline;
	cursor: pointer;
}

.darkmode {
	font-size: 75%;
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

/* Hide default HTML checkbox */
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