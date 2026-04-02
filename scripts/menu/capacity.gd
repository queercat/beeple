extends Button

@export var beeple: Node2D
@export var prices = [4, 8, 16, 32]
var upgrade_idx = 0

func _ready() -> void:
	text = "+ Capacity Upgrade (%d)" % prices[upgrade_idx]
	Global.honey_updated.connect(handle_honey_updated)

func _pressed() -> void:
	if check_usability():
		purchase_upgrade()

func current_price():
	return prices[upgrade_idx]

func check_usability():
	var honey = Global.honey
	
	# no honey
	if honey < current_price(): 
		disabled = true
		return false
	# no more upgrades	
	if upgrade_idx >= len(prices) - 1:
		disabled = true
		return false
	
	disabled = false
	return true

func handle_honey_updated(old, new):
	check_usability()

func purchase_upgrade():
	if upgrade_idx >= len(prices) - 1:
		return
	Global.deincrement_honey(current_price())
	upgrade_idx += 1
	do_upgrade()
	check_usability()
	text = "+ Capacity Upgrade (%d)" % prices[upgrade_idx]

func do_upgrade():
	var pollen_spawns: Array[Node2D] = beeple.pollen_spawns
	var spawn = pollen_spawns.filter(func (v): return v.is_disabled).pick_random()
	if spawn == null: return
	spawn.is_disabled = false
