include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	hgr_font4.dsk

hgr_font4.dsk:	HELLO FONT_4AM_TEST FONT_VMW_10_TEST FONT_VMW_8_TEST
	cp $(EMPTY_DISK)/empty.dsk hgr_font4.dsk
	$(DOS33) -y hgr_font4.dsk SAVE A HELLO
	$(DOS33) -y hgr_font4.dsk BSAVE -a 0x6000 FONT_4AM_TEST
	$(DOS33) -y hgr_font4.dsk BSAVE -a 0x6000 FONT_VMW_10_TEST
	$(DOS33) -y hgr_font4.dsk BSAVE -a 0x6000 FONT_VMW_8_TEST

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

FONT_4AM_TEST:	font_4am_test.o
	ld65 -o FONT_4AM_TEST font_4am_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

font_4am_test.o:	font_4am_test.s \
	font_4am_condensed.s font_4am_condensed_data.s
	ca65 -o font_4am_test.o font_4am_test.s -l font_4am_test.lst

###

FONT_VMW_10_TEST:	font_vmw_10_test.o
	ld65 -o FONT_VMW_10_TEST font_vmw_10_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

font_vmw_10_test.o:	font_vmw_10_test.s \
	font_vmw_condensed.s font_vmw_condensed_data.s
	ca65 -o font_vmw_10_test.o font_vmw_10_test.s -l font_vmw_10_test.lst

###

FONT_VMW_8_TEST:	font_vmw_8_test.o
	ld65 -o FONT_VMW_8_TEST font_vmw_8_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

font_vmw_8_test.o:	font_vmw_8_test.s \
	font_vmw_1x8.s \
	fonts/a2_lowercase_font.inc
	ca65 -o font_vmw_8_test.o font_vmw_8_test.s -l font_vmw_8_test.lst





###

clean:	
	rm -f *~ *.o *.lst HELLO BIOS_TEST FONT_4AM_TEST FONT_VMW_10_TEST FONT_VMW_8_TEST

