<template>
	<div >
		<br>
		<br>
		<h2><p>I'm working on an about page as you read this.</p></h2>
		<br>
		In the meantime,<br>
		help me keep this site ad-free: <a href="https://ko-fi.com/joshunter" class="covfefeIcon"><img src="./components/images/kofi(small).png" alt="HTML5 Icon" style="width:27.6px;height:18px;"></a>

		<br>
		email me with comments/suggestions: <a href="mailto:josh@covidbase.app" class="email">josh@covidbase.app</a>
		<div class="sources">
			<h2><p>Sources:</p></h2>
			<a href="https://cloud.google.com/blog/products/data-analytics/free-public-datasets-for-covid19"><img class="sourceImage" src="./components/images/google_cloud_logo.png" alt="gcloud_logo"></a>

			<a href="https://www.worldometers.info/coronavirus/"><img class="sourceImage" src="./components/images/worldometers-logo.jpg" alt="WoM_Logo"></a>
		</div>
		
		
	</div>
</template>

<style scoped>
.email {
	text-decoration: none;
	color: #d8dbe2;
}
.email:hover{
	text-decoration: underline;
}
.lightMode .email{
	color:#3c3c3c;
}
.covfefeIcon {
	padding-bottom: 3px;
}
.sourceImage{
	margin: 20px;
	width: 195px;
	height: 52px;
	border-radius: 7px;
}
.sources {
	padding: 20px;
}
</style>