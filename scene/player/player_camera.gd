extends Camera2D

signal camera_should_shake(amount: float)

# 震动强度
@export var strength := 0.0
# 震动恢复速度
@export var recovery_speed := 16.0

func _ready():
	camera_should_shake.connect(func (amount: float):
		strength += amount
	)
	var target_width = 600  # 目标视口宽度
	update_camera_zoom(target_width)

func update_camera_zoom(desired_width: float):
	var rect = get_viewport().get_visible_rect()
	var screen_width = rect.size.x
	var zoom_x = screen_width / desired_width
	zoom = Vector2(zoom_x, zoom_x)

func _process(delta: float) -> void:
	offset = Vector2(
		randf_range(-strength, strength),
		randf_range(-strength, strength)
	)
	strength = move_toward(strength, 0, recovery_speed * delta)

func shake_camera(amount: float) -> void:
	camera_should_shake.emit(amount)
