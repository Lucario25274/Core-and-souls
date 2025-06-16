extends CharacterBody2D

var speed = 50
#var last_direction: int = 1  # 1 für rechts, -1 für links
var player_chase = false
var player = null

var health = 100
var player_inattack_range = false

func _physics_process(_delta):

	if not health <= 0:
		if player_chase:
			position += (player.position - position)/speed
			$AnimatedSprite2D.play("walk")

			if(player.position.x - position.x) < 0:
				$AnimatedSprite2D.flip_h = false
			else:
				$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.play("idle")
	else:
		print("tot animation")
		$AnimatedSprite2D.play("death")
		await $AnimatedSprite2D.animation_finished
		print("wirklich tot")
		self.queue_free()

	move_and_slide()
	deal_with_damage()


func _on_detectionarea_body_entered(body):
	player = body
	player_chase = true



func _on_detectionarea_body_exited(_body):
	player = null
	player_chase = false

func enemy():
	pass


func _on_slime_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_range = true


func _on_slime_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_range = false


func deal_with_damage():
	if player_inattack_range and global.player_current_attack == true:
		global.player_current_attack = false
		health = health - 20
		self.position += (player.position + position*4)/speed
		print("slime health = ",health)
