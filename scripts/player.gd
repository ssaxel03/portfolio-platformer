extends CharacterBody2D

const Bullet = preload("../scenes/bullet.tscn")
const SPEED = 1200.0
const JUMP_VELOCITY = -3000.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var timer: Timer = $FireRate

var canShoot = true

func _ready() -> void:
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += 7 * get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("shoot") and canShoot:
		_shoot(animated_sprite.flip_h)
	
	# ANIMATIONS
	if is_on_floor():
		if direction != 0:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
	else:
		animated_sprite.play("jumping")
		
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	move_and_slide()
	
func _shoot(flip_h) -> void:
	var bullet = Bullet.instantiate()
	get_tree().root.add_child(bullet)
	bullet.tile_map = get_node("%platforms")
	bullet.global_position = self.global_position
	bullet.direction = -1 if flip_h else 1
	canShoot = false
	timer.start()

func _on_timer_timeout() -> void:
	canShoot = true
