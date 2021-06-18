include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	circles.dsk

circles.dsk:	HELLO CIRCLES CIRCLES_FILL ARCS WEB PAC ROSE \
		BRES.BAS BRESBOT.BAS BRESCOOL.BAS \
		MID.BAS MIDBOT.BAS MIDCOOL.BAS BRESTEST.BAS
	cp $(EMPTY_DISK)/empty.dsk circles.dsk
	$(DOS33) -y circles.dsk SAVE A HELLO
	$(DOS33) -y circles.dsk SAVE A BRES.BAS
	$(DOS33) -y circles.dsk SAVE A BRESBOT.BAS
	$(DOS33) -y circles.dsk SAVE A BRESCOOL.BAS
	$(DOS33) -y circles.dsk SAVE A MID.BAS
	$(DOS33) -y circles.dsk SAVE A MIDBOT.BAS
	$(DOS33) -y circles.dsk SAVE A MIDCOOL.BAS
	$(DOS33) -y circles.dsk SAVE A BRESTEST.BAS
	$(DOS33) -y circles.dsk BSAVE -a 0x0C00 CIRCLES
	$(DOS33) -y circles.dsk BSAVE -a 0x0C00 CIRCLES_FILL
	$(DOS33) -y circles.dsk BSAVE -a 0x0C00 ARCS
	$(DOS33) -y circles.dsk BSAVE -a 0x0C00 WEB
	$(DOS33) -y circles.dsk BSAVE -a 0x0C00 PAC
	$(DOS33) -y circles.dsk BSAVE -a 0x0C00 ROSE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BRES.BAS:	bres.bas
	$(TOKENIZE) < bres.bas > BRES.BAS

###

MID.BAS:	mid.bas
	$(TOKENIZE) < mid.bas > MID.BAS

###

MIDBOT.BAS:	midbot.bas
	$(TOKENIZE) < midbot.bas > MIDBOT.BAS

###

MIDCOOL.BAS:	midcool.bas
	$(TOKENIZE) < midcool.bas > MIDCOOL.BAS


###

BRESBOT.BAS:	bresbot.bas
	$(TOKENIZE) < bresbot.bas > BRESBOT.BAS

###

BRESCOOL.BAS:	brescool.bas
	$(TOKENIZE) < brescool.bas > BRESCOOL.BAS

###

BRESTEST.BAS:	brestest.bas
	$(TOKENIZE) < brestest.bas > BRESTEST.BAS


###

CIRCLES:	circles.o
	ld65 -o CIRCLES circles.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

circles.o:	circles.s
	ca65 -o circles.o circles.s -l circles.lst

###

CIRCLES_FILL:	circles_fill.o
	ld65 -o CIRCLES_FILL circles_fill.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

circles_fill.o:	circles_fill.s
	ca65 -o circles_fill.o circles_fill.s -l circles_fill.lst


#

ARCS:	arcs.o
	ld65 -o ARCS arcs.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

arcs.o:	arcs.s
	ca65 -o arcs.o arcs.s -l arcs.lst

#

WEB:	web.o
	ld65 -o WEB web.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

web.o:	web.s
	ca65 -o web.o web.s -l web.lst

#

PAC:	pac.o
	ld65 -o PAC pac.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

pac.o:	pac.s
	ca65 -o pac.o pac.s -l pac.lst

#

ROSE:	rose.o
	ld65 -o ROSE rose.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

rose.o:	rose.s
	ca65 -o rose.o rose.s -l rose.lst




###

clean:	
	rm -f *~ *.o *.lst CIRCLES ARCS WEB CIRCLES_FILL PAC ROSE \
		BRES.BAS BRESBOT.BAS BRESCOOL.BAS BRESTEST.BAS \
		MID.BAS MIDBOT.BAS MIDCOOL.BAS
