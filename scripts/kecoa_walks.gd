extends State
class_name KecoaWalks

@export var kecoa : Kecoa
@export var nav_agent : NavigationAgent3D
@export var armature : Node3D
@export var character : CharacterBody3D
@export var walk_max_duration = 5.0
@export var speed = 2
@export var acceleration = 10

var duration = 0.0
var target_loc : Vector3
var direction : Vector3
func Enter():
	duration = walk_max_duration
	target_loc = kecoa.get_target_position()
	kecoa.play_animation("walk")
	kecoa.set_animation_scale(10)

func Update(delta: float):
	pass

func Physics_Update(delta: float):
	kecoa.set_animation_scale(Get_Anim_Speed_relative_to_size())
	nav_agent.target_position = target_loc
	var next_pos = nav_agent.get_next_path_position()
	direction = next_pos - kecoa.global_position
	armature.look_at(Vector3(next_pos.x, armature.global_position.y, next_pos.z), Vector3.UP)
	armature.rotate_object_local(Vector3.UP, PI)
	direction = direction.normalized()
	
	character.velocity = character.velocity.lerp(direction * Get_Velocity_relative_to_size(), acceleration * delta)
	character.move_and_slide()
	duration -= delta;
	if duration < 0 or kecoa.global_position.distance_to(target_loc) < Get_Reach_Point():
		Transitioned.emit(self, "Idle")
	
	
func Exit():
	kecoa.set_animation_scale(1)
	
func Get_Reach_Point() -> float:
	var output = 0.0
	if kecoa.size_state == 1:
		output = 0.5
	elif kecoa.size_state == 2:
		output = 15
	elif kecoa.size_state == 3:
		output = 30
	else:
		pass
	return output
	
func Get_Velocity_relative_to_size() -> float:
	var output = 0.0
	if kecoa.size_state == 1:
		output = 1
	elif kecoa.size_state == 2:
		output = 5
	elif kecoa.size_state == 3:
		output = 10
	else:
		pass
	return output
	
func Get_Anim_Speed_relative_to_size() -> float:
	var output = 0.0
	if kecoa.size_state == 1:
		output = 10
	elif kecoa.size_state == 2:
		output = 8
	elif kecoa.size_state == 3:
		output = 2.5
	else:
		pass
	return output
