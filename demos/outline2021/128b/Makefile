include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk/empty.dsk

all:	xdraw.dsk xdraw128.dsk

submit:	xdraw128_submit.zip

xdraw128_submit.zip:	XDRAW128 xdraw128.s file_id.diz xdraw128.dsk
	mkdir -p outline2021_xdraw128
	cp XDRAW128 ./outline2021_xdraw128
	cp xdraw128.s ./outline2021_xdraw128
	cp file_id.diz ./outline2021_xdraw128
	cp xdraw128.dsk ./outline2021_xdraw128
	zip -r xdraw128.zip outline2021_xdraw128
	mkdir -p outline2021_xdraw128_submit
	cp xdraw128_720p.mp4 ./outline2021_xdraw128_submit
	cp xdraw128.zip ./outline2021_xdraw128_submit
	zip -r xdraw128_submit.zip outline2021_xdraw128_submit

xdraw.dsk:	HELLO TINY_XDRAW TINY_COOL SPIN.BAS XDRAW128
	cp $(EMPTY_DISK) xdraw.dsk
	$(DOS33) -y xdraw.dsk SAVE A HELLO
	$(DOS33) -y xdraw.dsk SAVE A SPIN.BAS
	$(DOS33) -y xdraw.dsk BSAVE -a 0xC00 TINY_XDRAW
	$(DOS33) -y xdraw.dsk BSAVE -a 0xC00 TINY_COOL
	$(DOS33) -y xdraw.dsk BSAVE -a 0xC00 XDRAW128

xdraw128.dsk:	HELLO_COMPO XDRAW128
	cp $(EMPTY_DISK) xdraw128.dsk
	$(DOS33) -y xdraw128.dsk SAVE A HELLO_COMPO HELLO
	$(DOS33) -y xdraw128.dsk BSAVE -a 0xC00 XDRAW128
	$(DOS33) -y -x xdraw128.dsk SAVE T HELLO "***         ***"
	$(DOS33) -y -x xdraw128.dsk SAVE T HELLO "  ***     ***"
	$(DOS33) -y -x xdraw128.dsk SAVE T HELLO "    *** ***"
	$(DOS33) -y -x xdraw128.dsk SAVE T HELLO "      ***"
	$(DOS33) -y -x xdraw128.dsk SAVE T HELLO "   *** ***"
	$(DOS33) -y -x xdraw128.dsk SAVE T HELLO " ***     ***"
	$(DOS33) -y -x xdraw128.dsk SAVE T HELLO "***        ***"
	$(DOS33) -y -x xdraw128.dsk SAVE I HELLO "XDRAW XTRAVAGANZA"
	$(DOS33) -y -x xdraw128.dsk SAVE I HELLO "/----------------\\"
	$(DOS33) -y -x xdraw128.dsk SAVE I HELLO "  128 BYTE DEMO"
	$(DOS33) -y -x xdraw128.dsk SAVE I HELLO "  OUTLINE 2021"
	$(DOS33) -y -x xdraw128.dsk SAVE I HELLO "\================/"
	$(DOS33) -y -x xdraw128.dsk SAVE I HELLO "  DEATER / DSR"


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

HELLO_COMPO:	hello_compo.bas
	$(TOKENIZE) < hello_compo.bas > HELLO_COMPO


###

SPIN.BAS:	spin.bas
	$(TOKENIZE) < spin.bas > SPIN.BAS


###

TINY_XDRAW:	tiny_xdraw.o
	ld65 -o TINY_XDRAW tiny_xdraw.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

tiny_xdraw.o:	tiny_xdraw.s
	ca65 -o tiny_xdraw.o tiny_xdraw.s -l tiny_xdraw.lst


###

TINY_COOL:	tiny_cool.o
#	ld65 -o TINY_COOL tiny_cool.o -C apple2_e7_zp.inc
	ld65 -o TINY_COOL tiny_cool.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

tiny_cool.o:	tiny_cool.s
	ca65 -o tiny_cool.o tiny_cool.s -l tiny_cool.lst

###

XDRAW128:	xdraw128.o
	ld65 -o XDRAW128 xdraw128.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

xdraw128.o:	xdraw128.s
	ca65 -o xdraw128.o xdraw128.s -l xdraw128.lst



###

clean:	
	rm -f *~ *.o *.lst HELLO TINY_XDRAW TINY_COOL XDRAW128

