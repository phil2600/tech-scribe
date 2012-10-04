#! /bin/bash

PATH_OUT=out
PATH_EXTRA=extra

OUTPUT_USEFUL=out/Useful.html
OUTPUT_RAW=out/Raw.html

INPUT_USEFUL="$(find useful -type f | tr '\n' ' ')"
INPUT_USEFUL="${INPUT_USEFUL%?}"
pandoc -s -S --toc --highlight-style=tango -c $PATH_EXTRA/pandoc.css -A $PATH_EXTRA/footer.html $INPUT_USEFUL -o $OUTPUT_USEFUL


INPUT_RAW="$(find raw useful -type f | tr '\n' ' ')"
INPUT_RAW="${INPUT_RAW%?}"
pandoc -s -S --toc --highlight-style=tango -c $PATH_EXTRA/pandoc.css -A $PATH_EXTRA/footer.html $INPUT_RAW -o $OUTPUT_RAW
