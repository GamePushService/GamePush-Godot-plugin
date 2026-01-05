extends Node
## A unified mechanism for managing the sound state in a game.
## No need to resolve sound state conflicts in the game. One point of control.
## The state is preserved even on reload.
## Monitor stopping and resuming sounds and music in the game.
## @tutorial: https://docs.gamepush.com/docs/sounds/

## all sounds turned off
signal muted
## sound effects turned off
signal muted_sfx
## music turned off 
signal muted_music
## all sounds turned on
signal unmuted
## sound effects turned on
signal unmuted_sfx
## music turned on
signal unmuted_music

var _callback_mute := JavaScriptBridge.create_callback(func(args):
		muted.emit())
var _callback_mute_sfx := JavaScriptBridge.create_callback(func(args):
		muted_sfx.emit())
var _callback_mute_music := JavaScriptBridge.create_callback(func(args):
		muted_music.emit())
var _callback_unmute := JavaScriptBridge.create_callback(func(args):
		unmuted.emit())
var _callback_unmute_sfx := JavaScriptBridge.create_callback(func(args):
		unmuted_sfx.emit())
var _callback_unmute_music := JavaScriptBridge.create_callback(func(args):
		unmuted_music.emit())

var _gp:JavaScriptObject


func _ready():
	if OS.get_name() == "Web":
		_gp = GP.gp
		while not _gp:
			_gp = GP.gp
			await get_tree().create_timer(0.01).timeout
		_gp.sounds.on("mute", _callback_mute)
		_gp.sounds.on("mute:sfx", _callback_mute_sfx)
		_gp.sounds.on("mute:music", _callback_mute_music)
		_gp.sounds.on("unmute", _callback_unmute)
		_gp.sounds.on("unmute:sfx", _callback_unmute_sfx)
		_gp.sounds.on("unmute:music", _callback_unmute_music)
	else:
		push_warning("Not Web")
		
## All sounds are muted
func is_muted() -> bool:
	if OS.get_name() == "Web":
		return _gp.sounds.isMuted
	push_warning("Not Web")
	return false

## Sound effects are muted
func is_sfx_muted() -> bool:
	if OS.get_name() == "Web":
		return _gp.sounds.isSFXMuted
	push_warning("Not Web")
	return false

## Music is muted
func is_music_muted() -> bool:
	if OS.get_name() == "Web":
		return _gp.sounds.isMusicMuted
	push_warning("Not Web")
	return false

## Mute all sounds
func mute() -> void:
	if OS.get_name() == "Web":
		_gp.sounds.mute()
		return
	push_warning("Not Web")

## Unmute all sounds
func unmute() -> void:
	if OS.get_name() == "Web":
		_gp.sounds.unmute()
		return
	push_warning("Not Web")
		
## Mute sound effects
func mute_sfx() -> void:
	if OS.get_name() == "Web":
		_gp.sounds.muteSFX()
		return
	push_warning("Not Web")

## Unmute sound effects
func unmute_sfx() -> void:
	if OS.get_name() == "Web":
		_gp.sounds.unmuteSFX()
		return
	push_warning("Not Web")

## Mute music
func mute_music() -> void:
	if OS.get_name() == "Web":
		_gp.sounds.muteMusic()
		return
	push_warning("Not Web")

## Unmute music
func unmute_music() -> void:
	if OS.get_name() == "Web":
		_gp.sounds.unmuteMusic()
		return
	push_warning("Not Web") 
