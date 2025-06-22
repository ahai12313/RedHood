class_name RedHood
extends Player

var direction = Direction.RIGHT

@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var marker_2d: Marker2D = $"../Marker2D"

@onready var player_idle_state: PlayerIdleState = $StateMachine/PlayerIdleState
@onready var player_jump_state: PlayerJumpState = $StateMachine/PlayerJumpState
@onready var player_fall_state: PlayerFallState = $StateMachine/PlayerFallState
@onready var player_walk_state: PlayerWalkState = $StateMachine/PlayerWalkState
@onready var player_attack_state: PlayerAttackState = $StateMachine/PlayerAttackState


func _ready() -> void:
	player_idle_state.setup(self, state_machine)
	player_jump_state.setup(self, state_machine)
	player_fall_state.setup(self, state_machine)
	player_walk_state.setup(self, state_machine)
	player_attack_state.setup(self, state_machine)
	state_machine.change_to(player_idle_state)

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("move_left"):
		direction = Direction.LEFT
	if Input.is_action_just_pressed("move_right"):
		direction = Direction.RIGHT
	sprite_2d.flip_h = true if direction == -1 else false
	if position.y > 700:
		position.x = marker_2d.position.x
		position.y = marker_2d.position.y
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()

func _on_body_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		print("enemy entered")
