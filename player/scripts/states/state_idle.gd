class_name StateIdle extends State

@onready var walk: StateWalk = $"../Walk"
@onready var attack: StateAttack = $"../Attack"

# what happens when player enters this state
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass

func Exit() -> void:
	pass

func Process( _delta : float ) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

func Physics( _delta : float ) -> State:
	return null	
	
func HandleInput( _event : InputEvent ) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
