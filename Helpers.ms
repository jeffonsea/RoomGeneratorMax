function convertToEditPoly object = (
	if(object != undefined) then (
		convertTo object PolyMeshObject
	)
	else (
		messageBox ("Can't convert undefined to EditPoly")
	)
)