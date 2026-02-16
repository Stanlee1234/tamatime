extends AnimatedSprite2D

var speed=400
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var rand = randi_range(-1, 1)
	position.x += speed * delta * rand
	
