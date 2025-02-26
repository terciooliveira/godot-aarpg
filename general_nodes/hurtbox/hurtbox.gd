class_name HurtBox extends Area2D

@export var damage : int = 1


func _ready():
	area_entered.connect( AreaEntered )
	pass
	

func _process(_delta):
	pass
	
func AreaEntered( area : Area2D ) -> void:
	if area is HitBox:
		var hitbox : HitBox = area
		hitbox.TakeDamage( self )
