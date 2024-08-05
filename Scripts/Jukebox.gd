extends Node

var Songs = [
	"res://Audio/Music/57._summer_sound.mp3",
	"res://Audio/Music/summer_time_-_migfus20.mp3",
	"res://Audio/Music/try-06.mp3"
	]
	
var Index = 0

func _ready():
	Songs.shuffle()
	
	PickSong()
	
func PickSong():
	$AudioStreamPlayer2D.stream = load(Songs[Index])
	Index += 1
	if Index >= len(Songs):
		Index = 0
	$AudioStreamPlayer2D.play()
	
func StartTimer():
	$Timer.wait_time = randf_range(20, 30)
	$Timer.start()


func _on_timer_timeout():
	PickSong()
	


func _on_audio_stream_player_2d_finished():
	StartTimer()
