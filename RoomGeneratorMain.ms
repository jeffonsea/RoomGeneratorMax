include "RoomGeneratorStructures.ms"
include "RoomGeneratorMainRollout.ms"
include "PersistanceManager.ms"

global wall_modules   = #();
global window_modules = #();
global door_modules   = #();

wall_instance = module id:0 name:"200x200x200" height:200 width:200 length:200

append wall_modules wall_instance

CreateDialog RoomGeneratorMainRollout