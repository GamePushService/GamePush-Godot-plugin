extends Control

func _ready() -> void:
	GP.Windows.confirm_closed.connect(func(is_confirmed):
		GP.Logger.info("From signal is_confirmed:", is_confirmed)
		)

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_show_confirm_pressed() -> void:
	var is_confirmed := await GP.Windows.show_confirm(
			$"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/GridContainer/Header#title".text,
			$"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/GridContainer/Header#descriptions".text,
			$"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/GridContainer/Header#text_confirm".text,
			$"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/GridContainer/Header#text_cancel".text,
			$"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/GridContainer/Header#invert_button_colors".button_pressed,
			$"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/GridContainer/Header#hide_cancel_button".button_pressed
			)
	GP.Logger.info("From await is_confirmed:", is_confirmed )
	
