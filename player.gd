extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.x = 300
	get_node('animated_player').playing = true

var motion = Vector2()
var movement_direction = 0
var movement_speed = 90
var gravity_accel = 400
var terminal_velocity = 320
var jump_force = 250
var result_movement
var jumps = 1
var jumps_max = 1

var particle_scene = preload('res://particle.tscn')
var new_particle

func teleport(pos):
	self.position = pos
	get_node('/root/world/camera').cam_position = self.position
	get_node('/root/world/overlay').position = self.position

func _physics_process(dt):
	movement_direction = 0

	# horizontal movement
	if get_node('/root/world/camera/opening_text').progress > 1:
		if (Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D)):
			movement_direction += 1
		if (Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A)):
			movement_direction -= 1
	
		if (Input.is_action_just_pressed("ui_up") or Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_SPACE)):
			if jumps > 0:
				get_node('/root/world/jump').play()
				motion.y = -jump_force
				jumps -= 1
				for i in range(2):
					new_particle = particle_scene.instance()
					new_particle.set_position(Vector2(self.position.x - 4 + i * 2, self.position.y + 8 - i * 3))
					new_particle.motion = Vector2(-18 + i * 3, 8 - i * 2)
					get_node('/root/world').add_child(new_particle)
					new_particle = particle_scene.instance()
					new_particle.set_position(Vector2(self.position.x + 5 - i * 2, self.position.y + 8 - i * 3))
					new_particle.motion = Vector2(18 - i * 3, 8 - i * 2)
					get_node('/root/world').add_child(new_particle)

	# gravity
	motion.y = min(terminal_velocity, motion.y + dt * gravity_accel)

	motion.x = movement_direction * movement_speed
	
	if motion.x > 0:
		get_node('animated_player').flip_h = false
	if motion.x < 0:
		get_node('animated_player').flip_h = true

	result_movement = move_and_slide(motion)

	if result_movement.y > motion.y:
		motion.y = max(0, motion.y)

	if result_movement.y < motion.y:
		if motion.x == 0:
			get_node('animated_player').animation = 'default'
		else:
			get_node('animated_player').animation = 'run'
		motion.y = min(0, motion.y)
		jumps = jumps_max
	else:
		get_node('animated_player').animation = 'jump'

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
