import zipfile
import os

def unzip_jar(jar_file, target_dir):
    with zipfile.ZipFile(jar_file, 'r') as zip_ref:
        zip_ref.extractall(target_dir)

def extract_file_from_jar(jar_file, file_to_extract, target_dir):
    with zipfile.ZipFile(jar_file, 'r') as zip_ref:
        zip_ref.extract(file_to_extract, target_dir)

# Ruta al archivo JAR
ruta_jar = 'archivo.jar'

# Directorio de destino para la extracción
directorio_destino = 'extraccion/'

# Descomprimir el archivo JAR
unzip_jar(ruta_jar, directorio_destino)

# Extraer el archivo mifichero.properties
archivo_a_extraer = 'mifichero.properties'
extract_file_from_jar(ruta_jar, archivo_a_extraer, directorio_destino)

print(f"El archivo '{archivo_a_extraer}' ha sido extraído exitosamente en '{directorio_destino}'.")
