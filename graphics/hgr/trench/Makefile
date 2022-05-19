include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	trench.dsk

trench.dsk:	HELLO TRENCH.BAS TRENCH_BOT.BAS XW XW.BAS
	cp $(EMPTY_DISK)/empty.dsk trench.dsk
	$(DOS33) -y trench.dsk SAVE A HELLO
	$(DOS33) -y trench.dsk SAVE A TRENCH.BAS
	$(DOS33) -y trench.dsk SAVE A TRENCH_BOT.BAS
#	$(DOS33) -y trench.dsk BSAVE -a 0x0C00 TRENCH
	$(DOS33) -y trench.dsk SAVE A XW.BAS
	$(DOS33) -y trench.dsk BSAVE -a 0x70 XW

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TRENCH.BAS:	trench.bas
	$(TOKENIZE) < trench.bas > TRENCH.BAS

###

TRENCH_BOT.BAS:	trench_bot.bas
	$(TOKENIZE) < trench_bot.bas > TRENCH_BOT.BAS


###

LINES:	lines.o
	ld65 -o LINES lines.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

lines.o:	lines.s
	ca65 -o lines.o lines.s -l lines.lst

###

LINES_ROM:	lines_rom.o
	ld65 -o LINES_ROM lines_rom.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

lines_rom.o:	lines_rom.s
	ca65 -o lines_rom.o lines_rom.s -l lines_rom.lst

###

HLIN_TEST:	hlin_test.o
	ld65 -o HLIN_TEST hlin_test.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

hlin_test.o:	hlin_test.s hgr_hlin.s
	ca65 -o hlin_test.o hlin_test.s -l hlin_test.lst

###

VLIN_TEST:	vlin_test.o
	ld65 -o VLIN_TEST vlin_test.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

vlin_test.o:	vlin_test.s hgr_vlin.s
	ca65 -o vlin_test.o vlin_test.s -l vlin_test.lst


###

XW.BAS:  xw.bas
	$(TOKENIZE) < xw.bas > XW.BAS



###

XW:	xw.o
	ld65 -o XW xw.o -C $(LINKER_SCRIPTS)/apple2_70_zp.inc

xw.o:	xw.s
	ca65 -o xw.o xw.s -l xw.lst
###


###

clean:	
	rm -f *~ *.o *.lst HELLO TRENCH.BAS XW XW.BAS
