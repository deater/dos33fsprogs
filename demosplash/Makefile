include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2RLE = ../gr-utils/png2rle
PNG2LZ4 = ../gr-utils/png2lz4
PNG_TO_40x96 = ../gr-utils/png_to_40x96


all:	demosplash.dsk

demosplash.dsk:	HELLO DEMOSPLASH
	cp empty.dsk demosplash.dsk
	$(DOS33) -y demosplash.dsk SAVE A HELLO
#	$(DOS33) -y demosplash.dsk BSAVE -a 0x1400 LOADER2 LOADER
	$(DOS33) -y demosplash.dsk BSAVE -a 0x1700 DEMOSPLASH

####


HELLO:  hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


#####

DEMOSPLASH:	demosplash.o
	ld65 -o DEMOSPLASH demosplash.o -C ../linker_scripts/apple2_1700.inc

demosplash.o:	demosplash.s \
	zp.inc hardware.inc \
	appleII_intro.s vapor_lock.s delay_a.s \
	pt3_lib.s mockingboard_a.s pt3_setup.s interrupt_handler.s \
	dya_space_demo.pt3 appleII_40_96.inc
	ca65 -o demosplash.o demosplash.s -l demosplash.lst

#####

appleII_40_96.inc:	appleII_40_96.png
	$(PNG_TO_40x96)	asm appleII_40_96.png appleII > appleII_40_96.inc


#####

clean:		
		rm -f *~ *.o *.lst *.lz4 HELLO \
			DEMOSPLASH
