extends Node2D

func _process(delta):
	change_scene()


func _on_sideworld_exitpoint_body_entered(body):
	if body.has_method("player"):
			global.transition_scene = true


func _on_sideworld_exitpoint_body_exited(body):
	if body.has_method("player"):
			global.transition_scene = false

#func change_scene():
		#if global.transition_scene == true:
			#if global.current_scene == "sideworld":
				#get_tree().change_scene_to_file("res://scenes/world.tscn")
				#global.first_game_loading == false
			#global.finish_changescenes()
func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "sideworld":
			$player.position.x = global.player_exit_sideworld_posx
			$player.position.y = global.player_exit_sideworld_posy  # Korrigierter Zugriff auf y
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			global.first_game_loading = false  # Korrigierter Vergleichsoperator
			print("player kommt")
		global.finish_changescenes()
