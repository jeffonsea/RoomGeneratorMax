Struct module (
	id,
	name,
	height,
	width,
	length,
	height_from_floor,
	isWindow = false,
	on create do format "in create: %\n" this,
	on clone do format "in clone: %\n" this
)