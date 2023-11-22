from godot import exposed, export
from godot import *
import random
import subprocess
import json


@exposed
class pseudorandomNumbers(Node2D):

	# member variables here, example:
	a = export(int)
	b = export(str, default='foo')

	def _ready(self):
		"""
		Called every time the node is added to the scene.
		Initialization here.
		"""
		pass
	
	def prueba(sef):
		print("jajaj")
		return "entro a prueba"
	
	def nose(self):
		numbersSpdale = []
		validation = True
		#count = 0
		while validation:
			numbersSpdale= self.generate_random_dis_unifo(1000,-90,90)
			validation = self.validate_numbers_spdale(numbersSpdale)
			if(validation):
				validation = False
			#	print("es valido")
			elif(validation == "error"):
				validation = False
				#print("es error")
			else:
				validation = True
				#print("es falso: ", validation )
				#count += 1
				#if(count==20):
				#	print("se genearron mal")
					#validation = False
		#print("los numeros generados son", numbersSpdale)
		return json.dumps(numbersSpdale)
			
			
	
	
	def generate_random_dis_unifo(self,quantity,min_value,max_value):
		self.quantity = quantity
		aleatory = []
		ni_sequence = []
		ri_sequence = []
		while self.quantity > 0:
			random_number = random.uniform(min_value,max_value)   # Genera un número pseudoaleatorio uniformemente
			#print(self, "Esta es una prueba: " + str(random_number))
			aleatory.append(random_number)
			xi = float(random_number) / 10000.0  # Convierte el número aleatorio en xi
			ni_sequence.append(xi)
			 # Calcula el valor de xi (escala el número aleatorio al rango [0, 1))
			ni = min_value + (max_value -min_value) * xi
			ni_sequence.append(ni)		
			ri_sequence.append(xi)
			self.quantity -= 1
		return aleatory
		
		
	def validate_numbers_spdale(self,numeros):
		# se Convierte la lista de números a cadenas y pasa cada número como un argumento separado
		args = ['python', 'chi_cuadrado.py'] + [str(num) for num in numeros]
		#process = subprocess.run(['python', 'chi_cuadrado.py', numeros_str], capture_output=True, text=True) #muesta ventana negra 
		process = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, creationflags=subprocess.CREATE_NO_WINDOW)
		output, error = process.communicate()
		
		#process = subprocess.run(args, capture_output=True, text=True)
	
		if process.returncode == 0:
			# El script se ejecutó correctamente
			resultado = output.strip()
			#print("Resultado del script:", resultado)
			if(resultado == "True"):
				return True
			else:
				return False
		else:
			#Hubo un error en la ejecución del script
			print("Error al ejecutar el script. Código de salida:", process.returncode)
			print("Error estándar del script:", process.stderr)
			return "error"
		
		


		
