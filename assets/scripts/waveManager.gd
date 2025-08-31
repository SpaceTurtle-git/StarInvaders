extends Node2D

@export var waves: Array[PackedScene] = []

@onready var temp = global.waveNumber

func _ready():
	spawn_wave(global.waveNumber)

func _process(_delta: float) -> void:
	if temp != global.waveNumber:
		spawn_wave(global.waveNumber)
		temp = global.waveNumber

func spawn_wave(number: int):
	if number >= 0 and number < waves.size():
		var preloadedWave = waves[number].instantiate()
		add_child(preloadedWave)
	else:
		print("Waves ended")
		var button2menu = preload("res://assets/scenes/return.tscn")
		var button = button2menu.instantiate()
		get_tree().current_scene.add_child(button)
		button.get_node("Label").show()
		button.position = Vector2(640, 360)
		
