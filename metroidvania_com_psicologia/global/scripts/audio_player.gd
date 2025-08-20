extends AudioStreamPlayer

const menu_music = preload("res://audios/My Home.wav")
const level_1 = preload("res://audios/A New Chance to Myself.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_music_level1():
	_play_music(level_1)
