extends State
class_name KecoaIdle

@export var idle_duration = 5.0
@export var kecoa : Kecoa

var idle_count = 0
func Enter():
	kecoa.play_animation("idle")
	idle_count = idle_duration
	
func Update(delta : float):
	if idle_count > 0:
		idle_count -= delta
	else:
		Transitioned.emit(self, "LookingAround")

func Exit():
	pass
