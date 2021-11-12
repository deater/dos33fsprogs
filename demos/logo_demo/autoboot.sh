#!/bin/sh

#/usr/bin/printf '\x41'

# patch out the wait for keypress
/usr/bin/printf '\xa9\x0d' | dd of=logo_demo.dsk bs=1 seek=9873 count=2 conv=notrunc
# patch out the ??
#/usr/bin/printf '\xea\xea\xea' | dd of=logo_demo.dsk bs=1 seek=9905 count=3 conv=notrunc

