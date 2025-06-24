class_name Drone
extends Enemy

enum DroneState {
	PATROL,
	IDLE,
	CHASE,
	ATTACK
}

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var bullet: CPUParticles2D = $bullet
@onready var player_attack_area: Area2D = $PlayerAttackArea
@onready var player_detect: Area2D = $PlayerDetect
@onready var pdc: CollisionShape2D = $PlayerDetect/PDC


const SPEED: float = 100

var cur_state: DroneState = DroneState.IDLE
var state_delay: float = 0
var direction: Direction = Direction.LEFT

var player: Area2D = null

func _ready() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players:
		player = players[0]
	bullet.local_coords = false
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
	#print("[drone] idle")
	velocity.x = 0
	
	if state_delay > 2:
		cur_state = DroneState.PATROL
		_reset_state_timer()
	
func _handle_partrol(delta: float) -> void:
	if _tend_to_move():
		velocity.x = SPEED * direction
	else:
		direction *= -1
		cur_state = DroneState.IDLE

func _handle_chase(delta: float) -> void:

	if player:
		var d = global_position.direction_to(player.global_position)
		direction = Direction.LEFT if d.x < 0 else Direction.RIGHT
		velocity.x = SPEED * direction if int(player.global_position.x - global_position.x) != 0 else 0
	else:
		player = null
		state_delay = 0
		cur_state = DroneState.IDLE
	
func _handle_attack(delta: float) -> void:
	
	_set_bullet_properties()
	direction = 1 if bullet.direction.x > 0 else -1
	_keep_distance()

func _tend_to_move() -> bool:
	var cur_position := position.x
	return (cur_position <= 100 and direction > 0) or \
		(cur_position >= 1000 and direction < 0) or not _on_board()
	

func _on_board() -> bool:
	var cur_position := position.x
	return cur_position <= 100 or cur_position >= 1000

func _add_state_delay(delta: float) -> void:
	state_delay += delta

func _reset_state_timer() -> void:
	state_delay = 0

func _move_to_player() -> void:
	velocity.x = SPEED * direction

func _leave_from_player() -> void:
	velocity.x = -SPEED * direction

func _keep_distance() -> void:
	var distance_to_player = self.global_position.distance_to(player.global_position)
	if distance_to_player > 140:
		_move_to_player()
	else:
		_leave_from_player()

func _on_player_detect_area_entered(area: Area2D) -> void:
	#print("[drone] player entered")
	if cur_state != DroneState.CHASE:
		_reset_state_timer()
	cur_state = DroneState.CHASE


func _on_player_detect_area_exited(area: Area2D) -> void:
	#print("[drone] player exited")
	_reset_state_timer()
	cur_state = DroneState.IDLE


func _set_bullet_properties() -> void:
	bullet.direction = bullet.global_position.direction_to(player.global_position).normalized()
	bullet.initial_velocity_max = 500.0
	bullet.spread = 0
	bullet.position.x = 8 * direction
	bullet.emitting = true

func _on_player_attack_area_area_entered(area: Area2D) -> void:
	_reset_state_timer()
	cur_state = DroneState.ATTACK


func _on_player_attack_area_area_exited(area: Area2D) -> void:
	print("_on_player_attack_area_area_exited")
	bullet.emitting = false
	cur_state = DroneState.CHASE
