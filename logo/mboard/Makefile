include ../../Makefile.inc

PRODOS = ../../utils/prodos-utils/prodos
TEXT_TO_PRODOS = ../../utils/prodos-utils/text_to_prodos
EMPTY_DISK = ../../empty_disk/empty.po
HGR2PNG = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts

all:	mboard_logo.dsk mboard_prodos.dsk

mboard_logo.dsk:	LOGO3 MUSIC DEMO
	cp ../dsks/apple_logo_ii.dsk ./mboard_logo.dsk
	$(PRODOS) -y mboard_logo.dsk -t BIN -a 0x2000 SAVE LOGO3
	$(PRODOS) -y mboard_logo.dsk DELETE FORMAT
	$(PRODOS) -y mboard_logo.dsk DELETE FORMAT.BIN
	$(PRODOS) -y mboard_logo.dsk DELETE FORMAT.HELP
#	$(PRODOS) -y mboard_logo.dsk DELETE SAMPLES/MENU
#	$(PRODOS) -y mboard_logo.dsk DELETE SAMPLES/MENU.DATA
#	$(PRODOS) -y mboard_logo.dsk DELETE SAMPLES/MENU.DOC
#	$(PRODOS) -y mboard_logo.dsk DELETE SAMPLES/POLYSPI.PLUS
#	$(PRODOS) -y mboard_logo.dsk DELETE SAMPLES/ADV.GRAPHICS
#	$(PRODOS) -y mboard_logo.dsk DELETE SAMPLES/MEMORY
#	$(PRODOS) -y mboard_logo.dsk DELETE SAMPLES/MEMORY.DOC
#	$(PRODOS) -y mboard_logo.dsk DELETE SAMPLES/LOGO.SINGS
	$(PRODOS) -y mboard_logo.dsk -t BIN -a 0x4C00 SAVE MUSIC
	$(PRODOS) -y mboard_logo.dsk -t BIN -a 0x2000 SAVE ./music/Fret.pt3 FRET.PT3
	$(PRODOS) -y mboard_logo.dsk SAVE -t TXT DEMO

mboard_prodos.dsk:	MUSIC
	cp ../dsks/ProDOS_2_4_2.dsk ./mboard_prodos.dsk
	$(PRODOS) -y mboard_prodos.dsk DELETE ADTPRO2.0.2.BIN
	$(PRODOS) -y mboard_prodos.dsk -t BIN -a 0x4C00 SAVE MUSIC
	$(PRODOS) -y mboard_prodos.dsk -t BIN -a 0x2000 SAVE ./music/Fret.pt3 FRET.PT3



####

LOGO3:	newlogo3.png
	$(HGR2PNG) ./newlogo3.png > LOGO3

####

MUSIC:	music.o
	ld65 -o MUSIC music.o -C $(LINKER_SCRIPTS)/apple2_4c00.inc

music.o:	music.s \
	zp.inc hardware.inc nozp.inc \
	interrupt_handler.s pt3_lib_mockingboard_setup.s
	ca65 -o music.o music.s -l music.lst

####

DEMO:	demo.logo
	$(TEXT_TO_PRODOS) < demo.logo > DEMO

####

clean:
	rm -f *~ *.o *.lst LOGO3

