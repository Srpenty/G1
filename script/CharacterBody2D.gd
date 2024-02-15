extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -900.0
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.s
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#variables que permiten el doble salto
var jump_max = 2
var jump_count = 0

func _physics_process(delta):
	
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "run"
	else:
		sprite_2d.animation = "idle"
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jump"
		
	#reseteo del salto	
	if is_on_floor()  and jump_count!=0:
		jump_count = 0
	
	if jump_count<jump_max:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			jump_count += 1
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_pressed("ui_down"):
		sprite_2d.animation = "crouch"
		
	if Input.is_action_pressed("attack"):
		sprite_2d.animation = "attack"
		
	if Input.is_action_just_pressed("ui_left"):
		sprite_2d.flip_h = true
		
	if Input.is_action_just_pressed("ui_right"):
		sprite_2d.flip_h = false
		
	move_and_slide()

	
