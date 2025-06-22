extends Camera2D

func _ready():
	var target_width = 600  # 目标视口宽度
	update_camera_zoom(target_width)

func update_camera_zoom(desired_width: float):
	var rect = get_viewport().get_visible_rect()
	var screen_width = rect.size.x
	var zoom_x = screen_width / desired_width
	zoom = Vector2(zoom_x, zoom_x)
