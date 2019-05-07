extends Spatial

func _ready():
	# This detaches the camera transform from the parent spatial node
	set_as_toplevel(true)
	
var tilt = Vector3()

func remove_tilt():
	self.transform = get_parent().get_global_transform()
	
	self.rotation = Vector3(0,0,0)

func apply_tilt():
	self.rotation.x = tilt.x
	self.rotation.z = tilt.z