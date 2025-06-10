extends CharacterBody2D

const SPEED = 100

var sprite_direction = "right" : get = _get_sprite_direction
var last_direction: int = 1  # 1 für rechts, -1 für links



@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	velocity.x = Input.get_axis("xbox_left", "xbox_right") * SPEED
	velocity.y = Input.get_axis("xbox_up", "xbox_down") * SPEED
	move_and_slide()


	#set_animation("walk_")
	if velocity.x == 0 and velocity.y == 0:
		set_animation("idle_")
		sprite.play("idle_right")
	else:
		set_animation("walk_")



func set_animation(animation):
#	wenn sprite direction ist up oder dowan dann lass es so
#	ansonten wenn in left oder right ist, ist es side
	var direction  = "right" if sprite_direction in ["left","right"] else sprite_direction
	sprite.play(animation + direction)
	sprite.flip_h = (sprite_direction == "left")


func _get_sprite_direction():
	last_direction = sign(Input.get_axis("xbox_left", "xbox_right"))

	# Sprite nur umdrehen wenn eine Richtung gewählt wurde
	if last_direction < 0:
		sprite_direction = "left"
	elif last_direction > 0:
		sprite_direction = "right"

	return sprite_direction
