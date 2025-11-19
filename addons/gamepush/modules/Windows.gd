extends Node

signal confirm_closed(is_confirmed:bool)
var _gp:JavaScriptObject


func _ready():
	if OS.get_name() == "Web":
		_gp = GP.gp
		while not _gp:
			_gp = GP.gp
	else:
		push_warning("Not Web")


var _callback_confirm := JavaScriptBridge.create_callback(func(args):
		confirm_closed.emit(args[0])
		)

## Open an overlay with confirmation of an action.
## Translated into all available languages.
func show_confirm(title:='', description:='', text_confirm:='', text_cancel:='',
		invert_button_colors:=false, hide_cancel_button:=false) -> bool:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if title:
			conf["title"] = title
		if description:
			conf["description"] = description
		if text_confirm:
			conf["textConfirm"] = text_confirm
		if text_cancel:
			conf["textCancel"] = text_cancel
		if invert_button_colors:
			conf["invertButtonColors"] = invert_button_colors
		if hide_cancel_button:
			conf["hideCancelButton"] = hide_cancel_button
		_gp.windows.showConfirm(conf).then(_callback_confirm)
		return await confirm_closed
	push_warning("Not Web")
	return false
