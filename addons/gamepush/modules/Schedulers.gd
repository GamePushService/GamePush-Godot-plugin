extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var schedulers:JavaScriptObject

signal after_ready

signal error_register(error_message: String)
signal signal_claim_day(scheduler_day_info: SchedulerDayInfo)
signal error_claim_day(error_message: String)
signal signal_register(scheduler_info: SchedulerInfo)
signal signal_claim_day_additional(scheduler_day_info: SchedulerDayInfo)
signal error_claim_day_additional(error_message: String)
signal signal_claim_all_day(scheduler_day_info: SchedulerDayInfo)
signal error_claim_all_day(error_message: String)
signal signal_claim_all_days(scheduler_info: SchedulerInfo)
signal error_claim_all_days(error_message: String)
signal signal_join(scheduler: Scheduler, player_scheduler: PlayerScheduler)
signal error_join(error_message: String)


var callback_error_register := JavaScriptBridge.create_callback(_on_error_register)
var callback_on_claim_day_additional := JavaScriptBridge.create_callback(_on_claim_day_additional)
var callback_on_claim_day := JavaScriptBridge.create_callback(_on_claim_day)
var callback_on_error_claim_day := JavaScriptBridge.create_callback(_on_error_claim_day)
var callback_on_register := JavaScriptBridge.create_callback(_on_register)
var callback_on_error_claim_day_additional := JavaScriptBridge.create_callback(_on_error_claim_day_additional)
var callback_on_claim_all_day := JavaScriptBridge.create_callback(_on_claim_all_day)
var callback_on_error_claim_all_day := JavaScriptBridge.create_callback(_on_error_claim_all_day)
var callback_on_claim_all_days := JavaScriptBridge.create_callback(_on_claim_all_days)
var callback_on_error_claim_all_days := JavaScriptBridge.create_callback(_on_error_claim_all_days)
var callback_on_join := JavaScriptBridge.create_callback(_on_join)
var callback_on_error_join := JavaScriptBridge.create_callback(_on_error_join)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
		schedulers = gp.schedulers
		schedulers.on("error:register", callback_error_register)
		schedulers.on("claimDay", callback_on_claim_day)
		schedulers.on("error:claimDay", callback_on_error_claim_day)
		schedulers.on("register", callback_on_register)
		schedulers.on("claimDayAdditional", callback_on_claim_day_additional)
		schedulers.on("error:claimDayAdditional", callback_on_error_claim_day_additional)
		schedulers.on("claimAllDay", callback_on_claim_all_day)
		schedulers.on("error:claimAllDay", callback_on_error_claim_all_day)
		schedulers.on("claimAllDays", callback_on_claim_all_days)
		schedulers.on("error:claimAllDays", callback_on_error_claim_all_days)
		schedulers.on("join", callback_on_join)
		schedulers.on("error:join", callback_on_error_join)
	after_ready.emit()
	

signal _register(a:JavaScriptObject)

func register(id_or_tag: Variant) -> SchedulerInfo:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if typeof(id_or_tag) == TYPE_INT or (id_or_tag is String and id_or_tag.is_valid_int()):
			conf["id"] = int(id_or_tag)
		elif typeof(id_or_tag) == TYPE_STRING:
			conf["tag"] = id_or_tag
		var callback := JavaScriptBridge.create_callback(func(args): _register.emit(args[0]))
		gp.schedulers.register(conf).then(callback)
		var _result = await _register
		var result = SchedulerInfo.new()
		result._from_js(_result)
		return result
	push_warning("Not running on Web")
	return SchedulerInfo.new()

signal _claim_day(a:JavaScriptObject)

func claim_day(id_or_tag: Variant, day: int) -> SchedulerDayInfo:
	if OS.get_name() == "Web":
		var callback := JavaScriptBridge.create_callback(func(args): _claim_day.emit(args[0]))
		schedulers.claimDay(id_or_tag, day).then(callback)
		var _result = await _claim_day
		var result = SchedulerDayInfo.new()
		result._from_js(_result)
		return result
	push_warning("Not running on Web")
	return SchedulerDayInfo.new()

signal _claim_day_additional(a:JavaScriptObject)

