extends Sprite

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.

var internal_time = 0
var modded_scale
var parent
var dis

func _ready() -> void:
	if self.name == 'overlay':
		self.modulate = Color(1, 1, 1, 0.7)
	if self.name == 'overlay2':
		self.modulate = Color(1, 1, 1, 0.5)
	parent = get_node('/root/world/overlay')
	parent.position = get_node('/root/world/player').position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt):
	internal_time += dt
	modded_scale = (sin(internal_time) + 1) / 20 + 1.2
	if self.name == 'overlay2':
		modded_scale = (sin(internal_time * 0.65) + 1) / 15 + 0.7
	if self.name == 'overlay3':
		modded_scale = (sin(internal_time * 1.22) + 1) / 30 + 1.6
	self.scale = Vector2(modded_scale, modded_scale)

	parent = get_node('/root/world/overlay')
	dis = abs(parent.position.x - get_node('/root/world/player').position.x) + abs(parent.position.y - get_node('/root/world/player').position.y)
	parent.position = Vector2(parent.position.x + (get_node('/root/world/player').position.x - parent.position.x) / 10, parent.position.y + (get_node('/root/world/player').position.y - parent.position.y) / 10)
	#parent.position.x = (get_node('/root/world/player').position.x - parent.position.x)
	#parent.position.y = (get_node('/root/world/player').position.y - parent.position.y)