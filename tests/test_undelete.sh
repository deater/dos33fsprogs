#!/bin/sh

echo "Testing dos33 Undelete..."

cp empty.dsk test.dsk

../dos33 ./test.dsk catalog

../dos33 ./test.dsk save b LL_6502
../dos33 ./test.dsk save b TB_6502
../dos33 ./test.dsk save a SINCOS
../dos33 ./test.dsk save i test.int

../dos33 ./test.dsk catalog

../dos33 ./test.dsk delete LL_6502

../dos33 ./test.dsk catalog

../dos33 ./test.dsk undelete LL_6502

../dos33 ./test.dsk catalog

../dos33 ./test.dsk load LL_6502 ll.out

diff LL_6502 ll.out



