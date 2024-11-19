extends CharacterBody2D


const SPEED = 1200.0
const JUMP_VELOCITY = -3000.0

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += 7 * get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor():
		if direction > 0:
			animated_sprite.flip_h = false
			animated_sprite.play("run")
		elif direction < 0:
			animated_sprite.flip_h = true
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
		

	move_and_slide()
