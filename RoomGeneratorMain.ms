include "RoomGeneratorStructures.ms"
include "RoomGeneratorMainRollout.ms"
include "PersistanceManager.ms"

global module_generation_pos = [400, 0, 0]
global generated_modules = #()

global wall_modules   = #()
global window_modules = #()
global door_modules   = #()

global selected_wall_module = 0
global selected_window_module = 0
global selected_door_module = 0

global preview_enabled = false
global previewing_module = module id:0 name:"200.0x200.0x200.0" height:200.0 width:200.0 length:200.0
global preview_module

CreateDialog RoomGeneratorMainRollout

function handleModulePreview = (
	if preview_enabled then (
		generatePreviewModule()
	)
)

function generatePreviewModule = (
	if(previewing_module != undefined) then (

		if(IsValidNode(preview_module) == false) then (
			preview_module = Dummy()
			preview_module.name = "PreviewModule"
			preview_module.boxsize = [previewing_module.width, previewing_module.length, previewing_module.height]
			preview_module.pivot = [preview_module.min.x, preview_module.min.y, preview_module.min.z]
			preview_module.pos = [0, 0, 0]
			preview_box = Box height:previewing_module.height width:previewing_module.width length:previewing_module.length pos:[0, 0, 0]
			preview_box.name = previewing_module.name
			preview_box.pivot = [preview_box.min.x, preview_box.min.y, preview_box.min.z]
			preview_box.parent = preview_module
		)
		else (
			preview_module.boxsize = [previewing_module.width, previewing_module.length, previewing_module.height]
			preview_module.pivot = [preview_module.center.x, preview_module.center.y, preview_module.min.z]
			preview_module.pos = [0, 0, 0]
			preview_module.children[1].name = previewing_module.name
			preview_module.children[1].pivot = [preview_module.children[1].center.x, preview_module.children[1].center.y, preview_module.children[1].min.z]
			preview_module.children[1].pos = [0, 0, 0]
			preview_module.children[1].height = previewing_module.height
			preview_module.children[1].width = previewing_module.width
			preview_module.children[1].length = previewing_module.length
		)
	)
	else (
		print "Previewing Module is undefined.."
	)
)

function removeModulePreviews = (
	delete preview_module
)

function handleGenerateModules = (
	for wall in wall_modules do (

	)
)