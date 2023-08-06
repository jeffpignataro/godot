extends RigidBody2D

signal hit

@export var speed = 350 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
#	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector
	if Input.is_action_pressed("player-move-up"):
		velocity.y -= 1
		$AnimatedSprite2D.play("jump-up")
#	Down = Duck
#	if Input.is_action_pressed("player-move-down"):
#		velocity.y += 1
#		$AnimatedSprite2D.play("walk-down")
	if Input.is_action_pressed("player-move-left"):
		velocity.x -= 1
		$AnimatedSprite2D.play("walk-left")
	if Input.is_action_pressed("player-move-right"):
		velocity.x += 1
		$AnimatedSprite2D.play("walk-right")
	if Input.is_action_pressed("player-move-left") && Input.is_action_pressed("player-move-up"):
		velocity.x -= 1
		velocity.y -= 1
		$AnimatedSprite2D.play("jump-left")
	if Input.is_action_pressed("player-move-right") && Input.is_action_pressed("player-move-up"):
		velocity.x += 1
		velocity.y -= 1
		$AnimatedSprite2D.play("jump-right")
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite2D.stop()
		
	global_position += (velocity * delta)
	global_position = global_position.clamp(Vector2.ZERO, screen_size)
	
func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
