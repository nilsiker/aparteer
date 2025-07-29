class_name Serialize

static func ser(data: Variant) -> Dictionary:
	var result = {}
	var stack = [{
		"object": data,
		"target_dict": result,
		"key": null
	}]
	
	while stack.size() > 0:
		var current = stack.pop_back()
		var obj = current.object
		var target = current.target_dict
		var key = current.key
		
		# Handle arrays
		if obj is Array:
			var array_result = []
			if key != null:
				target[key] = array_result
			else:
				result = array_result
			
			for i in range(obj.size()):
				var item = obj[i]
				if item != null and item.has_method("serialize"):
					array_result.append(item.serialize())
				elif item != null and item.has_method("get_property_list"):
					var item_dict = {}
					array_result.append(item_dict)
					stack.append({
						"object": item,
						"target_dict": item_dict,
						"key": null
					})
				else:
					array_result.append(item)
		
		# Handle objects with properties
		elif obj and obj.has_method("get_property_list"):
			var obj_dict = {}
			if key:
				target[key] = obj_dict
			else:
				obj_dict = target
			
			var properties = obj.get_property_list()
			for prop in properties:
				var prop_name = prop.name
				var prop_value = obj.get(prop_name)
				
				# Skip built-in properties and script reference
				if prop_name.begins_with("_") or prop_name == "script":
					continue
				if prop_name.ends_with(".gd") or prop_name == "RefCounted": 
					continue
				# Handle arrays and objects that need further processing
				if prop_value is Object and (prop_value is Array or prop_value.has_method("get_property_list")):
					stack.append({
						"object": prop_value,
						"target_dict": obj_dict,
						"key": prop_name
					})
				# Handle primitive values
				else:
					obj_dict[prop_name] = prop_value
	
	return result
