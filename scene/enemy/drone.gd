class_name Drone
extends Enemy

enum DroneState {
	PATROL,
	IDLE,
	CHASE,
	ATTACK
}

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D

const SPEED: float = 100

var cur_state: DroneState = DroneState.IDLE
var state_delay: float = 0
var direction: Direction = Direction.LEFT

func _ready() -> void:
	animated_sprite_2d.play("idle")
	
func _physics_process(delta: float) -> void:
	
	_add_state_delay(delta)
	
	match cur_state:
		DroneState.IDLE:
			_handle_idle(delta)
		DroneState.PATROL:
			_handle_partrol(delta)
		DroneState.CHASE:
			_handle_chase(delta)
		DroneState.ATTACK:
			_handle_attack(delta)
	
	move_and_slide()

func _process(delta: float) -> void:
	if direction == 1:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false

func _handle_idle(delta: float) -> void:
	velocity.x = 0
	
	if state_delay > 2:
		cur_state = DroneState.PATROL
		state_delay = 0
	
func _handle_partrol(delta: float) -> void:
	if _tend_to_move():
		velocity.x = SPEED * direction
	else:
		direction *= -1
		cur_state = DroneState.IDLE

func _handle_chase(delta: float) -> void:
	pass
	
func _handle_attack(delta: float) -> void:
	pass

func _tend_to_move() -> bool:
	var cur_position := position.x
	return (cur_position <= 100 and direction > 0) or \
		(cur_position >= 1000 and direction < 0) or not _on_board()
	

func _on_board() -> bool:
	var cur_position := position.x
	return cur_position <= 100 or cur_position >= 1000

func _add_state_delay(delta: float) -> void:
	state_delay += delta
