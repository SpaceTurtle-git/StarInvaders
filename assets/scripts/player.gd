extends CharacterBody2D

var firerate = 0.3
var firingcooldown: = 0.0
const SPEED = 400.0
var is_dead := false
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	#IS DEAD
	if is_dead:
		return
	#MOVEMENT
	var direction := Input.get_axis("go_left", "go_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("Fly")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/2)
		$AnimatedSprite2D.play("Idle")
	
	#FIRING
	fire_cooldown(delta)
	move_and_slide()

func fire():
	var bullet = preload("res://assets/scenes/bullet.tscn")
	var firedbullet = bullet.instantiate()
	$"../fireSound".play()
	firedbullet.position = Vector2(position.x,position.y - 50)
	get_parent().call_deferred("add_child",firedbullet)

func fire_cooldown(delta: float):
	if firingcooldown > 0:
		firingcooldown -= delta
	if Input.is_action_pressed("attack") and firingcooldown <= 0:
		fire()
		firingcooldown = firerate

func die():
	is_dead = true
	$"../playerDie".play()
	$AnimatedSprite2D.play("Explode")
	await $AnimatedSprite2D.animation_finished
	var button2menu = preload("res://assets/scenes/return.tscn")
	var button = button2menu.instantiate()
	get_tree().current_scene.add_child(button)
	button.position = Vector2(640, 360)
	queue_free()
