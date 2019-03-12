extends Node2D

signal gameOver

func _on_HeadArea_area_entered(area):
	
	if area.get_name() == "BodyArea":
		
		emit_signal("gameOver")
		#print("ACABOU")
