<template>
	<div>
		<WorldTable/>
		<CountriesTable/>
	</div>
</template>

<script>
import WorldTable from './WorldTable.vue';
import CountriesTable from './CountriesTable.vue';

export default {
  name: 'Homepage',
  components: {
    WorldTable,
    CountriesTable
  }
}
</script>



<style>
</style>