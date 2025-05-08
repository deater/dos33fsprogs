#!/bin/sh

for i in `seq -w 00001 00194` ; do ../../../../utils/gr-utils/sca2gr filename$i.png $i.gr ; done

