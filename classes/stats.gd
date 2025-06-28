class_name Stats
extends Node

@export var max_health := 3

@onready var health: int = max_health:
	set(v):
		v = clampi(v, 0, max_health)
		if health == v:
			return
		else:
			health = v

func _ready() -> void:
	pass
