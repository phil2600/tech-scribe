#! /bin/bash

PATH_OUT=out
PATH_EXTRA=extra
OUTPUT_USEFUL=out/Useful.html
OUTPUT_RAW=out/Raw.html


#
# compile style outputName inputs...
#
compileHtml()
{
    style=$1
    shift
    outputName=$1
    shift


    INPUT=$(find "$@" -type f | tr '\n' ' ')
    INPUT="${INPUT%?}"
    pandoc -s -S --toc "--highlight-style=$style" -c "$PATH_EXTRA/pandoc.css" -A "$PATH_EXTRA/footer.html" $INPUT -o "$outputName"
}


compileHtml tango $OUTPUT_USEFUL useful
compileHtml tango $OUTPUT_RAW useful raw

