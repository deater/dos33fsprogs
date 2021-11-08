include ../../Makefile.inc

PRODOS = ../../utils/prodos-utils/prodos
TEXT_TO_PRODOS = ../../utils/prodos-utils/text_to_prodos
EMPTY_DISK = ../../empty_disk/empty.po
HGR2PNG = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts

all:	logo_demo.dsk

logo_demo.dsk:	LOGO3 MUSIC DEMO
	cp ../../logo/dsks/apple_logo_ii.dsk ./logo_demo.dsk
	$(PRODOS) -y logo_demo.dsk -t BIN -a 0x2000 SAVE LOGO3
	$(PRODOS) -y logo_demo.dsk DELETE FORMAT
	$(PRODOS) -y logo_demo.dsk DELETE FORMAT.BIN
	$(PRODOS) -y logo_demo.dsk DELETE FORMAT.HELP
#	$(PRODOS) -y logo_demo.dsk DELETE SAMPLES/MENU
#	$(PRODOS) -y logo_demo.dsk DELETE SAMPLES/MENU.DATA
#	$(PRODOS) -y logo_demo.dsk DELETE SAMPLES/MENU.DOC
#	$(PRODOS) -y logo_demo.dsk DELETE SAMPLES/POLYSPI.PLUS
#	$(PRODOS) -y logo_demo.dsk DELETE SAMPLES/ADV.GRAPHICS
#	$(PRODOS) -y logo_demo.dsk DELETE SAMPLES/MEMORY
#	$(PRODOS) -y logo_demo.dsk DELETE SAMPLES/MEMORY.DOC
#	$(PRODOS) -y logo_demo.dsk DELETE SAMPLES/LOGO.SINGS
	$(PRODOS) -y logo_demo.dsk -t BIN -a 0x4C00 SAVE MUSIC
	$(PRODOS) -y logo_demo.dsk -t BIN -a 0x2000 SAVE ./music/mA2E_-_Apple_2_for_Demosplash_2021.pt3 MA2E.PT3
	$(PRODOS) -y logo_demo.dsk SAVE -t TXT DEMO


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
	rm -f *~ *.o *.lst LOGO3 MUSIC DEMO

