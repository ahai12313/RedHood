class_name LittleBlack
extends Enemy

@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var floor_detect: RayCast2D = $FloorDetect
@onready var player_detect: RayCast2D = $PlayerDetect
@onready var enemy_body: Area2D = $EnemyBody
@onready var enemy_attack_box: Area2D = $EnemyAttackBox
@onready var enemy_attack_box_collision: CollisionShape2D = $EnemyAttackBox/EnemyAttackBoxCollision
@onready var enemy_stats: Stats = $EnemyStats

@export var enemy_type: String = "default"

@onready var enemy_idle_state: EnemyIdleState = $StateMachine/EnemyIdleState
@onready var enemy_walk_state: EnemyWalkState = $StateMachine/EnemyWalkState
@onready var enemy_run_state: EnemyRunState = $StateMachine/EnemyRunState
@onready var enemy_attack_state: EnemyAttackState = $StateMachine/EnemyAttackState

const FLOOR_DETECT_LENTH: float = 24.0
const PLAYER_DETECT_DEGREE: float = -90

var direction = Direction.LEFT
var player: Area2D = null
var world: World = null

func _ready() -> void:
	
	_init_player()
	world = get_tree().get_first_node_in_group("world")
	floor_detect.position.x = FLOOR_DETECT_LENTH
	player_detect.rotation_degrees = PLAYER_DETECT_DEGREE
	
	enemy_idle_state.setup(self, state_machine)
	enemy_walk_state.setup(self, state_machine)
	enemy_run_state.setup(self, state_machine)
	enemy_attack_state.setup(self, state_machine)
	state_machine.change_to(enemy_idle_state)

func _physics_process(delta: float) -> void:
	if direction == -1:
		sprite_2d.flip_h = true
		floor_detect.position.x = -FLOOR_DETECT_LENTH
		player_detect.rotation_degrees = -PLAYER_DETECT_DEGREE
		enemy_attack_box_collision.position.x = -8	
	else:
		sprite_2d.flip_h = false
		floor_detect.position.x = FLOOR_DETECT_LENTH
		player_detect.rotation_degrees = PLAYER_DETECT_DEGREE
		enemy_attack_box_collision.position.x = 8
	if is_beside_platform():
		state_machine.change_to(enemy_idle_state)
	
	velocity.y += delta * gravity
	move_and_slide()
 
func _process(delta: float) -> void:
	#var overlapping_areas = enemy_body.get_overlapping_areas()
	#for area in overlapping_areas:
		#state_machine.change_to(enemy_attack_state)
	_get_direction()

func _init_player() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players:
		player = players[0]

func _get_direction() -> void:
	if player:
		var d = global_position.direction_to(player.global_position)
		direction = -1 if d.x < 0 else 1

func _deal_damage():
	world.shake_camera(4)
	enemy_stats.health -= 1
	if enemy_stats.health == 0:
		queue_free()

func is_beside_platform() -> bool:
	return not floor_detect.is_colliding()

# 悬崖边转身
func turn_around() -> void:
	direction *= -1

func discovered_player() -> bool:
	return player_detect.is_colliding()

func _on_body_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		state_machine.change_to(enemy_attack_state)
	elif area.is_in_group("player_hit"):
		#print("[enemy] hurt")
		_deal_damage()
