Struct module (
	id,
	name,
	height,
	width,
	length,
	on create do format "in create: %\n" this,
	on clone do format "in clone: %\n" this
)