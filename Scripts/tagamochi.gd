extends CharacterBody2D

# --- Movement Variables ---
@export var speed: float = 90.0
var current_direction: Vector2 = Vector2.ZERO

# --- Timer & State Variables ---
var action_timer: float = 0.0
var current_animation: String = "idle" # NEW: Tracks what animation should play

# --- Node References ---
@onready var anim_sprite = $AnimatedSprite2D

func _ready():
	randomize()
	choose_new_action()

func _physics_process(delta):
	# 1. Count down the timer
	action_timer -= delta
	
	# 2. Pick a new action when the timer runs out
	if action_timer <= 0:
		choose_new_action()
		
	# 3. Apply the movements
	velocity = current_direction * speed
	move_and_slide()
	
	# 4. Play the currently selected animation
	anim_sprite.play(current_animation)
	
	# 5. Flip the sprite based on X direction
	if current_direction.x > 0:
		anim_sprite.flip_h = false
	elif current_direction.x < 0:
		anim_sprite.flip_h = true

func choose_new_action():
	var roll = randi_range(1, 100)
	
	if roll <= 20:
		# --- 20% CHANCE: WALK ---
		current_direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
		current_animation = "walk"
		action_timer = randf_range(1.0, 4.0)
		
	elif roll <= 60:
		# --- 40% CHANCE: NORMAL IDLE ---
		# (This catches numbers 41 through 70)
		current_direction = Vector2.ZERO
		current_animation = "idle"
		action_timer = randf_range(3.0, 5.0)
		
	elif roll <= 75:
		# --- 7% CHANCE: LICK ---
		# (This catches numbers 71 through 80)
		current_direction = Vector2.ZERO
		current_animation = "lick"
		action_timer = 2.5
		
	elif roll <= 90:
		# --- 7% 5CHANCE: STRETCH ---
		# (This catches numbers 81 through 90)
		current_direction = Vector2.ZERO
		current_animation = "stretch"
		action_timer = 1.5
		
	else:
		# --- 5% CHANCE: SLEEP ---
		# (This catches everything else left over: 91 through 100)
		current_direction = Vector2.ZERO
		current_animation = "sleep"
		action_timer = randf_range(7.0, 10.0)
