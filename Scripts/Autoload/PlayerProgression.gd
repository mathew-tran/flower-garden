extends Node

var EXP = 0
var MaxEXP = 100
var Level = 0

signal EXPUpdate
signal LevelUpdate

signal PowerUpSelected

var TempProgress = {}

func AddTempPower(property,value):
	if TempProgress.has(property):
		TempProgress[property] += value
	else:
		TempProgress[property] = value

func BroadcastPowerUpSelected():
	emit_signal("PowerUpSelected")

func AddXP(amount):
	EXP += amount
	while EXP >= MaxEXP:
		Level += 1
		EXP -= MaxEXP
		emit_signal("EXPUpdate")
		MaxEXP *= 1.1
		emit_signal("LevelUpdate")
	emit_signal("EXPUpdate")

func GetEXP():
	return EXP

func GetMaxEXP():
	return MaxEXP

func GetLevel():
	return Level
