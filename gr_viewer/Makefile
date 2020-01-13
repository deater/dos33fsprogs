include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft
PNG2DHGR = ../hgr-utils/png2dhgr

all:	gr_viewer.dsk

gr_viewer.dsk:	HELLO LOADER
	$(DOS33) -y gr_viewer.dsk SAVE A HELLO
	$(DOS33) -y gr_viewer.dsk BSAVE -a 0x1000 LOADER
#	$(DOS33) -y gr_viewer.dsk BSAVE -a 0x800 F05.GR


###

HELLO:  hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

###

LOADER:  loader.o
	ld65 -o LOADER loader.o -C ../linker_scripts/apple2_1000.inc

loader.o:	loader.s
	ca65 -o loader.o loader.s -l loader.lst

####


clean:	
	rm -f *~ *.o LOADER HELLO *.lst
