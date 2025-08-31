extends Sprite2D

@onready var anim = $AnimationPlayer

func show_popup():
	show()
	anim.play("new_animation")
	await anim.animation_finished
	hide()
	return 
