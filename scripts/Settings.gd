extends Node

func _ready():
	$Cycles/Value.value = Global.cycles
	$WMinutes/Value.value = Global.wMin
	$BMinutes/Value.value = Global.bMin

func _on_SetButton_pressed():
	Global.cycles = $Cycles/Value.value
	Global.wMin = $WMinutes/Value.value
	Global.bMin = $BMinutes/Value.value

	get_tree().change_scene("res://scenes/Memedoro.tscn")
