extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 18
const SPEED = 160
const JUMP_HEIGHT = 395

var health = 200

var attacking = false

var mouse_position = get_global_mouse_position()

const GRAPPLING_HOOK = preload("res://Sceens/Grapling Hook.tscn")

var _state

var motion : = Vector2()


func _physics_process(delta):
	if not _state == "state_dead":
		if attacking == false:
			$"Player AnimatedSprite/Hitbox Shape".disabled = true
		
		motion.y += GRAVITY
		
		$Camera2D.smoothing_enabled =true
		
		$Camera2D.smoothing_speed = 4
		
		$Camera2D.zoom = Vector2(0.8, 0.8)
		
		if Input.is_action_pressed("ui_right"):
			if not $"Player AnimatedSprite/AnimationPlayer".is_playing():
				motion.x = SPEED
			
			$"Player AnimatedSprite".flip_h = false
			
		elif Input.is_action_pressed("ui_left"):
			if not $"Player AnimatedSprite/AnimationPlayer".is_playing():
				motion.x = -SPEED
			
			$"Player AnimatedSprite".flip_h = true
			
		else:
			motion.x = 0
		
		if is_on_floor():
			
			if Input.is_action_just_pressed("ui_up"):
				motion.y = -JUMP_HEIGHT
		
		if not is_on_floor():
			if Input.is_action_just_pressed("ui_down"):
				motion.y = GRAVITY * 20
		
		if Input.is_action_just_pressed("right_click"):
			var grappling_hook = GRAPPLING_HOOK.instance()
			get_parent().add_child(grappling_hook)
			grappling_hook.position = $Position1.global_position
			
		
	# Check States
		if motion.x != 0:
			_state = "state_run"
			
			
		elif motion.y != 0:
			_state = "state_idle"
			
			
		if motion.y < 0 and not is_on_floor():
			_state = "state_jump_up"
			
			
		if motion.y > 0 and not is_on_floor():
			_state = "state_jump_down"
			
		
		if _state == "state_run":
			if attacking == false:
				$"Player AnimatedSprite".play("Run")
			
		if _state == "state_idle":
			if attacking == false:
				$"Player AnimatedSprite".play("Idle")
			
		if _state == "state_jump_up":
			$"Player AnimatedSprite".play("Jump")
			
		if _state == "state_jump_down":
			$"Player AnimatedSprite".play("JumpDown")
			
		if _state == "state_attack":
			$"Player AnimatedSprite".play("Attack")
			
		if Input.is_action_just_pressed("left_click"):
			attack()
		
		print(health)
		
		motion = move_and_slide(motion, UP)
		pass
		
		
func _process(delta):
	
	if health < 0:
		die()
		health = 0	
		
		
	
func grappling_hook():
	
		
		
	pass
	
func attack():
	if is_on_floor() == true:
		attacking = true
	
		$"Player AnimatedSprite/AnimationPlayer".play("Attack")
	
		if $"Player AnimatedSprite/AnimationPlayer".is_playing():
			motion.x = 0
	
		if $"Player AnimatedSprite".flip_h == false:
			self.position += Vector2(8, 0)
		else:
			self.position += Vector2(-8, 0)
		
		yield($"Player AnimatedSprite/AnimationPlayer", "animation_finished")
	
		attacking = false

func die():
	if health <= 0:
		_state = "state_dead"
		$"Player AnimatedSprite/AnimationPlayer".play("Die")
		

func take_damage(amount):
	health -= amount
	pass
		

func _on_Attack_Hitbox_body_entered(body):
	if health > 0:
		take_damage(10)
	pass


func _on_Area2D_body_entered(body):
	if health > 0:
		take_damage(30)
	
	pass 
