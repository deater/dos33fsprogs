include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

LINKERSCRIPTS = ../../../linker_scripts

all:	xdraw.dsk

xdraw.dsk:	HELLO TINY_XDRAW TINY_COOL TINY_LINES TINY_CENTER NYAN XDRAW_TEST SHIMMER SHIMMER_BOT ENTROPY_TEXT ENTROPY_TEXTBOT
	cp $(EMPTYDISK) xdraw.dsk
	$(DOS33) -y xdraw.dsk SAVE A HELLO
	$(DOS33) -y xdraw.dsk BSAVE -a 0xE7 TINY_XDRAW
	$(DOS33) -y xdraw.dsk BSAVE -a 0xE7 TINY_COOL
	$(DOS33) -y xdraw.dsk BSAVE -a 0xE7 TINY_LINES
	$(DOS33) -y xdraw.dsk BSAVE -a 0xE7 TINY_CENTER
	$(DOS33) -y xdraw.dsk BSAVE -a 0xC00 NYAN
	$(DOS33) -y xdraw.dsk BSAVE -a 0xE7 XDRAW_TEST
	$(DOS33) -y xdraw.dsk BSAVE -a 0xC00 SHIMMER
	$(DOS33) -y xdraw.dsk BSAVE -a 0x3f5 SHIMMER_BOT
	$(DOS33) -y xdraw.dsk BSAVE -a 0x3f5 ENTROPY_TEXT
	$(DOS33) -y xdraw.dsk BSAVE -a 0x3f5 ENTROPY_TEXTBOT

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


###

XDRAW_TEST:	xdraw_test.o
	ld65 -o XDRAW_TEST xdraw_test.o -C ./apple2_e7_zp.inc

xdraw_test.o:	xdraw_test.s
	ca65 -o xdraw_test.o xdraw_test.s -l xdraw_test.lst

###

TINY_XDRAW:	tiny_xdraw.o
	ld65 -o TINY_XDRAW tiny_xdraw.o -C ./apple2_e7_zp.inc

tiny_xdraw.o:	tiny_xdraw.s
	ca65 -o tiny_xdraw.o tiny_xdraw.s -l tiny_xdraw.lst

###

TINY_COOL:	tiny_cool.o
	ld65 -o TINY_COOL tiny_cool.o -C ./apple2_e7_zp.inc

tiny_cool.o:	tiny_cool.s
	ca65 -o tiny_cool.o tiny_cool.s -l tiny_cool.lst


###

TINY_CENTER:	tiny_center.o
	ld65 -o TINY_CENTER tiny_center.o -C ./apple2_e7_zp.inc

tiny_center.o:	tiny_center.s
	ca65 -o tiny_center.o tiny_center.s -l tiny_center.lst

###

TINY_LINES:	tiny_lines.o
	ld65 -o TINY_LINES tiny_lines.o -C ./apple2_e7_zp.inc

tiny_lines.o:	tiny_lines.s
	ca65 -o tiny_lines.o tiny_lines.s -l tiny_lines.lst


###

NYAN:	nyan.o
	ld65 -o NYAN nyan.o -C $(LINKERSCRIPTS)/apple2_c00.inc

nyan.o:	nyan.s
	ca65 -o nyan.o nyan.s -l nyan.lst

###

SHIMMER:	shimmer.o
	ld65 -o SHIMMER shimmer.o -C $(LINKERSCRIPTS)/apple2_c00.inc

shimmer.o:	shimmer.s
	ca65 -o shimmer.o shimmer.s -l shimmer.lst

###

SHIMMER_BOT:	shimmer_bot.o
	ld65 -o SHIMMER_BOT shimmer_bot.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

shimmer_bot.o:	shimmer_bot.s
	ca65 -o shimmer_bot.o shimmer_bot.s -l shimmer_bot.lst

###

ENTROPY_TEXT:	entropy_text.o
	ld65 -o ENTROPY_TEXT entropy_text.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

entropy_text.o:	entropy_text.s
	ca65 -o entropy_text.o entropy_text.s -l entropy_text.lst

###

ENTROPY_TEXTBOT:	entropy_textbot.o
	ld65 -o ENTROPY_TEXTBOT entropy_textbot.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

entropy_textbot.o:	entropy_textbot.s
	ca65 -o entropy_textbot.o entropy_textbot.s -l entropy_textbot.lst






####

clean:	
	rm -f *~ *.o *.lst HELLO TINY_COOL TINY_XDRAW TINY_LINES TINY_CENTER NYAN XDRAW_TEST SHIMMER ENTROPY_TEXT ENTROPY_TEXTBOT
