#!/bin/sh

rm result
for i in `seq 0 80`; do sox -r 8000 -e unsigned-integer -b8 -c1 out.$i.raw -n stat 2>> result ; done

cat result | grep freq | awk '{ print $3}'  -