func claim_day_additional(id_or_tag: Variant, day: int, trigger_id_or_tag: Variant) -> SchedulerDayInfo:
	if OS.get_name() == "Web":
		var callback := JavaScriptBridge.create_callback(func(args): _claim_day_additional.emit(args[0]))
		schedulers.claimDayAdditional(id_or_tag, day, trigger_id_or_tag).then(callback)
		var _result = await _claim_day_additional
		var result = SchedulerDayInfo.new()
		result._from_js(_result)
		return result
	push_warning("Not running on Web")
	return SchedulerDayInfo.new()

signal _claim_all_day(a:JavaScriptObject)

func claim_all_day(id_or_tag: Variant, day: int) -> SchedulerDayInfo:
	if OS.get_name() == "Web":
		var callback := JavaScriptBridge.create_callback(func(args): _claim_all_day.emit(args[0]))
		schedulers.claimAllDay(id_or_tag, day).then(callback)
		var _result = await _claim_all_day
		var result = SchedulerDayInfo.new()
		result._from_js(_result)
		return result
	push_warning("Not running on Web")
	return SchedulerDayInfo.new()


signal _claim_all_days(a:JavaScriptObject)

func claim_all_days(id_or_tag: Variant) -> SchedulerInfo:
	if OS.get_name() == "Web":
		var callback := JavaScriptBridge.create_callback(func(args): _claim_all_days.emit(args[0]))
		schedulers.claimAllDays(id_or_tag).then(callback)
		var _result = await _claim_all_days
		var result = SchedulerInfo.new()
		result._from_js(_result)
		return result
	push_warning("Not running on Web")
	return SchedulerInfo.new()


func list() -> Array:
	var scheduler_list: Array = []
	schedulers.list.forEach(JavaScriptBridge.create_callback(func(s):
		scheduler_list.append(Scheduler.new()._from_js(s[0]))
	))
	return scheduler_list


func active_list() -> Array:
	var player_scheduler_list: Array = []
	schedulers.activeList.forEach(JavaScriptBridge.create_callback(func(ps):
		player_scheduler_list.append(PlayerScheduler.new()._from_js(ps[0]))
	))
	return player_scheduler_list

signal _get_sheduler(a:JavaScriptObject)

func get_scheduler(id_or_tag: Variant) -> SchedulerInfo:
	if OS.get_name() == "Web":
		var scheduler_info:SchedulerInfo = SchedulerInfo.new()
		var result = gp.schedulers.getScheduler(id_or_tag)
		scheduler_info._from_js(result)
		return scheduler_info
		
	push_warning("Not running on Web")
	return SchedulerInfo.new()


signal _get_scheduler_day(a:JavaScriptObject)

func get_scheduler_day(id_or_tag: Variant, day: int) -> SchedulerDayInfo:
	if OS.get_name() == "Web":
		var scheduler_day_info:SchedulerDayInfo = SchedulerDayInfo.new()
		var result = gp.schedulers.getSchedulerDay(id_or_tag, day)
		scheduler_day_info._from_js(result)
		return scheduler_day_info
		
	push_warning("Not running on Web")
	return SchedulerDayInfo.new()

signal _get_scheduler_current_day(a:JavaScriptObject)

func get_scheduler_current_day(id_or_tag: Variant) -> SchedulerDayInfo:
	if OS.get_name() == "Web":
		var scheduler_day_info: SchedulerDayInfo = SchedulerDayInfo.new()
		var result = gp.schedulers.getSchedulerCurrentDay(id_or_tag)
		
		scheduler_day_info._from_js(result)
		return scheduler_day_info

	push_warning("Not running on Web")
	return SchedulerDayInfo.new()
	

func is_registered(id_or_tag: Variant) -> bool:
	if OS.get_name() == "Web":
		var result = gp.schedulers.isRegistered(id_or_tag)
		# Return true if the player is registered
		if result != null:
			return result
		push_warning("Scheduler not found")
		return false
	# If not running on Web
	push_warning("Not running on Web")
	return false

func is_today_reward_claimed(id_or_tag: Variant) -> bool:
	if OS.get_name() == "Web":
		var result = gp.schedulers.isTodayRewardClaimed(id_or_tag)
		if result != null:
			return result
		push_warning("Scheduler not found")
		return false
	push_warning("Not running on Web")
	return false

func can_claim_day(id_or_tag: Variant, day: int) -> bool:
	if OS.get_name() == "Web":
		var result = gp.schedulers.canClaimDay(id_or_tag, day)
		if result != null:
			return result
		push_warning("Scheduler not found")
		return false
	push_warning("Not running on Web")
	return false

