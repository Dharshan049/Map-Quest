extends Sprite

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var map_id
var level
var target_y = 300
var mouse_pos
var winning_pattern = ['0', '2', '1']

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_load()

func on_load():
	map_id = self.name.split('_')[-1]
	level = get_node('/root/world/terrain_loader').level
	set_texture(load('res://map_images/map_' + str(level) + '_' + str(map_id) + '.png'))
	self.position.x = 320 / 3 * int(map_id) + 320 / 6 - 320 / 2
	self.position.y = 300

func _input(event):
	if get_node('/root/world/camera/opening_text').progress > 1:
		var just_pressed = event.is_pressed() and not event.is_echo()
		if Input.is_key_pressed(KEY_E) and just_pressed:
			if get_node('/root/world/terrain_loader').next_level == 100:
				if map_id == '0':
					get_node('/root/world/maps_sound').play()
				if target_y == 300:
					target_y = 0
				else:
					target_y = 300
		if event is InputEventMouseButton:
			if target_y == -10:
				if winning_pattern[int(level) - 1] == map_id:
					get_node('/root/world').score += 1
				get_node('/root/world/terrain_loader').next_level = 2
				if map_id == '0':
					get_node('/root/world/maps_sound').play()

func _process(dt) -> void:
	if get_node('/root/world/terrain_loader').level != level:
		on_load()
	if get_node('/root/world/terrain_loader').next_level < 100:
		target_y = 300
	self.position.y += (target_y - self.position.y) / 10
	mouse_pos = get_viewport().get_mouse_position()
	if target_y != 300:
		if mouse_pos.x < 320 / 3:
			if map_id == '0':
				target_y = -10
			else:
				target_y = 0
		elif mouse_pos.x < 320 / 3 * 2:
			if map_id == '1':
				target_y = -10
			else:
				target_y = 0
		else:
			if map_id == '2':
				target_y = -10
			else:
				target_y = 0
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
