include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	sines.dsk

sines.dsk:	HELLO APPROX_SINE THICK_SINE THICK_COS TABLE_SINE ROM_SINE \
	OOPS_COS OOPS2_COS OOPS3_COS OOPS4_COS ROTATE THICK
	cp $(EMPTYDISK) sines.dsk
	$(DOS33) -y sines.dsk SAVE A HELLO
	$(DOS33) -y sines.dsk BSAVE -a 0xc00 APPROX_SINE
	$(DOS33) -y sines.dsk BSAVE -a 0xc00 TABLE_SINE
	$(DOS33) -y sines.dsk BSAVE -a 0xc00 ROM_SINE
	$(DOS33) -y sines.dsk BSAVE -a 0xc00 THICK_SINE
	$(DOS33) -y sines.dsk BSAVE -a 0xc00 THICK_COS
	$(DOS33) -y sines.dsk BSAVE -a 0x3f5 OOPS_COS
	$(DOS33) -y sines.dsk BSAVE -a 0xc00 OOPS2_COS
	$(DOS33) -y sines.dsk BSAVE -a 0x3f5 OOPS3_COS
	$(DOS33) -y sines.dsk BSAVE -a 0x3f5 OOPS4_COS
	$(DOS33) -y sines.dsk BSAVE -a 0x3f5 ROTATE
	$(DOS33) -y sines.dsk BSAVE -a 0xc00 THICK

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

APPROX_SINE:	approx_sine.o
	ld65 -o APPROX_SINE approx_sine.o -C $(LINKERSCRIPTS)/apple2_c00.inc

approx_sine.o:	approx_sine.s
	ca65 -o approx_sine.o approx_sine.s -l approx_sine.lst

###

THICK_SINE:	thick_sine.o
	ld65 -o THICK_SINE thick_sine.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thick_sine.o:	thick_sine.s
	ca65 -o thick_sine.o thick_sine.s -l thick_sine.lst

###

THICK_COS:	thick_cos.o
	ld65 -o THICK_COS thick_cos.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thick_cos.o:	thick_cos.s
	ca65 -o thick_cos.o thick_cos.s -l thick_cos.lst


###

THICK:	thick.o
	ld65 -o THICK thick.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thick.o:	thick.s
	ca65 -o thick.o thick.s -l thick.lst

###

OOPS_COS:	oops_cos.o
	ld65 -o OOPS_COS oops_cos.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

oops_cos.o:	oops_cos.s
	ca65 -o oops_cos.o oops_cos.s -l oops_cos.lst


###

OOPS2_COS:	oops2_cos.o
	ld65 -o OOPS2_COS oops2_cos.o -C $(LINKERSCRIPTS)/apple2_c00.inc

oops2_cos.o:	oops2_cos.s
	ca65 -o oops2_cos.o oops2_cos.s -l oops2_cos.lst

###

OOPS3_COS:	oops3_cos.o
	ld65 -o OOPS3_COS oops3_cos.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

oops3_cos.o:	oops3_cos.s
	ca65 -o oops3_cos.o oops3_cos.s -l oops3_cos.lst

###

OOPS4_COS:	oops4_cos.o
	ld65 -o OOPS4_COS oops4_cos.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

oops4_cos.o:	oops4_cos.s
	ca65 -o oops4_cos.o oops4_cos.s -l oops4_cos.lst

###

ROTATE:	rotate.o
	ld65 -o ROTATE rotate.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

rotate.o:	rotate.s
	ca65 -o rotate.o rotate.s -l rotate.lst

###

TABLE_SINE:	table_sine.o
	ld65 -o TABLE_SINE table_sine.o -C $(LINKERSCRIPTS)/apple2_c00.inc

table_sine.o:	table_sine.s
	ca65 -o table_sine.o table_sine.s -l table_sine.lst

###

ROM_SINE:	rom_sine.o
	ld65 -o ROM_SINE rom_sine.o -C $(LINKERSCRIPTS)/apple2_c00.inc

rom_sine.o:	rom_sine.s
	ca65 -o rom_sine.o rom_sine.s -l rom_sine.lst

###

clean:	
	rm -f *~ *.o *.lst THICK_SINE THICK_COS THICK \
		TABLE_SINE ROM_SINE APPROX_SINE \
		OOPS_COS OOPS2_COS OOPS3_COS OOPS4_COS ROTATE

