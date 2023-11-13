#!/bin/sh

for i in `seq -w 15 130` ; do
	./box_convert ./modified/image00000$i.png> frame$i.inc ;
done
