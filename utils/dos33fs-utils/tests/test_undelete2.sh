#!/bin/sh

echo "Testing dos33 Undelete..."

cp empty.dsk test.dsk

../dos33 ./test.dsk catalog

../dos33 ./test.dsk save b LL_6502 L123456789012345678901234567890
../dos33 ./test.dsk save b TB_6502
../dos33 ./test.dsk save a SINCOS
../dos33 ./test.dsk save i test.int

../dos33 ./test.dsk catalog

../dos33 ./test.dsk delete L123456789012345678901234567890

../dos33 ./test.dsk catalog

../dos33 ./test.dsk undelete L123456789012345678901234567890

../dos33 ./test.dsk catalog

../dos33 ./test.dsk load L123456789012345678901234567890 ll.out

diff LL_6502 ll.out



