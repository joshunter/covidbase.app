<template>
	<header>
		<div class="menu">
			<button class="Title">Website!</button>
			<button class="menuItem">Button</button>
		</div>
	</header>
</template>

<script type="text/javascript">
export default {
	name: "Header"
}
</script>

<style scoped>
.menu {
	background-color:  #1b1b1e;
	padding-top: 10px;
	padding-bottom: 10px;
}

.menu > .menuItem {
	background-color:  #1b1b1e;
	color: #d8dbe2;
	text-align: center;
	border: none;
	width: 50%;
}

.menu > .Title {
	font-size: 135%;
	background-color:  #1b1b1e;
	color: #d8dbe2;
	text-align: center;
	padding-right: 30px;
	border: none;
	width: 50%;

}
</style>