func can_claim_day_additional(id_or_tag: Variant, day: int, trigger_id_or_tag: Variant) -> bool:
	if OS.get_name() == "Web":
		var result = gp.schedulers.canClaimDayAdditional(id_or_tag, day, trigger_id_or_tag)
		if result != null:
			return result
		push_warning("Scheduler not found")
		return false
	push_warning("Not running on Web")
	return false

func can_claim_all_day(id_or_tag: Variant, day: int) -> bool:
	if OS.get_name() == "Web":
		var result = gp.schedulers.canClaimAllDay(id_or_tag, day)
		if result != null:
			return result
		push_warning("Scheduler not found")
		return false
	push_warning("Not running on Web")
	return false


func _on_error_register(args) -> void:
	error_register.emit(args[0])
	
func _on_claim_day(args) -> void:
	var scheduler_day_info: SchedulerDayInfo = SchedulerDayInfo.new()
	scheduler_day_info._from_js(args[0])
	signal_claim_day.emit(scheduler_day_info)

func _on_error_claim_day(args) -> void:
	error_claim_day.emit(args[0])

func _on_register(args) -> void:
	var scheduler_info := SchedulerInfo.new()._from_js(args[0])
	signal_register.emit(scheduler_info)

func _on_claim_day_additional(args) -> void:
	var scheduler_day_info := SchedulerDayInfo.new()._from_js(args[0])
	signal_claim_day_additional.emit(scheduler_day_info)

func _on_error_claim_day_additional(args) -> void:
	error_claim_day_additional.emit(args[0])

func _on_claim_all_day(args) -> void:
	var scheduler_day_info := SchedulerDayInfo.new()._from_js(args[0])
	signal_claim_all_day.emit(scheduler_day_info)

func _on_error_claim_all_day(args) -> void:
	error_claim_all_day.emit(args[0])

func _on_claim_all_days(args) -> void:
	var scheduler_info := SchedulerInfo.new()._from_js(args[0])
	signal_claim_all_days.emit(scheduler_info)

func _on_error_claim_all_days(args) -> void:
	error_claim_all_days.emit(args[0])

func _on_join(args) -> void:
	var scheduler := Scheduler.new()._from_js(args[0].scheduler)
	var player_scheduler := PlayerScheduler.new()._from_js(args[0].playerScheduler)
	signal_join.emit(scheduler, player_scheduler)

func _on_error_join(args) -> void:
	error_join.emit(args[0])


class Scheduler:
	extends GP.GPObject
	
	var id: int
	var tag: String
	var type: String
	var days: int
	var is_repeat: bool
	var is_auto_register: bool
	var triggers: Array

	# Method to convert the scheduler to a JavaScript object
	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["tag"] = tag
		js_object["type"] = type
		js_object["days"] = days
		js_object["isRepeat"] = is_repeat
		js_object["isAutoRegister"] = is_auto_register
		
		var js_triggers := JavaScriptBridge.create_object("Array")
		for trigger in triggers:
			js_triggers.push(trigger._to_js())
		js_object["triggers"] = js_triggers

		return js_object

	# Method to initialize the scheduler from a JavaScript object
	func _from_js(js_object: JavaScriptObject) -> Scheduler:
		id = js_object["id"]
		tag = js_object["tag"]
		type = js_object["type"]
		days = js_object["days"]
		is_repeat = js_object["isRepeat"]
		is_auto_register = js_object["isAutoRegister"]
		
		triggers = []
		var callback := JavaScriptBridge.create_callback(func(args): 
			triggers.append(GP.Triggers.Trigger.new()._from_js(args[0])))
		js_object["triggers"].forEach(callback)
		
		return self

class PlayerScheduler:
	extends GP.GPObject
	
	var scheduler_id: int
	var days_claimed: Array[int]
	var stats: PlayerStats

	# Method to convert the PlayerScheduler to a JavaScript object
	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["schedulerId"] = scheduler_id
		var js_days_claimed := JavaScriptBridge.create_object("Array")
		for day in days_claimed:
			js_days_claimed.push(day)
		js_object["daysClaimed"] = js_days_claimed
		js_object["stats"] = stats._to_js()
		return js_object

	# Method to initialize the PlayerScheduler from a JavaScript object
	func _from_js(js_object: JavaScriptObject) -> PlayerScheduler:
		scheduler_id = js_object["schedulerId"]
		days_claimed = []
		var callback := JavaScriptBridge.create_callback(func(args):
			days_claimed.append(args[0]))
		js_object["daysClaimed"].forEach(callback)
		stats = PlayerStats.new()
		stats._from_js(js_object["stats"])
		return self


