extends Sprite

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var direction = 1
var alpha = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt) -> void:
	if alpha > 0:
		if direction == -1:
			alpha = max(0, alpha - dt)
	if alpha < 1:
		if direction == 1:
			alpha = min(1, alpha + dt)
	self.modulate = Color(0, 0, 0, max(0, min(1, alpha)))
