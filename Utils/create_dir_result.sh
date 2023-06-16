#!/bin/bash

folder="result"

if [ -d "$folder" ]; then
    rm -rf "$folder"/*
else
    mkdir "$folder"
fi