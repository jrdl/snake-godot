extends Node2D

signal food_eat


func _on_FoodArea_area_shape_entered(area_id, area, area_shape, self_shape):
	
	if area.get_name() == "HeadArea":
		emit_signal("food_eat")
		#print("colidiu")
		queue_free()
	
