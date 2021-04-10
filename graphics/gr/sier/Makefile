include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk/empty.dsk

all:	sier.dsk

sier.dsk:	HELLO SIER SIER_BOT SIER_TINY SIER_64 MOD9 XOR_ZOOM MOD9_ZOOM
	cp $(EMPTY_DISK) sier.dsk
	$(DOS33) -y sier.dsk SAVE A HELLO
	$(DOS33) -y sier.dsk BSAVE -a 0x60 SIER
	$(DOS33) -y sier.dsk BSAVE -a 0x36C SIER_BOT
	$(DOS33) -y sier.dsk BSAVE -a 0x300 SIER_TINY
	$(DOS33) -y sier.dsk BSAVE -a 0x300 SIER_64
	$(DOS33) -y sier.dsk BSAVE -a 0x375 MOD9
	$(DOS33) -y sier.dsk BSAVE -a 0x37C XOR_ZOOM
	$(DOS33) -y sier.dsk BSAVE -a 0x300 MOD9_ZOOM

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MOD9:	mod9.o
	ld65 -o MOD9 mod9.o -C ./apple2_375.inc

mod9.o:	mod9.s
	ca65 -o mod9.o mod9.s -l mod9.lst

###

SIER:	sier.o
	ld65 -o SIER sier.o -C ./apple2_60_zp.inc

sier.o:	sier.s
	ca65 -o sier.o sier.s -l sier.lst

###

XOR_ZOOM:	xor_zoom.o
	ld65 -o XOR_ZOOM xor_zoom.o -C ./apple2_37c.inc

xor_zoom.o:	xor_zoom.s
	ca65 -o xor_zoom.o xor_zoom.s -l xor_zoom.lst

###

MOD9_ZOOM:	mod9_zoom.o
	ld65 -o MOD9_ZOOM mod9_zoom.o -C $(LINKERSCRIPTS)/apple2_300.inc

mod9_zoom.o:	mod9_zoom.s
	ca65 -o mod9_zoom.o mod9_zoom.s -l mod9_zoom.lst


###

SIER_BOT:	sier_bot.o
	ld65 -o SIER_BOT sier_bot.o -C ./apple2_36c.inc

sier_bot.o:	sier_bot.s
	ca65 -o sier_bot.o sier_bot.s -l sier_bot.lst


###

SIER_TINY:	sier_tiny.o
	ld65 -o SIER_TINY sier_tiny.o -C $(LINKERSCRIPTS)/apple2_300.inc

sier_tiny.o:	sier_tiny.s
	ca65 -o sier_tiny.o sier_tiny.s -l sier_tiny.lst

###

SIER_64:	sier_64.o
	ld65 -o SIER_64 sier_64.o -C $(LINKERSCRIPTS)/apple2_300.inc

sier_64.o:	sier_64.s
	ca65 -o sier_64.o sier_64.s -l sier_64.lst



###

clean:	
	rm -f *~ *.o *.lst HELLO SIER SIER_TINY SIER_64 MOD9 XOR_ZOOM MOD9_ZOOM SIER_BOT
