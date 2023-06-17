#!/bin/bash

if [ -d "database" ]; then
    echo "La base de datos local ya existe"
else
    mkdir database && cd database
    wget ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/swissprot.gz
    gzip -d swissprot.gz
    makeblastdb -in swissprot -parse_seqids -blastdb_version 5 -dbtype prot
fi