class_name State extends Node

static var player : Player
static var state_machine : PlayerStateMachine

func _ready() -> void:
	pass
	
func init() -> void:
	pass
	
# what happens when player enters this state
func Enter() -> void:
	pass

func Exit() -> void:
	pass

func Process( _delta : float ) -> State:
	return null

func Physics( _delta : float ) -> State:
	return null	
	
func HandleInput( _event : InputEvent ) -> State:
	return null
