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


    INPUT=$(find "$@" -type f | sort | tr '\n' ' ')
    INPUT="${INPUT%?}"
    echo $INPUT
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


    INPUT=$(find "$@" -type f | sort | tr '\n' ' ')
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


compileFolderTree()
{
    style=$1
    shift
    outputName=$1
    shift

    tmpFile="out/toto" #$(mktemp)
    cat > $tmpFile <<EOF
% Technical cheat sheets
% Poulpy, Plopi42
% $(date +%F)

EOF

    for dir in "$@"
    do
        for entry in $(find "$dir"/*)
        do
   	    if [ -f $entry ]
   	    then
   	        cat "$entry" >> $tmpFile
   	    else
                titleMark=$(echo "$entry" | sed -e 's_[^/]__g' | tr '/' '#')
   	        echo "$titleMark $(basename $entry) $titleMark" >> $tmpFile
   	    fi
        done
    done

    rm -f "$outputName.html"
    pandoc -s -S --toc "--highlight-style=$style" -c "$PATH_EXTRA/pandoc.css" -A "$PATH_EXTRA/footer.html" $tmpFile -o "$outputName.html"
}

clean

#compileHtml tango $OUTPUT_USEFUL useful
compileHtml tango $OUTPUT_RAW raw

#compileLaTex tango $OUTPUT_USEFUL useful
#compileLaTex tango $OUTPUT_RAW useful raw

compileFolderTree tango $OUTPUT_USEFUL useful

