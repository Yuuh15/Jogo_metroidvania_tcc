extends AudioStreamPlayer

const menu_music = preload("res://audios/My Home.mp3")
const level_1_intro = preload("res://audios/I'm In Madness - Intro.mp3")
const level_1_loop = preload("res://audios/I'm In Madness - Loop.mp3")

func _play_music(music: AudioStream, volume = -9.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_music_level1():
	_play_music(level_1_intro)
	await self.finished
	_play_music(level_1_loop)
	
func play_music_menu():
	_play_music(menu_music)
