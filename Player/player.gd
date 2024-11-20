extends CharacterBody2D

@export var speed : float =  100.0

func _physics_process(delta: float) -> void:
	movement()

	move_and_slide()


func movement():
	# get the input direction
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
