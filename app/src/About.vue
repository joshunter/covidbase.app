<template>
	<div class="paddy">
		<h3>Thanks for checking out my website!</h3><br>
		<span>
			<p>
				I wanted to create something that was intuative enough and provided infomation quickly and functionally
				without bombarding the user with a bulky website.
			</p>
			<p>
				COVID-19 is a global issue after all, and not everyone has the resources to regularly download entire applications, 
				but everyone has the right to stay informed. 
			</p>
			<p>
				I hope you're able to use the website as I intended it.
			</p>
		</span>

		<div class="sources">
			<h2><p>Sources:</p></h2>
			<a href="https://cloud.google.com/blog/products/data-analytics/free-public-datasets-for-covid19">
				<img class="sourceImage" src="./components/images/google_cloud_logo.jpg" alt="gcloud_logo"></a>
			<a href="https://www.worldometers.info/coronavirus/">
				<img class="sourceImage" src="./components/images/worldometers-logo.jpg" alt="WoM_Logo"></a>
		</div>

		<p>
			help me keep the lights on: <a href="https://ko-fi.com/joshunter" class="covfefeIcon">
				<img class="covfefe" src="./components/images/kofi(small).png" alt="HTML5 Icon" style="width:27.6px;height:18px;"></a><br>
			comments & suggestions: <a href="mailto:josh@covidbase.app" class="email">josh@covidbase.app</a>
		</p>
	</div>
</template>

<style scoped>
p{padding: 7px;}

.paddy{padding: 40px;}

.email {
	text-decoration: none;
	color: #d8dbe2;
}
.email:hover{text-decoration: underline;}
.lightMode .email{color:#3c3c3c;}

.covfefeIcon {padding-bottom: 3px;}

.covfefe{transition:1s;}
.covfefe:hover {transform: rotate(360deg);}

.sourceImage{
	margin: 20px
;	width: 195px;
	height: 52px;
	border-radius: 7px;
}
.sources {
	padding-top: 80px;
	padding-bottom: 70px;
}
</style>