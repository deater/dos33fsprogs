#!/bin/sh

echo "Testing dos33..."

cp empty.dsk test.dsk

../dos33 ./test.dsk catalog

../dos33 ./test.dsk save a SINCOS SINCOS
../dos33 ./test.dsk save t YOU.LOGO
../dos33 ./test.dsk save b LL_6502
../dos33 ./test.dsk save b TB_6502

../dos33 ./test.dsk catalog

../dos33 ./test.dsk load SINCOS sincos.out
../dos33 ./test.dsk load YOU.LOGO you.logo.out
../dos33 ./test.dsk load LL_6502 ll_6502.out
../dos33 ./test.dsk load TB_6502 tb_6502.out

diff SINCOS sincos.out
diff YOU.LOGO you.logo.out
diff LL_6502 ll_6502.out
diff TB_6502 tb_6502.out
