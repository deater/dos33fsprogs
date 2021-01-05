#!/bin/sh

echo "Testing odd file names..."

cp empty.dsk test.dsk

../dos33 ./test.dsk catalog

../dos33 ./test.dsk save a ././SINCOS
../dos33 ./test.dsk save a SINCOS this_is_a_very_very_long_filename
../dos33 ./test.dsk save a SINCOS \~CrAzY\%\$F\*\{\(
../dos33 ./test.dsk save a SINCOS 679-8329
../dos33 ./test.dsk save a SINCOS SPACES\ ARE\ OK
../dos33 ./test.dsk save a SINCOS Commas,are,not

../dos33 ./test.dsk catalog
