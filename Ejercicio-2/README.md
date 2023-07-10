# Ejercicio 2

## Consigna

Escribir un script que realice un BLAST de una o varias secuencias (si son varias se realiza un Blast por cada secuencia input) y escriba el resultado (blast output) en un archivo.

## Input

Secuencia Fasta (ej. Xxxx.fas con una o más secuencias de aminoácidos obtenidas en Ej.1)

## Output

Reporte Blast (ej. blast.out, si deciden hacer múltiples pueden generar un único o varios archivos)

## Ejecucion

* Si se quiere ejecutar el blast remoto

```sh
perl main.pl remote sequence.fsa
```

* Si se quiere ejecutar el blast local

```sh
perl main.pl local sequence.fsa
```

## Resultados

Los resultados de la operacion se encontraran en una nueva carpeta con el nombre result

## Interpretacion

Las secuencias encontradas en al realizar el blast son familias de secuencias de la secuencia de referencia, cada una con el score encontrado y el porcentaje de positivos (igualdad de secuencia) y de los gaps (diferencia de secuencia) encontrados al realizar el analisis

