#! /bin/sh

set -x

treatMac()
{
    mac=$(echo $2 | awk '/^.*$/{print $1}')
    name=$(echo $2 | awk '/^.*$/{print $2}')
    echo "-- treating $mac $name"
    echo "-- treating $mac $name" >> $1
    if [ "$(grep $mac $1)" = "" ]
    then
        hcitool info $mac >> $1
        l2ping $mac >> $1
        sdptool browse $mac >> $1
    fi
}

init()
{
#pre conf
    hciconfig -a hci0 up
    hciconfig -a hci0 class 0x500204
    hciconfig -a hci0 lm accept, master;
    hciconfig -a hci0 lp rswitch,hold,sniff,park;
    hciconfig -a hci0 auth enable
    hciconfig -a hci0 encrypt enable
}

mainLoop()
{
    while true
    do
        for i in $(hcitool scan hci0 | grep -iv "scanning")
        do
            treatMac $1 $i
        done
        sleep 10
    done
}

init
mainLoop output.log
