extends CanvasLayer

@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer

func fade( mode : String ) -> bool:
	animation_player.play( "fade_" + mode )
	
	await animation_player.animation_finished
	
	return true

func fade_out() -> bool:   #TODO remove this 
	animation_player.play("fade_out")
	
	await animation_player.animation_finished
	
	return true
