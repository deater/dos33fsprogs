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
	$(DOS33) -y -x tiny_32.dsk SAVE A HELLO "�十十十十十十十十十�"
	$(DOS33) -y -x tiny_32.dsk SAVE T HELLO "� TINY TRIANGLES �"
	$(DOS33) -y -x tiny_32.dsk SAVE A HELLO "� BY DEATER    �"
	$(DOS33) -y -x tiny_32.dsk SAVE B HELLO "� 28 BYTES   �"
	$(DOS33) -y -x tiny_32.dsk SAVE A HELLO "� --dSr--  �"
	$(DOS33) -y -x tiny_32.dsk SAVE T HELLO "�        �"
	$(DOS33) -y -x tiny_32.dsk SAVE A HELLO "� 2021 �"
	$(DOS33) -y -x tiny_32.dsk SAVE B HELLO "�    �"
	$(DOS33) -y -x tiny_32.dsk SAVE A HELLO "�  �"
	$(DOS33) -y -x tiny_32.dsk SAVE T HELLO "砂"
	$(DOS33) -y -x tiny_32.dsk SAVE A HELLO "�"

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
