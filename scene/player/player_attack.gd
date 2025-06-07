class_name PlayerAttackState
extends State

var player_node: Player

func setup(owner: CharacterBody2D, machine: StateMachine) -> void:
	owner_node = owner
	state_machine = machine
	player_node = owner_node
	
func enter() -> void:
	player_node.animation_player.play("attack")

func update(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction == 1.0:
		owner_node.direction = owner_node.Direction.RIGHT
	elif direction == -1.0:
		owner_node.direction = owner_node.Direction.LEFT
	owner_node.velocity.x = direction * WALK_SPEED
	
	if player_node.animation_player.is_playing():
		return
	
	if tend_to_move():
		state_machine.change_to(owner_node.player_walk_state)
	else:
		state_machine.change_to(owner_node.player_idle_state)
