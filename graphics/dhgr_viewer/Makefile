include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
B2D = ../../utils/bmp2dhr/b2d
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_RLE = ../../utils/gr-utils/png2rle
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	make_dhgr_viewer


###

make_dhgr_viewer:	make_dhgr_viewer.o
	$(CC) $(LFLAGS) -o make_dhgr_viewer make_dhgr_viewer.o

make_dhgr_viewer.o:	make_dhgr_viewer.c
	$(CC) $(CFLAGS) -c make_dhgr_viewer.c

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###


clean:
		rm -f *~ *.o *.lst HELLO make_dhgr_viewer

