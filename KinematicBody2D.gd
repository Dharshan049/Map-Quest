extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.

var motion = Vector2()
var movement_direction = 0
var movement_speed = 250
var gravity_accel = 300
var terminal_velocity = 400
var result_movement

func _physics_process(dt):
	movement_direction = 0
	
	# horizontal movement
	if Input.is_action_pressed("ui_right"):
		movement_direction += 1
	if Input.is_action_pressed("ui_left"):
		movement_direction -= 1
		
	# gravity
	motion.y = min(terminal_velocity, motion.y + dt * gravity_accel)
	
	motion.x = movement_direction * movement_speed
	
	result_movement = move_and_slide(motion)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
