class_name EnemyStateDestroy extends EnemyState

@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

var _damage_position : Vector2
var _direction : Vector2

func Init() -> void:
	enemy.enemy_destroyed.connect( _on_enemy_destroyed )
	pass
	
# what happens when player enters this state
func Enter() -> void:
	enemy.invulnerable = true
	enemy.hurt_box.monitoring = false
	_direction = enemy.global_position.direction_to( enemy.player.position )
	enemy._SetDirection( _direction )
	enemy.velocity = _direction * -knockback_speed
	enemy.UpdateAnimation( anim_name )
	enemy.animation_player.animation_finished.connect( _on_animation_finished )
	pass

func Exit() -> void:
	pass

func Process( _delta : float ) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

func Physics( _delta : float ) -> EnemyState:
	return null	

func _on_enemy_destroyed( hurt_box : HurtBox ) -> void:
	_damage_position = hurt_box.global_position
	state_machine.ChangeState( self )
	pass

func _on_animation_finished( _anim_name : String ) -> void:
	enemy.queue_free()
