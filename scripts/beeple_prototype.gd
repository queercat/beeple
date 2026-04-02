extends Node2D

@export var pollen_prefab: PackedScene
@export var pollen_spawns: Array[Node2D]

var timer = 0

func _process(delta: float) -> void:
	timer += delta
	
	if timer >= 1 / Global.honey_per_second:
		spawn_honey()
		timer = 0

func get_honey_spawn():
	var possible_spawns = pollen_spawns.filter(func (v): return !v.is_occupied && !v.is_disabled)
	if possible_spawns.is_empty():
		return
	var spawn = possible_spawns.pick_random()
	return spawn

func spawn_honey():
	var spawn = get_honey_spawn()
	if spawn == null:
		print("too full!")
		return
	spawn.is_occupied = true
	var instance = pollen_prefab.instantiate()
	instance.spawn = spawn
	add_sibling(instance)
	instance.global_position = spawn.global_position
	instance.grow()
	
func _draw() -> void:
	pass
	
func _ready() -> void:
	pass
