extends Button

@export var prices = [1, 2, 4, 8, 16]
var upgrade_idx = 0

func _ready() -> void:
	text = "+ Production Upgrade (%d)" % prices[upgrade_idx]
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
	text = "+ Production Upgrade (%d)" % prices[upgrade_idx]

func do_upgrade():
	Global.honey_per_second *= 2
