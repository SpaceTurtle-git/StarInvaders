extends CharacterBody2D

var lifetime = 5
var spawnlifetime = 0
@export var speed = 500
@export var acceleration = 0

func _ready():
	velocity.y =  -speed



func _physics_process(delta: float) -> void:
	velocity.y -= acceleration
	spawnlifetime += delta
	if spawnlifetime > lifetime:
		queue_free()
	
	var collision = move_and_collide(velocity * delta)
	
	if collision and collision.get_collider().has_method("die"):
		var body = collision.get_collider()
		if body and body.has_method("die"):
			body.die()
		call_deferred("queue_free")

func die():
	call_deferred("queue_free")
