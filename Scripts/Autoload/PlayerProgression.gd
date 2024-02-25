extends Node

var EXP = 0
var MaxEXP = 100
var Level = 0
var MaxLevel = 20
var XPCache = 0

signal EXPUpdate
signal LevelUpdate

signal PowerUpSelected

var TempProgress = {}

var EXPCacheReleaseTimer

var SkillPoints = 1
var AllocatedSkillPoints = 1

signal SkillsReset
signal SkillsCompleteTransaction
signal SkillsLockin(bCanLockin)
signal SkillPointAllocated

func GetMaxLevel():
	return MaxLevel
func _ready():
	EXPCacheReleaseTimer = Timer.new()
	EXPCacheReleaseTimer.wait_time = .05
	EXPCacheReleaseTimer.autostart = true
	EXPCacheReleaseTimer.one_shot = false
	EXPCacheReleaseTimer.connect("timeout", Callable(self, "OnEXPCacheReleaseTimeOut"))
	add_child(EXPCacheReleaseTimer)

func OnEXPCacheReleaseTimeOut():
	if Level >= MaxLevel:
		XPCache = 0
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
		AddSkillPoints(3)
		emit_signal("LevelUpdate")
	emit_signal("EXPUpdate")

func AddSkillPoints(amount):
	SkillPoints = amount
	AllocatedSkillPoints = amount
	emit_signal("SkillPointAllocated")

func UseAllocatedSkillPoint():
	AllocatedSkillPoints -= 1
	emit_signal("SkillPointAllocated")

func ResetAllocatedSkillPoints():
	AllocatedSkillPoints = SkillPoints
	emit_signal("SkillsReset")
	emit_signal("SkillPointAllocated")

func CanAffordSkill():
	return AllocatedSkillPoints > 0

func CompleteSkillTransaction():
	AllocatedSkillPoints = 0
	SkillPoints = 0
	emit_signal("SkillsCompleteTransaction")
	emit_signal("SkillPointAllocated")

func AddTempPower(property,value):
	if TempProgress.has(property):
		TempProgress[property] += value
	else:
		TempProgress[property] = value

func GetTempPower(property):
	if TempProgress.has(property):
		return TempProgress[property]
	return 0

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

func GetLevelString():
	if Level < MaxLevel:
		return str(Level)
	else:
		return "MAX"
