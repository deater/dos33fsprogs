include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk
MAKEVGI	= ./make_vgi_asm

all:	vgi_doom.dsk make_vgi_asm

vgi_doom.dsk:	HELLO VGI-DOOM
	cp $(EMPTYDISK) vgi_doom.dsk
	$(DOS33) -y vgi_doom.dsk SAVE A HELLO
	$(DOS33) -y vgi_doom.dsk BSAVE -a 0x4000 VGI-DOOM

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

VGI-DOOM:	doom_vgi.o
	ld65 -o VGI-DOOM doom_vgi.o -C $(LINKERSCRIPTS)/apple2_4000.inc

doom_vgi.o: doom.data \
	doom_vgi.s vgi_clearscreen.s vgi_rectangle.s vgi_circles.s vgi_lines.s \
	vgi_triangles.s
	ca65 -o doom_vgi.o doom_vgi.s -l doom_vgi.lst

###

doom.data:	make_vgi_asm doom.vgi
	echo "doom_data:" > doom.data
	./make_vgi_asm < doom.vgi >> doom.data

###

make_vgi_asm:	make_vgi_asm.o
	$(CC) -o make_vgi_asm make_vgi_asm.o $(LFLAGS)

make_vgi_asm.o:	make_vgi_asm.c
	$(CC) $(CFLAGS) -c make_vgi_asm.c


###

clean:	
	rm -f *~ *.o *.lst HELLO VGI-MYST VGI-DOOM COLOR-TEST \
		make_vgi_asm make_color_test *.data
