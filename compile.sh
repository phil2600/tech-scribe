#! /bin/bash

PATH_OUT=out
PATH_EXTRA=extra
OUTPUT_USEFUL=out/Useful
OUTPUT_RAW=out/Raw


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
    pandoc -s -S --toc "--highlight-style=$style" -c "$PATH_EXTRA/pandoc.css" -A "$PATH_EXTRA/footer.html" $INPUT -o "$outputName.html"
}

#
# compile style outputName inputs...
#
compileLaTex()
{
    style=$1
    shift
    outputName=$1
    shift


    INPUT=$(find "$@" -type f | tr '\n' ' ')
    INPUT="${INPUT%?}"
    pandoc -s -S --toc "--highlight-style=$style" -c "$PATH_EXTRA/pandoc.css" $INPUT -o "$outputName.tex"
}

#
# clean
#
clean()
{
    find . -name '*~' -delete
}


clean

compileHtml tango $OUTPUT_USEFUL useful
compileHtml tango $OUTPUT_RAW useful raw

compileLaTex tango $OUTPUT_USEFUL useful
#compileLaTex tango $OUTPUT_RAW useful raw

