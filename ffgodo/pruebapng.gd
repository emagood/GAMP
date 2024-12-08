'''
FUNCIONA 

'''

extends Control	
#
## Función para iniciar el proceso FFmpeg y guardar los frames
#func start_ffmpeg():
	#var output_folder = ""
#
	#var command = "ffmpeg"
	#var args = [
		#"-i", "input_video.mp4",
		#"-t", "2",  # Duración de 2 segundos
		#"-vf", "fps=25",  # Cambia fps si es necesario
		#output_folder + "frame_%04d.png"  # Formato de nombre para los frames
	#]
#
	## Ejecutar FFmpeg y capturar la salida
	#var output = []
	#var error_code = OS.execute(command, args, output, true)
	#if error_code != 0:
		#print("Error al ejecutar FFmpeg, código de salida: ", error_code)
		#print("Salida de FFmpeg: ", output)
	#else:
		#print("Frames generados correctamente en ", output_folder)
#
## Función ready
#func _ready():
	#start_ffmpeg()
