#!/bin/sh

echo "Testing dos33 Rename..."

cp empty.dsk test.dsk

../dos33 ./test.dsk catalog

../dos33 ./test.dsk save b TB_6502
../dos33 ./test.dsk save a SINCOS
../dos33 ./test.dsk save i test.int
../dos33 ./test.dsk save b LL_6502

../dos33 ./test.dsk catalog

../dos33 ./test.dsk rename TB_6502 "tom bombem"
../dos33 ./test.dsk rename test.int "Integer Basic Test"

../dos33 ./test.dsk catalog

../dos33 ./test.dsk rename "tom bombem" "tb1"

../dos33 ./test.dsk catalog

../dos33 ./test.dsk load "tb1" "tb1.out"

diff TB_6502 tb1.out
