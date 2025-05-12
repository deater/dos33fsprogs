#!/bin/sh
ffmpeg -i Grongy_-_scroll_block_\(full\)_\(2024\).gif filename%05d.png
for i in `seq -w 00001 00194` ; do ../../../../utils/gr-utils/sca2gr filename$i.png $i.gr ; done

