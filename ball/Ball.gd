extends RigidBody

func _ready():
	set_process_input(true);
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	pass

export var sensitivity = .5
export var tilt_limit = 30

var dir = Vector3()

func _input(event):
	if event is InputEventMouseMotion:
		var base = get_node("Tilt/InterpolatedCamera").base
		
		dir += base[2] * event.relative.x / 90 * sensitivity
		dir += base[0] * -event.relative.y / 90 * sensitivity
		dir.y = 0
		
		var limit = deg2rad(tilt_limit)
		
		if dir.length() > limit:
			dir = dir.normalized() * limit
		
		get_node("Tilt").tilt = dir

func _integrate_forces(state):
	var delta = state.get_step()
	var lv = state.get_linear_velocity()
	var g = state.get_total_gravity()
	
	# Tilt gravity
	g = g.rotated(Vector3(1,0,0), dir.x)
	g = g.rotated(Vector3(0,0,1), dir.z)

	lv += g*delta # Apply gravity
	
	state.set_linear_velocity(lv)