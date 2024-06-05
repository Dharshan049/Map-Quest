extends Node

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.

var tile_scene = preload('res://tile.tscn')
var tile_images
var level = 1
var next_level = 100

func list_files_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin()

    while true:
        var file = dir.get_next()
        if file == "":
            break
        elif not file.begins_with("."):
            files.append(file)

    dir.list_dir_end()

    return files

func read_f(path):
	var file = File.new()
	file.open("res://" + path, File.READ)
	var content = file.get_as_text()
	file.close()
	return JSON.parse(content).result

func load_tilesets():
	var file_list = list_files_in_directory('res://tiles')
	var images = {}
	print(file_list)
	for file in file_list:
		var tile_list = list_files_in_directory('res://tiles/' + file)
		print(tile_list)
		for tile in tile_list:
			if tile.split('.')[-1] == 'import':
				tile = tile.substr(0, len(tile) - 7)
			var new_image = load('res://tiles/' + file + '/' + tile)
			images[(file + '/' + tile).split('.')[0]] = new_image
	print(images)
	return images
	
func load_map(path):
	var map_data = read_f(path)
	var z_index
	var y_offset = 48
	if path.split('_')[-1].split('.')[0] == '2':
		y_offset = 208
	for chunk in map_data['map']:
		for layer in map_data['map'][chunk]:
			z_index = layer['id']
			if 'grid_tiles' in layer:
				for tile in layer['grid_tiles']:
					tile = layer['grid_tiles'][tile]
					spawn_tile(Vector2(tile['render_pos'][0] + 8, tile['render_pos'][1] + 8 + y_offset), tile['type_dat'][0].split('_')[0] + '/tile_' + str(tile['type_dat'][1]), 'tile1', z_index)
	
func spawn_tile(location, tex, name, z_index):
	var new_tile = tile_scene.instance()
	if tex.split('/')[0] != 'spawn':
		new_tile.name = name
		new_tile.get_node("tile").generate_tile(tile_images[tex])
		new_tile.set_position(location)
		new_tile.set_z_index(z_index)
		if z_index == -16:
			new_tile.get_node("tile/CollisionShape2D").disabled = true
		if tex.split('/')[0] == 'decor':
			new_tile.position.y += 8
		get_node("terrain_data").add_child(new_tile)
	else:
		get_node('/root/world/player').teleport(location)

func _ready():
	tile_images = load_tilesets()
	
	load_map('game_maps/map_' + str(level) + '.json')
	#print(read_f("game_maps/map_1.json"))
	#for i in range(20):
	#	spawn_tile(Vector2(i * 16 + 8, 150 + 8), 'grass/tile_1', 'tile1', 1)
	#	spawn_tile(Vector2(i * 16 + 8, 166 + 8), 'grass/tile_5', 'tile1', 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt) -> void:
	if next_level < 100:
		next_level -= dt
	if next_level < 0:
		next_level = 100
		level += 1
		if level != 4:
			for i in range(0, get_node('terrain_data').get_child_count()):
				get_node('terrain_data').get_child(i).queue_free()
			load_map('game_maps/map_' + str(level) + '.json')
			get_node('/root/world/camera/fade').direction = -1
		else:
			get_node('/root/world/camera/opening_text').next_step()
	if next_level < 1:
		if get_node('/root/world/camera/fade').direction == -1:
			get_node('/root/world/camera/fade').direction = 1
