extends CharacterBody2D

@export var knockbackPower: int = 500
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_knockedback = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		is_knockedback = false
	elif not is_knockedback:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func knockback(bulletVelocity: Vector2):
	var knockbackDirection = (bulletVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	is_knockedback = true
	move_and_slide()

func _on_area_2d_area_entered(area):
	knockback(area.get_parent().linear_velocity)


func _on_area_2d_body_entered(body):
	#knockback(body.linear_velocity)
	pass
