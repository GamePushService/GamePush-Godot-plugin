extends Control


func _ready():
	if GP.is_inited:
		go_to_main()
		return
	GP.inited.connect(go_to_main)


func go_to_main():
	# Put here your scene file
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")
