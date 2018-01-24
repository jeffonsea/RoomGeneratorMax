try (DestroyDialog RoomGeneratorMainRollout) catch ()

list_width = 0.5

module_handler_pos_x = 0.025
module_handler_pos_y = 10

button_pos_x = 20

button_height = 30
button_width = 80

button_margin = 25

/*rollout PersistanceRollout "Persistance"
(
	button 'loadModulesButton' "Load Modules" pos:[PersistanceRollout.width * module_handler_pos_x, module_handler_pos_y] width:80 height:30 align:#left
	button 'saveModulesButton' "Save Modules" pos:[loadModulesButton.pos.x + 100, module_handler_pos_y] width:80 height:30 align:#left
	label  'loadedModulesFileLabel' "test_modules.xml" pos:[saveModulesButton.pos.x + 100, module_handler_pos_y + 10] width:120 height:15 align:#left
)*/

rollout WallsRollout "Walls"
(
	listbox wallDimensionsList "Module Dimensions:" items:(for o in wall_modules collect o.name) \
	pos:[WallsRollout.width * module_handler_pos_x, module_handler_pos_y + 40] width:(WallsRollout.width * list_width) align:#left

	button 'addModule' 		"Add Wall Module" \
	pos:[WallsRollout.width * module_handler_pos_x, module_handler_pos_y] width:80  height:30 align:#left
	button 'removeModule' 	"Remove Wall Module" \
	pos:[WallsRollout.width * module_handler_pos_x + 100, module_handler_pos_y] width:80  height:30 align:#left

	spinner heightSpinner 	"Height" 	range:[0,1000,10] \
	pos:[wallDimensionsList.width + button_pos_x, wallDimensionsList.pos.y]  width:150 height:40 align:#left
	spinner widthSpinner 	"Width" 	range:[0,1000,10] \
	pos:[wallDimensionsList.width + button_pos_x, heightSpinner.pos.y + button_margin] width:150 height:40 align:#left
	spinner lengthSpinner 	"Length" 	range:[0,1000,10] \
	pos:[wallDimensionsList.width + button_pos_x, widthSpinner.pos.y + button_margin] width:150 height:40 align:#left

	button 'applyValues' 	"Apply Values" \
	pos:[wallDimensionsList.width + button_pos_x, lengthSpinner.pos.y + button_margin] width:80  height:30 align:#left

	on wallDimensionsList selected wall_module_index do (
		selected_wall_module = wall_module_index

		updateWallModuleInfoDisplay()

		previewing_module = wall_modules[selected_wall_module]
		handleModulePreview()
	)

	on addModule pressed do (
		wall_mod = module id:0 name:"200.0x200.0x200.0" height:200.0 width:200.0 length:200.0
		append wall_modules wall_mod

		selected_wall_module = wall_modules.count

		updateWallModulesList()

		wallDimensionsList.selected = wall_modules[selected_wall_module].name

		updateWallModuleInfoDisplay()

		previewing_module = wall_modules[selected_wall_module]

		handleModulePreview()
	)

	on removeModule pressed do (
		if (wall_modules.count > 0) do (
			deleteItem wall_modules selected_wall_module

			updateWallModulesList()

			if(wall_modules.count > 0) then (
				selected_wall_module = wall_modules.count
				updateWallModuleInfoDisplay()

				previewing_module = wall_modules[selected_wall_module]

				handleModulePreview()
			)
			else (
				selected_wall_module = -1
			)
		)
	)

	on applyValues pressed do (
		if (wall_modules.count > 0) do (
			wall_modules[selected_wall_module].height = heightSpinner.value
			wall_modules[selected_wall_module].width = widthSpinner.value
			wall_modules[selected_wall_module].length = lengthSpinner.value

			wall_modules[selected_wall_module].name = wall_modules[selected_wall_module].height as string + "x" + wall_modules[selected_wall_module].width as string + "x" + wall_modules[selected_wall_module].length as string
			updateWallModulesList()

			previewing_module = wall_modules[selected_wall_module]
			handleModulePreview()
		)
	)
)

function updateWallModulesList = (
	WallsRollout.wallDimensionsList.items = (for o in wall_modules collect o.name)
)

function updateWallModuleInfoDisplay = (
	WallsRollout.heightSpinner.value = wall_modules[selected_wall_module].height
	WallsRollout.widthSpinner.value = wall_modules[selected_wall_module].width
	WallsRollout.lengthSpinner.value = wall_modules[selected_wall_module].length
)

