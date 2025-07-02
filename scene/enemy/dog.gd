class_name Dog
extends Enemy

enum DogState {
	POUNCE,
	RUN,
	WALK,
	IDLE,
}

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const WALK_SPEED = 200
const RUN_SPEED = 380
const POUNCE_SPEED = 600

var cur_state: DogState = DogState.WALK
var direction: Direction = Direction.RIGHT
@onready var player: Area2D = get_tree().get_first_node_in_group("player")

# 这个信号可以不要
signal touch_player

func _ready() -> void:
	touch_player.connect(_handle_idle_state.bind(0.0))
	
	
func _physics_process(delta: float) -> void:
	_deal_direction()
	match cur_state:
		DogState.WALK:
			_handle_walk_state(delta)
		DogState.RUN:
			_handle_run_state(delta)
		DogState.POUNCE:
			_handle_pounce_state(delta)
		DogState.IDLE:
			_handle_idle_state(delta)
	velocity.y += gravity * delta
	move_and_slide()

func _process(delta: float) -> void:
	print(cur_state)
	print("player ", player.global_position)
	print("dog ", global_position)
	print(cal_distance())

func cal_distance() -> Vector2:
	var d = global_position.direction_to(player.global_position)
	return d

func _deal_direction() -> void:
	
	var d = cal_distance()
	if d.x > 0:
		direction = Direction.RIGHT
	else:
		direction = Direction.LEFT
	
	if direction == Direction.RIGHT:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
		
func _handle_walk_state(delta):
	animated_sprite_2d.play("run")
	velocity.x = WALK_SPEED * direction
	

func _handle_run_state(delta):
	pass
	
func _handle_pounce_state(delta):
	animated_sprite_2d.play("pounce")
	velocity.x = POUNCE_SPEED * direction
	velocity.y = - 100
	var d = cal_distance()
	if abs(d.x) < 0.5:
		cur_state = DogState.WALK 

func _handle_idle_state(delta):
	animated_sprite_2d.play("idle")
	cur_state = DogState.IDLE
	velocity.x = 0

func _on_pounce_area_area_entered(area: Area2D) -> void:

	if area.is_in_group("player"):
		cur_state = DogState.POUNCE


func _on_dog_body_area_entered(area: Area2D) -> void:

	if area.is_in_group("player"):
		touch_player.emit()


func _on_dog_body_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		cur_state = DogState.WALK
