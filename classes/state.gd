class_name State
extends Node

var owner_node: CharacterBody2D
var state_machine: StateMachine

const WALK_SPEED = 320
var gravity = 980.0

func setup(owner: CharacterBody2D, machine: StateMachine) -> void:
	owner_node = owner
	state_machine = machine

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func physics_update(delta: float) -> void:
	pass
	
func update(delta: float) -> void:
	pass

func process_input(event: InputEvent) -> void:
	pass

func tend_to_move() -> bool:
	return Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
