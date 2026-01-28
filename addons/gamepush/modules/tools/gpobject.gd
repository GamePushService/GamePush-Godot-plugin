class_name GPObject extends RefCounted
	
func to_dict() -> Dictionary:
	var result = {}
	for property_info in get_property_list():
		var property_name = property_info.name
		result[property_name] = self.get(property_name)
	return result
