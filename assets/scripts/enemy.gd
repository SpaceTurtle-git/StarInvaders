extends CharacterBody2D

@export var score_value = 10
@export var shootchance = 30  # % chance to shoot per attempt
@export var firerate = 1.0
var firingcooldown = 0.0
var is_dead := false

func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	#If dead
	if is_dead:
		return
	#Idle Animation
	$AnimatedSprite2D.play("idle")
	#Firing Logic
	if firingcooldown > 0:
		firingcooldown -= delta
	else:
		var roll = randi_range(0, 100)
		if roll <= shootchance:
			fire()
		firingcooldown = firerate

func die():
	is_dead = true
	global.score += score_value
	var dieSound = get_tree().root.get_node("main_scene/enemyDie")
	dieSound.play()
	$AnimatedSprite2D.play("die")
	await $AnimatedSprite2D.animation_finished
	queue_free()

func fire():
	var bullet = preload("res://assets/scenes/enemy_bullet.tscn")
	var firedbullet = bullet.instantiate()
	firedbullet.position = Vector2(position.x, position.y + 20)
	get_parent().call_deferred("add_child", firedbullet)
