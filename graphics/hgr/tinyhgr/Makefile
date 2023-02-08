include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	tiny_hgr8.dsk

tiny_hgr8.dsk:	HELLO TINY_HGR TINY_HGR2 TINY_HGR3 TINY_BLINDS
	cp $(EMPTYDISK) tiny_hgr8.dsk
	$(DOS33) -y tiny_hgr8.dsk SAVE A HELLO
	$(DOS33) -y tiny_hgr8.dsk BSAVE -a 0xB9 TINY_HGR
	$(DOS33) -y tiny_hgr8.dsk BSAVE -a 0xB9 TINY_HGR2
	$(DOS33) -y tiny_hgr8.dsk BSAVE -a 0xB9 TINY_BLINDS
	$(DOS33) -y tiny_hgr8.dsk BSAVE -a 0xB8 TINY_HGR3

###

submit:	tiny_hgr8.zip

tiny_hgr8.zip:	TINY_HGR tiny_hgr.s file_id.diz tiny_hgr8.dsk
	mkdir -p lovebyte2023_tiny_hgr8
	cp TINY_HGR ./lovebyte2023_tiny_hgr8
	cp tiny_hgr.s ./lovebyte2023_tiny_hgr8
	cp file_id.diz ./lovebyte2023_tiny_hgr8
	cp tiny_hgr8.dsk ./lovebyte2023_tiny_hgr8
	cp tiny_hgr8_720p.mp4 ./lovebyte2023_tiny_hgr8
	zip -r tiny_hgr8.zip lovebyte2023_tiny_hgr8

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TINY_HGR:	tiny_hgr.o
	ld65 -o TINY_HGR tiny_hgr.o -C ./apple2_b9.inc

tiny_hgr.o:	tiny_hgr.s
	ca65 -o tiny_hgr.o tiny_hgr.s -l tiny_hgr.lst

###

TINY_HGR2:	tiny_hgr2.o
	ld65 -o TINY_HGR2 tiny_hgr2.o -C ./apple2_b9.inc

tiny_hgr2.o:	tiny_hgr2.s
	ca65 -o tiny_hgr2.o tiny_hgr2.s -l tiny_hgr2.lst

###

TINY_BLINDS:	tiny_blinds.o
	ld65 -o TINY_BLINDS tiny_blinds.o -C ./apple2_b9.inc

tiny_blinds.o:	tiny_blinds.s
	ca65 -o tiny_blinds.o tiny_blinds.s -l tiny_blinds.lst



###

TINY_HGR3:	tiny_hgr3.o
	ld65 -o TINY_HGR3 tiny_hgr3.o -C ./apple2_b8.inc

tiny_hgr3.o:	tiny_hgr3.s
	ca65 -o tiny_hgr3.o tiny_hgr3.s -l tiny_hgr3.lst



####

clean:	
	rm -f *~ *.o *.lst HELLO TINY_HGR TINY_HGR2 TINY_HGR3 TINY_BLINDS *.zip
