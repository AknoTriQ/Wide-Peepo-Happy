extends KinematicBody2D

const GRAVITY = 40
const SPEED = 2

var motion : = Vector2()

func _physics_process(delta):
	
	motion.y += GRAVITY
	
	
	motion = move_and_slide(motion)
	
	pass
	