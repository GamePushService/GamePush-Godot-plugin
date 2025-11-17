extends Control

@onready var id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id"
@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"


func _ready():
	GP.payments.fetched_products.connect(func(res):
		var id := []
		for p in res[0]:
			id.append(p.to_dict())
		GP.logger.info(id)
		id = []
		for p in res[1]:
			id.append(p.to_dict())
		GP.logger.info(id)
		GP.logger.info("fetched_products")
		)
	GP.payments.purchased.connect(func(res): GP.logger.info("purchased", res[0].to_dict(), res[1].to_dict()))
	GP.payments.consumed.connect(func(res): GP.logger.info("consumed", res[0].to_dict(), res[1].to_dict()))
	GP.payments.error_purchase.connect(func(res): GP.logger.info("error_purchase", res))
	GP.payments.error_consume.connect(func(res): GP.logger.info("error_purchase", res))
	GP.payments.error_fetch_products.connect(func(res): GP.logger.info("error_purchase", res))
	GP.payments.subscribed.connect(func(res): GP.logger.info("subscribed", res[0].to_dict(), res[1].to_dict()))
	GP.payments.unsubscribed.connect(func(res): GP.logger.info("unsubscribed", res[0].to_dict(), res[1].to_dict()))
	GP.payments.error_subscribe.connect(func(res): GP.logger.info("error_subscribe", res))
	GP.payments.error_unsubscribe.connect(func(res): GP.logger.info("error_unsubscribe", res))

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_is_available_pressed():
	GP.logger.info(GP.payments.is_available())


func _on_consume_pressed():
	GP.payments.consume(id_node.text, tag_node.text)


func _on_purchase_pressed():
	GP.payments.purchase(id_node.text, tag_node.text)


func _on_fetch_products_pressed():
	GP.payments.fetch_products()


func _on_is_subscriptions_available_pressed():
	GP.logger.info(GP.payments.is_subscriptions_available())


func _on_subscribe_pressed():
	GP.payments.subscribe(id_node.text, tag_node.text)


func _on_unsubscribe_pressed():
	GP.payments.unsubscribe(id_node.text, tag_node.text)


func _on_get_products_pressed():
	var result := []
	for p in GP.payments.get_products():
		result.append(p.to_dict())
	GP.logger.info(result)


func _on_get_purchases_pressed():
	var result := []
	for p in GP.payments.get_purchases():
		result.append(p.to_dict())
	GP.logger.info(result)
