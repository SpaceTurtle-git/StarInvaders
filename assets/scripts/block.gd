extends Node2D

@export var move_speed = 20
var direction = Vector2.RIGHT

@onready var left_boundary = get_tree().root.get_node("main_scene/left_boundry")
@onready var right_boundary = get_tree().root.get_node("main_scene/right_boundry")

@onready var mark_right = $Marker2D
@onready var mark_left = $Marker2D2

func _physics_process(delta: float) -> void:
	
	#check if everyone is dead
	everyoneIsDead()
	if everyoneIsDead():
		var waveClear = get_tree().root.get_node("main_scene/waveCleared")
		waveClear.show_popup()
		global.waveNumber += 1
		queue_free()
		return
	#actual movement
	position += direction * move_speed * delta #movement
	
	# Bounce at boundaries
	if mark_right.global_position.x >= right_boundary.position.x:
		direction = Vector2.LEFT

	elif mark_left.global_position.x <= left_boundary.position.x:
		direction = Vector2.RIGHT

func everyoneIsDead():
	for child in get_children():
		if child.is_in_group("enemies"):
			return false
	return true
