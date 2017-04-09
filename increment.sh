#!/bin/bash

filepath=$1

for file in `ls "$filepath"|sort -g -r`
do
    filename=$(basename "$file")
#    echo "$filename"
    extension=${filename##*.}
#    echo "$extension"
    filename=${filename%.*}
#    echo $filename
    newfile="${filename::-2}""$((10#${filename: -2} + 1))".$extension
    echo "$newfile"
     
done
