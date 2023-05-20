include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../linker_scripts/

all:	midline.dsk

midline.dsk:	HELLO MIDLINE
	cp $(EMPTYDISK) midline.dsk
	$(DOS33) -y midline.dsk SAVE A HELLO
	$(DOS33) -y midline.dsk BSAVE -a 0x6000 MIDLINE

###

submit:	midline.zip midline_small.zip

midline.zip:	MIDLINE midline.s file_id.diz midline.dsk
	mkdir -p outline2023_midline
	cp MIDLINE ./outline2023_midline
	cp midline.s ./outline2023_midline
	cp sinetable.s ./outline2023_midline
	cp hardware.inc ./outline2023_midline
	cp zp.inc ./outline2023_midline
	cp file_id.diz ./outline2023_midline
	cp midline.dsk ./outline2023_midline
	cp midline_720p.mp4 ./outline2023_midline
	cp midline_screen.png ./outline2023_midline
	zip -r midline.zip outline2023_midline

###

midline_small.zip:	MIDLINE midline.s file_id.diz midline.dsk
	mkdir -p outline2023_midline_small
	cp MIDLINE ./outline2023_midline_small
	cp midline.s ./outline2023_midline_small
	cp sinetable.s ./outline2023_midline_small
	cp hardware.inc ./outline2023_midline_small
	cp zp.inc ./outline2023_midline_small
	cp file_id.diz ./outline2023_midline_small
	cp midline.dsk ./outline2023_midline_small
	zip -r midline_small.zip outline2023_midline_small

###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MIDLINE:	midline.o
	ld65 -o MIDLINE midline.o -C $(LINKERSCRIPTS)/apple2_6000.inc

midline.o:	midline.s sinetable.s zp.inc hardware.inc
	ca65 -o midline.o midline.s -l midline.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO MIDLINE *.zip
