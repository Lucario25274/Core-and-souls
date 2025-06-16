extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive =true
var attack_ip = false #ip= in progress



const SPEED = 100

var sprite_direction = "right" : get = _get_sprite_direction
var last_direction: int = 1  # 1 für rechts, -1 für links



@onready var sprite = $AnimatedSprite2D


func _physics_process(_delta):
	enemy_attack()
	#attack()
	if health <= 0:
		player_alive = false  #play end_screen
		health = 0
		print("player dead")
		self.queue_free()


	velocity.x = Input.get_axis("xbox_left", "xbox_right") * SPEED
	velocity.y = Input.get_axis("xbox_up", "xbox_down") * SPEED
	move_and_slide()

	if velocity.x == 0 and velocity.y == 0:
		if not attack_ip:  # Prüfe, ob attack_ip == false
			set_animation("idle_")
			sprite.play("idle_right")
		else:
			 #Optional: Animation oder Logik für Angriff, falls attack_ip == true
			pass
	else:
		set_animation("walk_")
	attack()



func set_animation(animation):
#	wenn sprite direction ist up oder down dann lass es so
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

func player():
	pass


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true :
		health = health - 10
		enemy_attack_cooldown = false
		$attack_colldown.start()
		print(health)


func _on_attack_colldown_timeout():
	enemy_attack_cooldown = true


func attack():
	if Input.is_action_just_pressed("xbox_attack") and attack_ip == false:
		attack_ip = true
		global.player_current_attack = true
		sprite.play("attack_right")
		$deal_attack_timer.start()

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
