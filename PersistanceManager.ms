dotNet.loadAssembly "system.xml"

xmlDoc=dotNetObject "system.xml.xmlDocument"

--Create a root element for the xml doc and add it to the xmlDocument.
root=xmlDoc.createElement "RoomGenerator"
xmlDoc.appendChild root

modules=xmlDoc.createElement "modules"
root.appendChild modules

wall_modules=xmlDoc.createElement "walls"
modules.appendChild wall_modules

window_modules=xmlDoc.createElement "windows"
modules.appendChild window_modules