#!/bin/sh

echo "Testing dos33 Lock/Unlock..."

cp empty.dsk test.dsk

../dos33 ./test.dsk catalog

../dos33 ./test.dsk save b LL_6502
../dos33 ./test.dsk save b TB_6502
../dos33 ./test.dsk save a SINCOS
../dos33 ./test.dsk save i test.int

../dos33 ./test.dsk catalog

../dos33 ./test.dsk lock LL_6502
../dos33 ./test.dsk lock SINCOS

../dos33 ./test.dsk catalog

../dos33 ./test.dsk unlock LL_6502

../dos33 ./test.dsk catalog


