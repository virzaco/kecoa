extends State
class_name KecoaLookingAround

@export var looking_around_duration = 5.0
@export var kecoa : Kecoa
var looking_around_count = 0.0
func Enter():
	looking_around_count = looking_around_duration
	kecoa.play_animation("idle_2")
	get_new_location_in_range(10)
	
func Update(delta : float):
	if looking_around_count > 0:
		looking_around_count -= delta
	else:
		if !kecoa.prevent_walk:
			Transitioned.emit(self, "Walks")
		else:
			Transitioned.emit(self, "Idle")

func get_new_location_in_range(radius: float):
	var x = randf_range(kecoa.global_position.x - radius, kecoa.global_position.x + radius)
	var y = randf_range(kecoa.global_position.y - radius, kecoa.global_position.y + radius)
	var z = 0.0
	var next_target = check_location_in_nav(Vector3(x, y, z), 3)
	kecoa.set_target_position(next_target)

func check_location_in_nav(check_loc: Vector3, min_safe_distance: float) -> Vector3:
	var map = get_world_3d().get_navigation_map()
	var closest_point = NavigationServer3D.map_get_closest_point(map, check_loc)
	var delta = closest_point - check_loc
	var is_on_map = delta.is_zero_approx()
	if not is_on_map and min_safe_distance > 0:
		delta.normalized()
		closest_point += delta * min_safe_distance
	return closest_point
