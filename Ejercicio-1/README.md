# Ejercicio 1

## Consigna

Escribir un script que lea una o más secuencias (de nucleótidos) de un archivo que contenga la información en formato GenBank de un mRNA de su gen (o genes) de interés, las traduzca a sus secuencias de amino ácidos posibles (tener en cuenta los Reading Frames) y escriba los resultados en un archivo en formato FASTA.

## Input

Archivo de secuencias Genbank (ej. NMxxxx.gbk con una o más secuencias)

## Output

Archivo de secuencias Fasta de cada ORF (ej. Xxxxx.fas con una o más secuencias de aminoácidos)

## Ejecucion

```sh
perl main.pl sequence.gb
```

## Resultados

Los resultados de la operacion se encontraran en una nueva carpeta con el nomnbre result

## Aclaracion

Para poder identificar cual es el marco de lectura correcto se puede ejecutar el ejercicio 2 pasandole como input el outtput de este script y asi evaluar el resultado del blast. El marco que que haya encontrado la secuecia de referencia tendra el marco de lectura correcto