extends KinematicBody2D

# huj

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const UP = Vector2(0,-1)
const GRAVITY = 15
const MAXFALLSPEED = 200
const MAXSPEED = 70
const JUMPFORCE = 300
const ACCELERATION = 10
var animation_is_active = false
var facing_right = true

var motion = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func activate_animation(state): 
	animation_is_active = state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
		# $Sprite.scale.x = -1
	
	motion.x = clamp(motion.x,-MAXSPEED,MAXSPEED)
	
	if motion.x == 0 and is_on_floor():
		$AnimationPlayer.play("Idle")
	elif motion.x != 0 and is_on_floor():
		$AnimationPlayer.play("Run")
		
	if Input.is_action_pressed("left") and Input.is_action_pressed("right"):
		motion.x = 0
#		if is_on_floor():
#			$AnimationPlayer.play("Idle")
			
	elif Input.is_action_pressed("left"):
		motion.x -= ACCELERATION
		facing_right = false
		$Sprite.scale.x = -1
	elif Input.is_action_pressed("right"):
		motion.x += ACCELERATION
		facing_right = true
		$Sprite.scale.x = 1
		
	else:
		#if Input.is_action_pressed("attack"):
		#	motion.x = lerp(motion.x,0,0.2)
		#	$AnimationPlayer.play("attack")
		#	$Gun.play()
			
		if ($AnimationPlayer.current_animation != "Fall") or ($AnimationPlayer.current_animation != "Jump") or (!Input.is_action_pressed("left")) or (!Input.is_action_pressed("right")) or (!Input.is_action_pressed("attack")) or (!Input.is_action_pressed("jump")):
			#motion.x = lerp(motion.x,0,0.2)
			motion.x = 0
#			if is_on_floor():
#				$AnimationPlayer.play("Idle")

		

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			$Jump.play()
			motion.y = -JUMPFORCE
	
	if !is_on_floor():
		if motion.y < 0:
			$AnimationPlayer.play("Jump")
		elif motion.y > 0:
			$AnimationPlayer.play("Fall")

	motion = move_and_slide(motion,UP)
	
func _on_KillZone_body_entered(body):
		$Fall.play()
		yield(Fade.fade_out(0.8), "finished")
		#yield(get_tree().create_timer(0.8), "timeout")
		get_tree().change_scene("res://GameOver.tscn")
		Fade.fade_in(0.8)
