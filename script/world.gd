extends Node2D


func _ready():
	if global.first_game_loading == true:
		$player.position.x = global.player_start_posx
		$player.position.y = global.player_start_posy
	else:
		$player.position.x = global.player_exit_sideworld_posx
		$player.position.y = global.player_exit_sideworld_posy

func _process(delta):
		change_scene()

func _on_sideworld_transitionpoint_body_entered(body):
		if body.has_method("player"):
			global.transition_scene = true

func _on_sideworld_transitionpoint_body_exited(body):
		if body.has_method("player"):
			global.transition_scene = false

func change_scene():
		if global.transition_scene == true:
			if global.current_scene == "world":
				get_tree().change_scene_to_file("res://scenes/sideworld.tscn")
				global.first_game_loading = false
				print("player geht")
			global.finish_changescenes()
