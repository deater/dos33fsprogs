#!/bin/sh

echo "Test lots of files..."

cp empty.dsk test.dsk

../dos33 ./test.dsk catalog

../dos33 ./test.dsk save a SINCOS SIN1
../dos33 ./test.dsk save a SINCOS SIN2
../dos33 ./test.dsk save a SINCOS SIN3
../dos33 ./test.dsk save a SINCOS SIN4
../dos33 ./test.dsk save a SINCOS SIN5
../dos33 ./test.dsk save a SINCOS SIN6
../dos33 ./test.dsk save a SINCOS SIN7
../dos33 ./test.dsk save a SINCOS SIN8
../dos33 ./test.dsk save a SINCOS SIN9
../dos33 ./test.dsk save a SINCOS SIN10
../dos33 ./test.dsk save a SINCOS SIN11
../dos33 ./test.dsk save a SINCOS SIN12
../dos33 ./test.dsk save a SINCOS SIN13
../dos33 ./test.dsk save a SINCOS SIN14
../dos33 ./test.dsk save a SINCOS SIN15
../dos33 ./test.dsk save a SINCOS SIN16




../dos33 ./test.dsk catalog
