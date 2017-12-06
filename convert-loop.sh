#!/bin/bash

#Put source directory here
Source=[Path to Source Directory]

#Destination directory here
Destination=[Path to Destination Directory]

#Handbrake options for encoding
OPTIONS=[Handbrake encoding options]

function convert {
        if [ `find "$1" -maxdepth 1 -type f | wc -l` -gt 0 ]; then
                repl=`basename "$Source"`
                for file in $1/*.mkv ; do
                        parent=`echo "$1" | sed -e "s/$repl/$Destination/"`
                        if [ ! -d "$parent" ]; then
                                mkdir -p "$parent"
                        fi
                        OUTPUT="$parent"/"$(basename "$file")"
                        if [ ! -f "$OUTPUT" ]; then
                                HandBrakeCLI -i "$file" -o "$OUTPUT" $OPTIONS
			            fi
                done
        fi
}

function loop {
        for folder in `find "$1" -maxdepth 1 ! -path "$1"  -type d` ; do
                convert "$folder"
                if [ `find "$1" -maxdepth 1 -type d | wc -l` -gt 1 ]
                then
                        loop "$folder"
                fi
        done
}

loop "$Source"

