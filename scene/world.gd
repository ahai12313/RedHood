class_name World
extends Node2D

signal camera_should_shake(amount: float)

func shake_camera(amount: float) -> void:
	camera_should_shake.emit(amount)

func _ready() -> void:
	get_window().always_on_top = true
	Engine.time_scale = 1
