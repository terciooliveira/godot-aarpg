class_name StateWalk extends State

@export var move_speed : float = 100.0

@onready var idle: StateIdle = $"../Idle"
@onready var attack: StateAttack = $"../Attack"

	
# what happens when player enters this state
func Enter() -> void:
	player.UpdateAnimation("walk")
	pass

func Exit() -> void:
	pass

func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction.normalized() * move_speed
	
	if player.changed_direction:
		player.UpdateAnimation("walk")
	
	return null

func Physics( _delta : float ) -> State:
	return null	
	
func HandleInput( _event : InputEvent ) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
