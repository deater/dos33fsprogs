include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk/empty.dsk

all:	tiny_32.dsk

tiny_32.dsk:	HELLO TINY_TRIANGLES
	cp $(EMPTY_DISK) tiny_32.dsk
	$(DOS33) -y tiny_32.dsk SAVE A HELLO
	$(DOS33) -y tiny_32.dsk BSAVE -a 0x070 TINY_TRIANGLES
	$(DOS33) -y -x tiny_32.dsk SAVE A HELLO "¯½½½½½½½½½½½½½½½½½½½"
	$(DOS33) -y -x tiny_32.dsk SAVE T HELLO "Ì TINY TRIANGLES ½"
	$(DOS33) -y -x tiny_32.dsk SAVE A HELLO "Ï BY DEATER    ½"
	$(DOS33) -y -x tiny_32.dsk SAVE B HELLO "Ö 28 BYTES   ½"
	$(DOS33) -y -x tiny_32.dsk SAVE A HELLO "Å --dSr--  ½"
	$(DOS33) -y -x tiny_32.dsk SAVE T HELLO "Â        ½"
	$(DOS33) -y -x tiny_32.dsk SAVE A HELLO "Ù 2021 ½"
	$(DOS33) -y -x tiny_32.dsk SAVE B HELLO "Ô    ½"
	$(DOS33) -y -x tiny_32.dsk SAVE A HELLO "Å  ½"
	$(DOS33) -y -x tiny_32.dsk SAVE T HELLO "º½"
	$(DOS33) -y -x tiny_32.dsk SAVE A HELLO "¯"

###

submit:	tiny32.zip

tiny32.zip: TINY_TRIANGLES tiny_triangles.s file_id.diz tiny_32.dsk
	mkdir -p lovebyte2021_tiny32
	cp TINY_TRIANGLES ./lovebyte2021_tiny32
	cp tiny_triangles.s ./lovebyte2021_tiny32
	cp file_id.diz ./lovebyte2021_tiny32
	cp tiny_32.dsk ./lovebyte2021_tiny32
	cp tiny_triangles_720p.mp4 ./lovebyte2021_tiny32
	zip -r tiny32.zip lovebyte2021_tiny32

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TINY_TRIANGLES:	tiny.o
	ld65 -o TINY_TRIANGLES tiny.o -C $(LINKER_SCRIPTS)/apple2_70_zp.inc

tiny.o:	tiny_triangles.s
	ca65 -o tiny.o tiny_triangles.s -l tiny.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO TINY_TRIANGLES *.zip
