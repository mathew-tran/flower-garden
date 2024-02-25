extends Node

var EXP = 0
var MaxEXP = 100
var Level = 0
var XPCache = 0

signal EXPUpdate
signal LevelUpdate

signal PowerUpSelected

var TempProgress = {}

var EXPCacheReleaseTimer

func _ready():
	EXPCacheReleaseTimer = Timer.new()
	EXPCacheReleaseTimer.wait_time = .05
	EXPCacheReleaseTimer.autostart = true
	EXPCacheReleaseTimer.one_shot = false
	EXPCacheReleaseTimer.connect("timeout", Callable(self, "OnEXPCacheReleaseTimeOut"))
	add_child(EXPCacheReleaseTimer)

func OnEXPCacheReleaseTimeOut():
	if XPCache == 0:
		EXPCacheReleaseTimer.stop()
		return

	var rate = 1
	if XPCache > 100:
		rate = 50
	elif XPCache > 10:
		rate = 5

	if rate > MaxEXP - EXP:
		rate = clampi(MaxEXP - EXP, 1, XPCache)

	EXP += rate
	XPCache -= rate
	while EXP >= MaxEXP:
		Level += 1
		EXP -= MaxEXP
		emit_signal("EXPUpdate")
		MaxEXP *= 1.1
		emit_signal("LevelUpdate")
	emit_signal("EXPUpdate")

func AddTempPower(property,value):
	if TempProgress.has(property):
		TempProgress[property] += value
	else:
		TempProgress[property] = value

func BroadcastPowerUpSelected():
	emit_signal("PowerUpSelected")

func AddXP(amount):
	XPCache += amount
	EXPCacheReleaseTimer.start()

func GetEXP():
	return EXP

func GetMaxEXP():
	return MaxEXP

func GetLevel():
	return Level
