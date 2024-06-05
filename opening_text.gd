extends Sprite

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var alpha = 0
var direction = 1
var progress = 0
var next_texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.modulate = Color(1, 1, 1, alpha)
	set_texture(load('res://text/intro_0.png'))

func _input(event):
	if event is InputEventMouseButton:
		if progress != 2:
			if alpha == 1:
				next_step()

func next_step():
	get_node('/root/world/camera/opening_help').timer = 0
	progress += 1
	if progress == 1:
		next_texture = load('res://text/intro_1.png')
	if progress == 2:
		next_texture = 0
	if progress == 3:
		if get_node('/root/world').score == 3:
			next_texture = load('res://text/ending_1.png')
		else:
			next_texture = load('res://text/ending_0.png')
	direction = -1
	if progress == 3:
		direction = 1
		set_texture(next_texture)
		get_node('/root/world/camera/fade').direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt):
	if direction == 1:
		alpha = min(1, alpha + dt)
	if direction == -1:
		alpha = max(0, alpha - dt)
	if alpha == 0:
		if direction == -1:
			if progress == 1:
				direction = 1
			if next_texture:
				set_texture(next_texture)
			if progress == 2:
				get_node('/root/world/camera/fade').direction = -1
			if progress == 4:
				get_tree().quit()

	self.modulate = Color(1, 1, 1, alpha)
