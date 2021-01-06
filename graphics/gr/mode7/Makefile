include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	mode7.dsk background

$(DOS33):	
	cd ../../../utils/dos33fs-utils && make

mode7.dsk:	$(DOS33) MODE7_ISLAND MODE7_CHECKERBOARD MODE7_RAINBOW \
			PLOT_TEST RASTERBARS SKY_DEMO TEXT_DEMO
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 MODE7_ISLAND
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 MODE7_CHECKERBOARD
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 MODE7_RAINBOW
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 PLOT_TEST
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 RASTERBARS
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 SKY_DEMO
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 TEXT_DEMO



###

MODE7_ISLAND:	mode7_island.o
	ld65 -o MODE7_ISLAND mode7_island.o -C ./apple2_1000.inc

mode7_island.o:	mode7.s island_lookup.s island_map.inc \
	zp.inc sprites.inc \
	gr_hlin.s \
	multiply_fast.s \
	gr_fast_clear.s \
	pageflip.s \
	gr_setpage.s \
	keypress.s \
	gr_putsprite.s \
	text_print.s
	ca65 -o mode7_island.o mode7.s -D ISLAND_MAP=1 -l mode7.lst

MODE7_CHECKERBOARD:	mode7_checkerboard.o
	ld65 -o MODE7_CHECKERBOARD mode7_checkerboard.o -C ./apple2_1000.inc

mode7_checkerboard.o:	mode7.s checkerboard_lookup.s \
	zp.inc sprites.inc \
	gr_hlin.s \
	multiply_fast.s \
	gr_fast_clear.s \
	pageflip.s \
	gr_setpage.s \
	keypress.s \
	gr_putsprite.s \
	text_print.s \
	gr_scroll.s \
	bg_scroll.s
	ca65 -o mode7_checkerboard.o mode7.s -D CHECKERBOARD_MAP=1 -l mode7.lst

MODE7_RAINBOW:	mode7_rainbow.o
	ld65 -o MODE7_RAINBOW mode7_rainbow.o -C ./apple2_1000.inc

mode7_rainbow.o:	mode7.s rainbow_lookup.s \
	zp.inc sprites.inc \
	multiply_fast.s \
	gr_fast_clear.s \
	gr_hlin.s \
	pageflip.s \
	gr_setpage.s \
	keypress.s \
	gr_putsprite.s \
	text_print.s
	ca65 -o mode7_rainbow.o mode7.s -D RAINBOW_MAP=1 -l mode7.lst

PLOT_TEST:	plot_test.o
	ld65 -o PLOT_TEST plot_test.o -C ./apple2_1000.inc

plot_test.o:	plot_test.s \
	gr_setpage.s
	ca65 -o plot_test.o plot_test.s -l plot_test.lst

SKY_DEMO:	sky_demo.o
	ld65 -o SKY_DEMO sky_demo.o -C ./apple2_1000.inc

sky_demo.o:	sky_demo.s \
	starry_sky.scroll \
	gr_hlin.s \
	gr_fast_clear.s \
	gr_scroll.s \
	pageflip.s \
	gr_setpage.s
	ca65 -o sky_demo.o sky_demo.s -l sky_demo.lst

RASTERBARS:	rasterbars.o
	ld65 -o RASTERBARS rasterbars.o -C ./apple2_1000.inc

rasterbars.o:	rasterbars.s \
	gr_scroll.s \
	pageflip.s \
	gr_setpage.s \
	gr_fast_clear.s
	ca65 -o rasterbars.o rasterbars.s -l rasterbars.lst

TEXT_DEMO:	text_demo.o
	ld65 -o TEXT_DEMO text_demo.o -C ./apple2_1000.inc

text_demo.o:	text_demo.s \
	gr_scroll.s \
	pageflip.s \
	gr_setpage.s \
	gr_fast_clear.s
	ca65 -o text_demo.o text_demo.s -l text_demo.lst

scroller:	scroller.o
	$(CC) $(LFLAGS) -o scroller scroller.o

scroller.o:	scroller.c
	$(CC) $(CFLAGS) -c scroller.c

background:	background.o
	$(CC) $(LFLAGS) -o background background.o

background.o:	background.c
	$(CC) $(CFLAGS) -c background.c

clean:	
	rm -f *~ *.o scroller background \
	MODE7 MODE7_ISLAND MODE7_CHECKERBOARD MODE7_RAINBOW \
	PLOT_TEST RASTERBARS SKY_DEMO TEXT_DEMO *.lst

