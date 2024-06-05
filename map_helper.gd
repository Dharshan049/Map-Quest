extends Sprite

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var target_y = -150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.y = target_y
	
func _input(event):
	if get_node('/root/world/camera/opening_text').progress > 1:
		var just_pressed = event.is_pressed() and not event.is_echo()
		if Input.is_key_pressed(KEY_E) and just_pressed:
			if get_node('/root/world/terrain_loader').next_level == 100:
				if target_y == -150:
					target_y = -60
				else:
					target_y = -150

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt) -> void:
	if get_node('/root/world/terrain_loader').next_level != 100:
		target_y = -150
	self.position.y += (target_y - self.position.y) / 20
