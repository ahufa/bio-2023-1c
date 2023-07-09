# Introducción a la Bioinformática 

## Integrantes del equipo

	- Facundo Ahumada
    - Cristian Eguez
    - Agustin Ricardo Luna

## Requisitos

### Configuración con script

Se puede instalar los paquetes necesarios para poder ejecutar los scripts de cadaejercicio corriendo el scrip init.sh, que se encuentra dentro de la carpeta Utils. Es necesario ejecutarlo como sudo

```sh
sudo ./Utils/init.sh
```

### Configuración manual

Las distribuciones Linux que suelen utilizarse en bioinformática son Debian o Ubuntu

* Actualizar servidor

```sh
sudo apt update && sudo apt upgrade -y
```

* Instalar perl, bioperl, blast

```sh
sudo apt install perl bioperl ncbi-blast+ -y
```