include "RoomGeneratorStructures.ms"

try (DestroyDialog RoomGeneratorMainRollout) catch ()


rollout PersistanceRollout "Persistance"
(
	button 'btn1' "Load Modules" pos:[10,10] width:80 height:30 align:#left
	button 'btn2' "Save Modules" pos:[100,10] width:80 height:30 align:#left
	label  'lbl3' "test_modules.xml" pos:[200,20] width:120 height:15 align:#left
)

rollout WallsRollout "Walls"
(
	listbox wallDimensionsList "Module Dimensions:" items:(for o in wall_modules collect o.name) pos:[10, 15] width:120 align:#left

	button 'addModule' "Add Wall Module" pos:[10,10] width:80 height:30 align:#left
)

rollout WindowsRollout "Windows"
(
	listbox windowDimensionsList "Module Dimensions:" items:(for o in window_modules collect o.name) pos:[5,15] width:120 align:#left
)

rollout DoorsRollout "Doors"
(
	listbox doorDimensionsList "Module Dimensions:" items:(for o in door_modules collect o.name) pos:[5,15] width:120 align:#left
)

rollout RoomGeneratorMainRollout "Room Generator" width:350 height:300
(
	label 'TitleLabel' "Room Generator" pos:[120,5] width:100 height:15 enabled:true align:#left

	subRollout 'SR' "SubRollout"
	
	on RoomGeneratorMainRollout open do (
		AddSubRollout RoomGeneratorMainRollout.SR PersistanceRollout	
		AddSubRollout RoomGeneratorMainRollout.SR WallsRollout
		AddSubRollout RoomGeneratorMainRollout.SR WindowsRollout
		AddSubRollout RoomGeneratorMainRollout.SR DoorsRollout
		RoomGeneratorMainRollout.SR.height += 250
	)
)