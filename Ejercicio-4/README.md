# Ejercicio 4

## Consigna

Descargar las secuencias (en formato fasta) de 3 o más organismos distintos pertenecientes a otras especies que hayan salido en los resultados del Blast y realizar un alineamiento múltiple con tu secuencia de consulta más estas otras encontradas.

## Input

Reporte Blast (blast.out del ej. 2) y un Pattern (por ej. “Mus Musculus”)

## Output

Lista de los hits que coincidan con el pattern (por ej. solo los hits de Ratones)

## Ejecucion

```sh
perl main.pl sequence.blast.out 'Mus Musculus'
```

## Resultados

Los resultados de la operacion se encontraran en una nueva carpeta con el nombre result