class PlayerStats:
	extends GP.GPObject
	
	var active_days: int
	var active_days_consecutive: int

	# Method to convert PlayerStats to a JavaScript object
	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["activeDays"] = active_days
		js_object["activeDaysConsecutive"] = active_days_consecutive
		return js_object

	# Method to initialize PlayerStats from a JavaScript object
	func _from_js(js_object: JavaScriptObject) -> PlayerStats:
		active_days = js_object["activeDays"]
		active_days_consecutive = js_object["activeDaysConsecutive"]
		return self

class SchedulerInfo:
	extends GP.GPObject
	
	#var scheduler: Scheduler
	var stats: PlayerStats
	var days_claimed: Array[int]
	var is_registered: bool
	var current_day: int

	# Method to convert SchedulerInformation to a JavaScript object
	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		#js_object["scheduler"] = scheduler._to_js()
		js_object["stats"] = stats._to_js()
		js_object["daysClaimed"] = JavaScriptBridge.create_object("Array")
		for day in days_claimed:
			js_object["daysClaimed"].push(day)
		js_object["isRegistered"] = is_registered
		js_object["currentDay"] = current_day
		return js_object

	# Method to initialize SchedulerInformation from a JavaScript object
	func _from_js(js_object: JavaScriptObject) -> SchedulerInfo:
		#scheduler = Scheduler.new()._from_js(js_object["scheduler"])
		stats = PlayerStats.new()._from_js(js_object["stats"])
		days_claimed = []
		js_object["daysClaimed"].forEach(JavaScriptBridge.create_callback(_parse_days_claimed))
		is_registered = js_object["isRegistered"]
		current_day = js_object["currentDay"]
		return self

	# Helper method to parse days claimed
	func _parse_days_claimed(args):
		days_claimed.append(args[0])

class SchedulerDayInfo:
	extends GP.GPObject
	
	var scheduler: Scheduler
	var day: int
	var is_day_reached: bool
	var is_day_complete: bool
	var is_day_claimed: bool
	var is_all_day_claimed: bool
	var can_claim_day: bool
	var can_claim_all_day: bool
	var bonuses: Array
	var triggers: Array

	# Method to convert SchedulerDayInformation to a JavaScript object
	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["scheduler"] = scheduler._to_js()
		js_object["day"] = day
		js_object["isDayReached"] = is_day_reached
		js_object["isDayComplete"] = is_day_complete
		js_object["isDayClaimed"] = is_day_claimed
		js_object["isAllDayClaimed"] = is_all_day_claimed
		js_object["canClaimDay"] = can_claim_day
		js_object["canClaimAllDay"] = can_claim_all_day
		js_object["bonuses"] = JavaScriptBridge.create_object("Array")
		for bonus in bonuses:
			js_object["bonuses"].push(bonus._to_js())
		js_object["triggers"] = JavaScriptBridge.create_object("Array")
		for trigger in triggers:
			js_object["triggers"].push(trigger._to_js())
		return js_object

	# Method to initialize SchedulerDayInformation from a JavaScript object
	func _from_js(js_object: JavaScriptObject) -> SchedulerDayInfo:
		scheduler = Scheduler.new()._from_js(js_object["scheduler"])
		day = js_object["day"]
		is_day_reached = js_object["isDayReached"]
		is_day_complete = js_object["isDayComplete"]
		is_day_claimed = js_object["isDayClaimed"]
		is_all_day_claimed = js_object["isAllDayClaimed"]
		can_claim_day = js_object["canClaimDay"]
		can_claim_all_day = js_object["canClaimAllDay"]
		bonuses = []
		js_object["bonuses"].forEach(JavaScriptBridge.create_callback(_parse_bonuses))
		triggers = []
		js_object["triggers"].forEach(JavaScriptBridge.create_callback(_parse_triggers))
		return self

	# Helper method to parse bonuses
	func _parse_bonuses(args):
		bonuses.append(GP.Triggers.Bonus.new()._from_js(args[0]))

	# Helper method to parse triggers
	func _parse_triggers(args):
		triggers.append(GP.Triggers.Trigger.new()._from_js(args[0]))
