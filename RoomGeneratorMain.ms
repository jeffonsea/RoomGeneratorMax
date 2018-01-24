include "RoomGeneratorStructures.ms"
include "RoomGeneratorMainRollout.ms"
include "PersistanceManager.ms"

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
			preview_module.pivot = [0, 0, -previewing_module.height * 0.5]
			preview_module.pos = [0, 0, 0]
			preview_module.boxsize = [previewing_module.width, previewing_module.length, previewing_module.height]
			preview_box = Box height:previewing_module.height width:previewing_module.width length:previewing_module.length pos:[0, 0, 0]
			preview_box.parent = preview_module
		)
		else (
			preview_module.boxsize = [previewing_module.width, previewing_module.length, previewing_module.height]
			preview_module.children[1].height = previewing_module.height
			preview_module.children[1].width = previewing_module.width
			preview_module.children[1].length = previewing_module.length
		)
	)
)

function removeModulePreviews = (
	delete preview_module
)