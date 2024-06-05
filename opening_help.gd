extends Sprite

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.y = 60

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt) -> void:
	if get_node('/root/world/camera/opening_text').progress > 1:
		self.visible = false
	elif (fmod(timer, 1) < 0.8) and (timer > 4):
		self.visible = true
	else:
		self.visible = false
	timer += dt
