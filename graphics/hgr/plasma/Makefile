include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	plasma_hgr.dsk

plasma_hgr.dsk:	HELLO OVAL PURPLE_WAVES ZEBRA JAWS TWIST OVAL_FLIP MOVING \
		MIRROR THICK_SINE THICK_LINES CIRCLE
	cp $(EMPTYDISK) plasma_hgr.dsk
	$(DOS33) -y plasma_hgr.dsk SAVE A HELLO
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0x3F5 THICK_SINE
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0x3F5 THICK_LINES
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0x3F5 CIRCLE
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0xc00 OVAL
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0xc00 PURPLE_WAVES
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0xc00 ZEBRA
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0xc00 JAWS
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0xc00 TWIST
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0x3F5 OVAL_FLIP
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0x3F5 MOVING
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0x3F5 MIRROR

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

OVAL:	oval.o
	ld65 -o OVAL oval.o -C $(LINKERSCRIPTS)/apple2_c00.inc

oval.o:	oval.s
	ca65 -o oval.o oval.s -l oval.lst

###

OVAL_FLIP:	oval_flip.o
	ld65 -o OVAL_FLIP oval_flip.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

oval_flip.o:	oval_flip.s
	ca65 -o oval_flip.o oval_flip.s -l oval_flip.lst

###

THICK_SINE:	thick_sine.o
	ld65 -o THICK_SINE thick_sine.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

thick_sine.o:	thick_sine.s
	ca65 -o thick_sine.o thick_sine.s -l thick_sine.lst

###

CIRCLE:	circle.o
	ld65 -o CIRCLE circle.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

circle.o:	circle.s
	ca65 -o circle.o circle.s -l circle.lst


###

THICK_LINES:	thick_lines.o
	ld65 -o THICK_LINES thick_lines.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

thick_lines.o:	thick_lines.s
	ca65 -o thick_lines.o thick_lines.s -l thick_lines.lst

###

MOVING:	moving.o
	ld65 -o MOVING moving.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

moving.o:	moving.s
	ca65 -o moving.o moving.s -l moving.lst

###

MIRROR:	mirror.o
	ld65 -o MIRROR mirror.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

mirror.o:	mirror.s
	ca65 -o mirror.o mirror.s -l mirror.lst



###

JAWS:	jaws.o
	ld65 -o JAWS jaws.o -C $(LINKERSCRIPTS)/apple2_c00.inc

jaws.o:	jaws.s
	ca65 -o jaws.o jaws.s -l jaws.lst


###

TWIST:	twist.o
	ld65 -o TWIST twist.o -C $(LINKERSCRIPTS)/apple2_c00.inc

twist.o:	twist.s
	ca65 -o twist.o twist.s -l twist.lst


###

ZEBRA:	zebra.o
	ld65 -o ZEBRA zebra.o -C $(LINKERSCRIPTS)/apple2_c00.inc

zebra.o:	zebra.s
	ca65 -o zebra.o zebra.s -l zebra.lst

###

PURPLE_WAVES:	purple_waves.o
	ld65 -o PURPLE_WAVES purple_waves.o -C $(LINKERSCRIPTS)/apple2_c00.inc

purple_waves.o:	purple_waves.s
	ca65 -o purple_waves.o purple_waves.s -l purple_waves.lst

###

clean:	
	rm -f *~ *.o *.lst OVAL PURPLE_WAVES ZEBRA JAWS TWIST OVAL_FLIP \
			THICK_SINE THICK_LINES CIRCLE

