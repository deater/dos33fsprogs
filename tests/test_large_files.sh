#!/bin/sh

echo "Testing large files..."

cp empty.dsk test.dsk

dd if=/dev/urandom of=blah.out bs=1k count=116

../dos33 ./test.dsk catalog

../dos33 ./test.dsk save r blah.out big.1
../dos33 ./test.dsk save r blah.out big.2

../dos33 ./test.dsk load big.1 blah2.out

diff blah.out blah2.out

../dos33 ./test.dsk catalog
