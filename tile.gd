extends StaticBody2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func generate_tile(tex):
	get_node("tile_texture").set_texture(tex)
	self.visible = true
	#var grass_tileset = Image.new()
	#grass_tileset.load("res://grass_tileset.png")
	#var grass_1 = Image.new()
	#grass_1.load("res://blank_tile.png")
	#grass_1.load("res://grass_tileset.png")
	#grass_1.blit_rect(grass_tileset, Rect2(1, 1, 26, 26), Vector2(0, 0))
	#var grass_1_tex = ImageTexture.new()
	#grass_1_tex.create_from_image(grass_1, 3)
	#get_node("texture").set_texture(load("res://tiles/grass/tile_0.png"))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
