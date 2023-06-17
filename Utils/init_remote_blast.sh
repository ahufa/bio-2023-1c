#!/bin/bash

if [ ! -d "ncbi-blast-2.14.0+" ]; then
    wget ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.14.0+-x64-linux.tar.gz
    tar -xvf ncbi-blast-2.14.0+-x64-linux.tar.gz
    rm ncbi-blast-2.14.0+-x64-linux.tar.gz
fi