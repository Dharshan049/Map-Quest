extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.

var time_remaining = 3.0 / 10
var motion = Vector2(0, 0)

func _ready() -> void:
	get_node('particle_anim').playing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt) -> void:
	time_remaining -= dt
	self.position.x += motion.x * dt
	self.position.y += motion.y * dt
	if time_remaining < 0:
		queue_free()