rollout WindowsRollout "Windows"
(
	listbox windowDimensionsList "Module Dimensions:" items:(for o in window_modules collect o.name) \
	pos:[windowsRollout.width * module_handler_pos_x, module_handler_pos_y + 40] width:(windowsRollout.width * list_width) align:#left

	button 'addModule' 		"Add Window Module" \
	pos:[WindowsRollout.width * module_handler_pos_x, module_handler_pos_y] width:80  height:30 align:#left
	button 'removeModule' 	"Remove Window Module" \
	pos:[WindowsRollout.width * module_handler_pos_x + 100, module_handler_pos_y] width:80  height:30 align:#left

	spinner heightSpinner 	"Height" 	range:[0,1000,10] \
	pos:[windowDimensionsList.width + button_pos_x, windowDimensionsList.pos.y]  width:150 height:40 align:#left
	spinner widthSpinner 	"Width" 	range:[0,1000,10] \
	pos:[windowDimensionsList.width + button_pos_x, heightSpinner.pos.y + button_margin] width:150 height:40 align:#left
	spinner lengthSpinner 	"Length" 	range:[0,1000,10] \
	pos:[windowDimensionsList.width + button_pos_x, widthSpinner.pos.y + button_margin] width:150 height:40 align:#left
	spinner heightFromFloorSpinner 	"Margin" range:[0,1000,0] \
	pos:[windowDimensionsList.width + button_pos_x, lengthSpinner.pos.y + button_margin] width:150 height:40 align:#left

	button 'applyValues' 	"Apply Values" \
	pos:[windowDimensionsList.width + button_pos_x, heightFromFloorSpinner.pos.y + button_margin] width:80  height:30 align:#left

	on windowDimensionsList selected window_module_index do (
		selected_window_module = window_module_index

		updateWindowModuleInfoDisplay()

		previewing_module = window_modules[selected_window_module]
		
	)

	on addModule pressed do (
		window_mod = module id:0 name:"200.0x200.0x200.0 | 100" height:200.0 width:200.0 length:200.0 height_from_floor:100 isWindow:true
		append window_modules window_mod

		selected_window_module = window_modules.count

		updateWindowModulesList()

		windowDimensionsList.selected = window_modules[selected_window_module].name

		updateWindowModuleInfoDisplay()

		previewing_module = window_modules[selected_window_module]
		
	)

	on removeModule pressed do (
		if (window_modules.count > 0) do (
			deleteItem window_modules selected_window_module

			updateWindowModulesList()

			if(window_modules.count > 0) then (
				selected_window_module = window_modules.count
				updateWindowModuleInfoDisplay()

				previewing_module = window_modules[selected_window_module]
				
			)
			else (
				selected_window_module = -1
			)
		)
	)

	on applyValues pressed do (
		if (window_modules.count > 0) do (
			window_modules[selected_window_module].height = heightSpinner.value
			window_modules[selected_window_module].width = widthSpinner.value
			window_modules[selected_window_module].length = lengthSpinner.value
			window_modules[selected_window_module].height_from_floor = heightFromFloorSpinner.value

			window_modules[selected_window_module].name = window_modules[selected_window_module].height as string + "x" + window_modules[selected_window_module].width as string + "x" + window_modules[selected_window_module].length as string + " | " + window_modules[selected_window_module].height_from_floor as string
			updateWindowModulesList()

			previewing_module = window_modules[selected_window_module]
			
		)
	)
)

function updateWindowModulesList = (
	WindowsRollout.windowDimensionsList.items = (for o in window_modules collect o.name)
)

function updateWindowModuleInfoDisplay = (
	WindowsRollout.heightSpinner.value = window_modules[selected_window_module].height
	WindowsRollout.widthSpinner.value = window_modules[selected_window_module].width
	WindowsRollout.lengthSpinner.value = window_modules[selected_window_module].length
	WindowsRollout.heightFromFloorSpinner.value = window_modules[selected_window_module].height_from_floor
)

