extends CharacterBody2D

# Movement variables
@export var speed: float = 30.0
var current_direction: Vector2 = Vector2.ZERO

# Timer variables
var action_timer: float = 0.0
@export var min_action_time: float = 1.0
@export var max_action_time: float = 4.0

func _ready():
	# Randomize the seed so the movement is truly random every time you play
	randomize()
	choose_new_action()

func _physics_process(delta):
	# 1. Count down the timer
	action_timer -= delta
	
	# 2. If the timer hits 0, it's time to pick a new action!
	if action_timer <= 0:
		choose_new_action()
		
	# 3. Apply the movement
	velocity = current_direction * speed
	move_and_slide()

func choose_new_action():
	# Pick a random amount of time for this action to last
	action_timer = randf_range(min_action_time, max_action_time)
	
	# Flip a coin (50/50 chance) to decide if the pet moves or idles
	if randi() % 2 == 0:
		# Move: Pick a random direction (x and y between -1 and 1)
		current_direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
	else:
		# Idle: Stand perfectly still
		current_direction = Vector2.ZERO
