extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var interface : OpenXRInterface = XRServer.find_interface("OpenXR")
	if interface and interface.is_initialized():
		get_viewport().use_xr = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
