extends Node2D

@onready var timer: Timer = $DeSpawn


const SPEED = 100
const PARALLAX = preload("res://scenes/parallax.tscn") # TODO

@export var direction: int = 0
@export var tile_map: TileMapLayer = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	var map_position = tile_map.local_to_map(self.global_position)
	
	if tile_map.get_cell_source_id(map_position) != -1:
		queue_free()
		return
	
	self.move_local_x(SPEED * direction)

func _on_timer_timeout() -> void:
	queue_free()
