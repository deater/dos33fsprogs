#!/bin/sh

for i in `seq -w 00001 00194` ; do ../../../../utils/gr-utils/gr2png $i.gr vgr$i.png ; done

