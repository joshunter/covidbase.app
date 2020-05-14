<template>
	<div>
		<b-dropdown text="Filter" class="m-2">
			<b-dd-item-btn>Action</b-dd-item-btn>
			<b-dd-item-btn>Another action</b-dd-item-btn>
			<b-dd-item-btn>Something else here</b-dd-item-btn>
		</b-dropdown>
	</div>
</template>

<script>
import BDropdown from 'bootstrap-vue'
import BDropdownItemButton from 'bootstrap-vue'

export default{
	name: "RegionFilter",
	components: {
		'b-dropdown': BDropdown,
		'b-dd-item-btn': BDropdownItemButton
	}
}
</script>

<style scoped>

</style>