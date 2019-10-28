extends Area2D

const SPEED = 500

var motion = Vector2()
	
var mouse_position

func _process(delta):
	
	
	pass
	
func _physics_process(delta):
	motion.x = SPEED * delta
	translate(motion)

func _on_GraplingHook_body_entered(body):
	
	pass # Replace with function body.
	

