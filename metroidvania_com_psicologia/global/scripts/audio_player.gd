extends AudioStreamPlayer

const menu_music = preload("res://audios/Creatones - My Home (No Fades).mp3")
const level_1_intro = preload("res://audios/I'm In Madness - Intro.mp3")
const level_1_loop = preload("res://audios/I'm In Madness - Loop.mp3")

const sfxSelectNormal = preload("res://audios/select.wav")
const sfxCollectItem = preload("res://audios/powerAcquired.wav")
const sfxDoor = preload("res://audios/Woosh.mp3")
const heal = preload("res://audios/heal.wav")

func _play_music(music: AudioStream, volume = -9.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()

func play_FX(stream: AudioStream, volume = 0.0, pitch = 1.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	fx_player.bus = "SFX" 
	fx_player.pitch_scale = pitch
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	
	fx_player.queue_free()

func sfx_Select_Normal():
	play_FX(sfxSelectNormal, -5.0)
	
func sfx_Collect():
	play_FX(sfxCollectItem, -13.0)

func sfx_Door():
	play_FX(sfxDoor, -9.0)

func sfx_heal():
	play_FX(heal, -9.0)

func play_music_level1():
	_play_music(level_1_intro)
	await self.finished
	_play_music(level_1_loop)
	
func play_music_menu():
	_play_music(menu_music)
