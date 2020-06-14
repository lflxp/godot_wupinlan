extends Control

var nowChildrenItem = null

func _ready():
	# $Panel.visible = false
	for item in $Panel2/user.get_children():
		item.connect("gui_input",self,"_on_gui_input",[item])
	for item in $Panel/items.get_children():
		item.connect("gui_input",self,"_on_gui_input",[item])
	pass
	
func _input(event):	
	if nowChildrenItem != null:
		nowChildrenItem.position = get_local_mouse_position()
	pass

func _on_gui_input(event,itembox):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var child = itembox.get_children()
		if child.size() == 1:
			# child[0].position = get_local_mouse_position()
			# 移动物品
			if nowChildrenItem == null:
				nowChildrenItem = child[0].duplicate()
				nowChildrenItem.position = get_local_mouse_position()
				get_tree().get_root().add_child(nowChildrenItem)
				child[0].queue_free()
			# 交换物品
			else:
				var nowItem = nowChildrenItem.duplicate()
				nowItem.position = Vector2(30,30)
				itembox.add_child(nowItem)
				nowChildrenItem.queue_free()
				
				nowChildrenItem = child[0].duplicate()
				nowChildrenItem.position = get_local_mouse_position()
				get_tree().get_root().add_child(nowChildrenItem)
				child[0].queue_free()
			
			# nowChildrenItem = child[0].duplicate()
			# nowChildrenItem.position = get_local_mouse_position()
			# get_tree().get_root().add_child(nowChildrenItem)
			# child[0].queue_free()
		else:
			var item = nowChildrenItem.duplicate()
			item.position = Vector2(30,30)
			itembox.add_child(item)
			nowChildrenItem.queue_free()
			nowChildrenItem = null
	pass

func _on_Button_pressed():
	for i in range(1,6):
		var sprite = Sprite.new()
		if i == 1:
			sprite.texture = load("res://icon.png")
			sprite.scale = Vector2(1,1)
		else:
			sprite.texture = load("res://icon2.png")
			sprite.scale = Vector2(0.9,0.9)
		sprite.position = Vector2(30,30)
		
		get_node("Panel2/user/item" + str(i)).add_child(sprite)
	pass # Replace with function body.


func _on_Button2_pressed():
	if $Panel.visible == true:
		$Panel.visible = false
	else:
		$Panel.visible = true
	pass # Replace with function body.
