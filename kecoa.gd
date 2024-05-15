extends Node3D
class_name Kecoa

@export var animation_player : AnimationPlayer
@export var coll_shape : CollisionShape3D
@export var nav_agent : NavigationAgent3D
@export var armature : Node3D

var target_position : Vector3
var size_state = 0
var target_size = 0
var scale_duration = 0
var start_animation = false
var start_size = 0
var start_offset = 0
var offset = [2.103, 2.254, 2.254]
var radius_nav = [0.25, 4.89, 15]
var prevent_walk = false
# Called when the node enters the scene tree for the first time.
func _ready():
	change_size(1, false)
	pass # Replace with function body.
	
func _process(delta):
	if start_animation:
		if scale_duration > 0:
			scale_duration -= delta
			var val = lerp(start_size, target_size, 1 - (scale_duration / 1.2))
			scale = Vector3(val, val, val)
			var y_val = lerp(start_offset, offset[size_state - 1], 1 - (scale_duration / 1.2))
			armature.position.y = y_val
		else:
			start_animation = false
		

func set_target_position(new_target: Vector3):
	target_position = new_target

func get_target_position():
	return target_position
	
func play_animation(new_anim: String):
	animation_player.play(new_anim)
	
func set_animation_scale(val: float):
	animation_player.speed_scale = val

func change_size(new_size: int, with_animation: bool):
	
	if size_state == new_size:
		return
	if new_size == 1:
		target_size = 0.05
	elif new_size == 2:
		target_size = 1.0
	elif new_size == 3:
		target_size = 3.0
	else:
		pass
	size_state = new_size
	nav_agent.radius = radius_nav[size_state - 1]
	if !with_animation:
		scale = (Vector3(target_size, target_size, target_size))
		armature.position.y = offset[size_state - 1]
	else:
		start_animation = true
		scale_duration = 1.2
		start_size = scale.x
		start_offset = armature.position.y
		print(new_size)


func _on_right_hand_button_pressed(name):
	print(name)
	if name == "ax_button":
		if  size_state >= 1 and  size_state < 3 and !start_animation:
			change_size(size_state + 1, true)
	if name == "by_button":
		if  size_state <= 3 and size_state > 1 and !start_animation:
			change_size(size_state - 1, true)
	if name == "trigger_click":
		prevent_walk = true

func _on_right_hand_button_released(name):
	if name == "trigger_click":
		prevent_walk = false
	
