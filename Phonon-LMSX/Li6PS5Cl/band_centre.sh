#!/bin/sh

    echo "please give file name containing d-band density of states"
    read file
    echo "please specify the Fermi energy"
    read Fermi
cat $file |  sed '/#/d'| awk '{g=g+$1*$2; h=h+$2; if ($2 > 0.0) print g/h-"'$Fermi'"}' | tail -1
