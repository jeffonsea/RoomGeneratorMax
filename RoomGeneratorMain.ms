include "RoomGeneratorStructures.ms"
include "RoomGeneratorMainRollout.ms"
include "PersistanceManager.ms"
include "Helpers.ms"

global module_generation_pos = [0, 400, 0]
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
			preview_module.pivot = preview_module.min
			preview_module.pos = [0, 0, 0]
			preview_box = Box height:previewing_module.height width:previewing_module.width length:previewing_module.length pos:[0, 0, 0]
			preview_box.name = previewing_module.name
			preview_box.pivot = preview_box.min
			preview_box.parent = preview_module
		)
		else (
			preview_module.children[1].name = previewing_module.name
			preview_module.children[1].pos = [0, 0, 0]
			preview_module.children[1].height = previewing_module.height
			preview_module.children[1].width = previewing_module.width
			preview_module.children[1].length = previewing_module.length
			preview_module.children[1].pivot = preview_module.children[1].min
			preview_module.boxsize = [previewing_module.width, previewing_module.length, previewing_module.height]
			preview_module.pivot = preview_module.min
			preview_module.pos = [0, 0, 0]
		)
	)
	else (
		print "Previewing Module is undefined.."
	)
)

function removeModulePreviews = (
	delete preview_module
)

function incrustWindow wall_module:undefined window_module:undefined = (
	select wall_module.object.children[1]

	subobjectLevel = 2

	$.EditablePoly.SetSelection #Edge #{22, 30, 32, 34, 45, 50, 52, 53}
	move $.selectedEdges [0, 0, -(wall_module.module.height / 3.0)]
	move $.selectedEdges [0, 0, window_module.height_from_floor]

	$.EditablePoly.SetSelection #Edge #{25, 36, 38, 40, 47, 55, 57, 58}
	move $.selectedEdges [0, 0, -(wall_module.module.height / 3.0) * 2]
	move $.selectedEdges [0, 0, window_module.height_from_floor + window_module.height]

	$.EditablePoly.SetSelection #Edge #{6, 16, 31, 37, 42, 49, 54, 59}
	move $.selectedEdges [0, (window_module.width * 0.5), 0]

	$.EditablePoly.SetSelection #Edge #{2, 13, 29, 35, 41, 51, 56, 60}
	move $.selectedEdges [0, -(window_module.width * 0.5), 0]

	subobjectLevel = 4
	$.EditablePoly.SetSelection #Face #{14, 26}

	$.EditablePoly.delete #Face

	subobjectLevel = 3
	$.EditablePoly.SetSelection #Edge #{32, 35, 37, 38, 52, 54, 56, 57}
	$.bridgeSelected = 1
	$.EditablePoly.Bridge ()
)

function incrustDoor wall_module:undefined door_module:undefined = (

	print door_module.height as string

	select wall_module.object.children[1]

	subobjectLevel = 2

	$.EditablePoly.SetSelection #Edge #{25, 36, 38, 40, 47, 55, 57, 58}
	move $.selectedEdges [0, 0, -(wall_module.module.height / 3.0) * 2.0]
	move $.selectedEdges [0, 0, door_module.height]

	$.EditablePoly.SetSelection #Edge #{22, 30, 32, 34, 45, 50, 52, 53}
	move $.selectedEdges [0, 0, -(wall_module.module.height / 3.0)]
	move $.selectedEdges [0, 0, door_module.height * 0.5]

	$.EditablePoly.SetSelection #Edge #{6, 16, 31, 37, 42, 49, 54, 59}
	move $.selectedEdges [0, -(wall_module.module.length / 3.0) * 0.5, 0]
	move $.selectedEdges [0, door_module.width * 0.5, 0]

	$.EditablePoly.SetSelection #Edge #{2, 13, 29, 35, 41, 51, 56, 60}
	move $.selectedEdges [0, (wall_module.module.length / 3.0) * 0.5, 0]
	move $.selectedEdges [0, -door_module.width * 0.5, 0]

	subobjectLevel = 4
	$.EditablePoly.SetSelection #Face #{11, 14, 23, 26}

	$.EditablePoly.delete #Face

	subobjectLevel = 3
	$.EditablePoly.SetSelection #Edge #{5, 7, 29, 31, 34, 36, 37, 48, 50, 52, 54, 55}
	$.bridgeSelected = 1
	$.EditablePoly.Bridge ()

	$.EditablePoly.SetSelection #Face #{2}
	$.EditablePoly.delete #Face
)

function generateModule wall_module:undefined window_module:undefined door_module:undefined = (
	if (wall_module == undefined) then (
		print "Generating module requires wall module"
	)
	else (
		print ("Generating module with wall_module " + wall_module.name)

		gen_mod = generatedModule()

		gen_mod.module = wall_module

		module_dummy = Dummy()
		module_dummy.name = wall_module.name
		module_dummy.boxsize = [wall_module.width, wall_module.length, wall_module.height]
		module_dummy.pivot = module_dummy.min
		module_dummy.pos = module_generation_pos

		module_obj = Box height:wall_module.height width:wall_module.width length:wall_module.length \
		heightSegs:3 lengthSegs:3
		module_obj.pivot = module_obj.min
		module_obj.pos = module_generation_pos
		module_obj.parent = module_dummy
		module_obj.name = ("SM_Wall_" + wall_module.name)

		select module_obj

		convertToEditPoly module_obj

		gen_mod.object = module_dummy

		if(window_module != undefined) do (
			incrustWindow wall_module:gen_mod window_module:window_module ()
		)

		if(door_module != undefined) do (
			incrustDoor wall_module:gen_mod door_module:door_module ()
		)

		append generated_modules gen_mod

		module_generation_pos.y = module_generation_pos.y + wall_module.length + 100
	)
)

function handleGenerateModules = (
	module_generation_pos = [0, 400, 0]

	if(generated_modules.count > 0) do (
		delete $*
	)

	generated_modules = #()

	if(wall_modules.count == 0) then (
		messagebox ("Module generation requires wall modules. Add a wall module.")
	)
	else (
		for wall in wall_modules do (
			generateModule wall_module:wall()

			for window_mod in window_modules do (
				if(window_mod.width < wall.length and (window_mod.height + window_mod.height_from_floor) < wall.height) do (
					generateModule wall_module:wall window_module:window_mod ()
				)
			)

			for door in door_modules do (
				if(door.width < wall.length and door.height < wall.height) do (
					generateModule wall_module:wall door_module:door ()
				)
			)
		)
	)
)