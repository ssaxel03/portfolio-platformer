extends Node2D

@onready var timer: Timer = $DeSpawn
@onready var cast_right: RayCast2D = $cast_right
@onready var cast_left: RayCast2D = $cast_left


const SPEED = 80
const POINT_RANGE = 90
const PARALLAX = preload("res://scenes/parallax.tscn") # TODO

@export var direction: int = 0
@export var tile_map: TileMapLayer = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	var map_position
	
	var point
	
	if direction == 1:
		point = Vector2(self.global_position.x + POINT_RANGE, self.global_position.y)
	else:
		point = Vector2(self.global_position.x - POINT_RANGE, self.global_position.y)
		
	map_position = tile_map.local_to_map(point)
	
	if tile_map.get_cell_source_id(map_position) != -1:
		queue_free()
	else:
		self.move_local_x(SPEED * direction)

func _on_timer_timeout() -> void:
	queue_free()