rollout DoorsRollout "Doors"
(
	listbox doorDimensionsList "Module Dimensions:" items:(for o in door_modules collect o.name) \
	pos:[DoorsRollout.width * module_handler_pos_x, module_handler_pos_y + 40] width:(doorsRollout.width * list_width) align:#left

	button 'addModule' 		"Add door Module" \
	pos:[DoorsRollout.width * module_handler_pos_x, module_handler_pos_y] width:80  height:30 align:#left
	button 'removeModule' 	"Remove door Module" \
	pos:[DoorsRollout.width * module_handler_pos_x + 100, module_handler_pos_y] width:80  height:30 align:#left

	spinner heightSpinner 	"Height" 	range:[0,1000,10] \
	pos:[doorDimensionsList.width + button_pos_x, doorDimensionsList.pos.y]  width:150 height:40 align:#left
	spinner widthSpinner 	"Width" 	range:[0,1000,10] \
	pos:[doorDimensionsList.width + button_pos_x, heightSpinner.pos.y + button_margin] width:150 height:40 align:#left
	spinner lengthSpinner 	"Length" 	range:[0,1000,10] \
	pos:[doorDimensionsList.width + button_pos_x, widthSpinner.pos.y + button_margin] width:150 height:40 align:#left

	button 'applyValues' 	"Apply Values" \
	pos:[doorDimensionsList.width + button_pos_x, lengthSpinner.pos.y + button_margin] width:80  height:30 align:#left

	on doorDimensionsList selected door_module_index do (
		selected_door_module = door_module_index

		updatedoorModuleInfoDisplay()

		previewing_module = door_modules[selected_door_module]
		
	)

	on addModule pressed do (
		door_mod = module id:0 name:"200.0x200.0x200.0" height:200.0 width:200.0 length:200.0
		append door_modules door_mod

		selected_door_module = door_modules.count

		updatedoorModulesList()

		doorDimensionsList.selected = door_modules[selected_door_module].name

		updatedoorModuleInfoDisplay()

		previewing_module = door_modules[selected_door_module]
		
	)

	on removeModule pressed do (
		if (door_modules.count > 0) do (
			deleteItem door_modules selected_door_module

			updatedoorModulesList()

			if(door_modules.count > 0) then (
				selected_door_module = door_modules.count
				updatedoorModuleInfoDisplay()

				previewing_module = door_modules[selected_door_module]
				
			)
			else (
				selected_door_module = -1
			)
		)
	)

	on applyValues pressed do (
		if (door_modules.count > 0) do (
			door_modules[selected_door_module].height = heightSpinner.value
			door_modules[selected_door_module].width = widthSpinner.value
			door_modules[selected_door_module].length = lengthSpinner.value

			door_modules[selected_door_module].name = door_modules[selected_door_module].height as string + "x" + door_modules[selected_door_module].width as string + "x" + door_modules[selected_door_module].length as string
			updatedoorModulesList()

			previewing_module = door_modules[selected_door_module]
			
		)
	)
)

function updatedoorModulesList = (
	DoorsRollout.doorDimensionsList.items = (for o in door_modules collect o.name)
)

function updatedoorModuleInfoDisplay = (
	DoorsRollout.heightSpinner.value = door_modules[selected_door_module].height
	DoorsRollout.widthSpinner.value = door_modules[selected_door_module].width
	DoorsRollout.lengthSpinner.value = door_modules[selected_door_module].length
)

rollout RoomGeneratorMainRollout "Room Generator" width:600 height:800
(
	label 'TitleLabel' "Room Generator" pos:[120, 5] width:100 height:15 enabled:true align:#left

	subRollout 'SR' "SubRollout"

	checkbox 'previewCheckBox' 	"Generate Previews" 	pos:[20, RoomGeneratorMainRollout.height - 50] width:120 height:30 align:#left
	button   'generateButton' 	"Generate Modules"   	pos:[previewCheckBox.pos.x + 120, RoomGeneratorMainRollout.height - 50] width:80 height:30 align:#left
	button   'closeButton' 		"Close" 				pos:[RoomGeneratorMainRollout.width - 100, RoomGeneratorMainRollout.height - 50] width:80 height:30 align:#left

	on RoomGeneratorMainRollout open do (
		/*AddSubRollout RoomGeneratorMainRollout.SR PersistanceRollout	*/
		AddSubRollout RoomGeneratorMainRollout.SR WallsRollout
		AddSubRollout RoomGeneratorMainRollout.SR WindowsRollout
		AddSubRollout RoomGeneratorMainRollout.SR DoorsRollout
		RoomGeneratorMainRollout.SR.height += RoomGeneratorMainRollout.height - 100	

		preview_enabled = true
		previewCheckBox.state = true
	)

	on previewCheckBox changed state do (
		if(state) then (
			messagebox ("Preview generation is enabled.")
		) else (
			messagebox ("Preview generation is disabled.")
			removeModulePreviews()
		)

		preview_enabled = state
	)

	on generateButton pressed do (
		handleGenerateModules()
	)

	on closeButton pressed do (
		try (DestroyDialog RoomGeneratorMainRollout) catch ()
	)
)