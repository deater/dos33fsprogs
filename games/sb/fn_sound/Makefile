include ../../../Makefile.inc

TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
DOS33 = ../../utils/dos33fs-utils/dos33
TEXT_TO_ED = ../../../utils/music/text_to_ed
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	fortnight.ed

###

fortnight.ed:	$(TEXT_TO_ED) fortnight.txt
	$(TEXT_TO_ED) -o 1 fortnight.txt fortnight


###

clean:	
	rm -f *~ *.o *.lst fortnight.ed

