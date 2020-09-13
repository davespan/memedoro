extends Node

onready var timer = $Timer
onready var timer_label = $CountdownLabel
onready var bg = $BgColor
onready var work_sound = $work_sound
onready var break_sound = $break_sound
onready var start_button = $Start

enum {WORK, BREAK}

var state

var work_color = "#cc0000"
var break_color = "#009933"
var default_color = "#242424"

var seconds = 0
var minutes

var cycles
var wMinutes
var bMinutes

func _ready():
	setTimes()
	state = WORK
	minutes = wMinutes

func _process(delta):
	if cycles: 
		match state:
			WORK:
				if seconds < 0 and minutes > 0:
					seconds = 59
					minutes -= 1
	
				if seconds == 0 and minutes == 0:
					state = BREAK
					cycles -= 1
					minutes = bMinutes
					bg.color = Color(break_color)
					break_sound.play()
			BREAK:
				if seconds < 0 and minutes > 0:
					seconds = 59
					minutes -= 1
	
				if seconds == 0 and minutes == 0:
					state = WORK
					minutes = wMinutes
					bg.color = Color(work_color)
					work_sound.play()
	
		timer_label.set_text(str(minutes) + ":" + str(seconds))
		
	else:
		start_button.show()
		timer.stop()
		bg.color = Color(default_color)

func _on_Start_pressed():
	bg.color = Color(work_color)
	work_sound.play()
	setTimes()
	timer.start()
	start_button.hide()

func setTimes():
	cycles = Global.cycles
	wMinutes = Global.wMin
	bMinutes = Global.bMin

func _on_Settings_pressed():
	get_tree().change_scene("res://scenes/Settings.tscn")

func _on_Timer_timeout():
	seconds -= 1
