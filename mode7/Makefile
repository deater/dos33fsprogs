include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr
PNG2RLE = ../gr-utils/png2rle

all:	mode7.dsk scroller background

$(DOS33):	
	cd ../dos33fs-utils && make

mode7.dsk:	$(DOS33) MODE7_ISLAND MODE7_CHECKERBOARD MODE7_RAINBOW \
			SCROLL_DEMO SKY_DEMO STARFIELD_DEMO
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 MODE7_ISLAND
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 MODE7_CHECKERBOARD
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 MODE7_RAINBOW
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 SCROLL_DEMO
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 SKY_DEMO
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 STARFIELD_DEMO



###

MODE7_ISLAND:	mode7_island.o
	ld65 -o MODE7_ISLAND mode7_island.o -C ./apple2_1000.inc

mode7_island.o:	mode7.s island_lookup.s island_map.inc \
	zp.inc sprites.inc \
	../asm_routines/gr_hlin.s \
	../asm_routines/multiply_fast.s \
	../asm_routines/gr_fast_clear.s \
	../asm_routines/pageflip.s \
	../asm_routines/gr_setpage.s \
	../asm_routines/keypress.s \
	../asm_routines/gr_putsprite.s \
	../asm_routines/text_print.s
	ca65 -o mode7_island.o mode7.s -D ISLAND_MAP=1 -l mode7.lst

MODE7_CHECKERBOARD:	mode7_checkerboard.o
	ld65 -o MODE7_CHECKERBOARD mode7_checkerboard.o -C ./apple2_1000.inc

mode7_checkerboard.o:	mode7.s checkerboard_lookup.s \
	zp.inc sprites.inc \
	../asm_routines/gr_hlin.s \
	../asm_routines/multiply_fast.s \
	../asm_routines/gr_fast_clear.s \
	../asm_routines/pageflip.s \
	../asm_routines/gr_setpage.s \
	../asm_routines/keypress.s \
	../asm_routines/gr_putsprite.s \
	../asm_routines/text_print.s \
	../asm_routines/gr_scroll.s \
	../asm_routines/bg_scroll.s
	ca65 -o mode7_checkerboard.o mode7.s -D CHECKERBOARD_MAP=1 -l mode7.lst

MODE7_RAINBOW:	mode7_rainbow.o
	ld65 -o MODE7_RAINBOW mode7_rainbow.o -C ./apple2_1000.inc

mode7_rainbow.o:	mode7.s rainbow_lookup.s \
	zp.inc sprites.inc \
	../asm_routines/multiply_fast.s \
	../asm_routines/gr_fast_clear.s \
	../asm_routines/gr_hlin.s \
	../asm_routines/pageflip.s \
	../asm_routines/gr_setpage.s \
	../asm_routines/keypress.s \
	../asm_routines/gr_putsprite.s \
	../asm_routines/text_print.s
	ca65 -o mode7_rainbow.o mode7.s -D RAINBOW_MAP=1 -l mode7.lst

SCROLL_DEMO:	scroll_demo.o
	ld65 -o SCROLL_DEMO scroll_demo.o -C ./apple2_1000.inc

scroll_demo.o:	scroll_demo.s \
	deater_scroll.inc \
	../asm_routines/gr_hlin.s \
	../asm_routines/gr_fast_clear.s \
	../asm_routines/gr_scroll.s \
	../asm_routines/pageflip.s \
	../asm_routines/gr_setpage.s
	ca65 -o scroll_demo.o scroll_demo.s -l scroll_demo.lst

SKY_DEMO:	sky_demo.o
	ld65 -o SKY_DEMO sky_demo.o -C ./apple2_1000.inc

sky_demo.o:	sky_demo.s \
	starry_sky.scroll \
	../asm_routines/gr_hlin.s \
	../asm_routines/gr_fast_clear.s \
	../asm_routines/gr_scroll.s \
	../asm_routines/pageflip.s \
	../asm_routines/gr_setpage.s
	ca65 -o sky_demo.o sky_demo.s -l sky_demo.lst

STARFIELD_DEMO:	starfield_demo.o
	ld65 -o STARFIELD_DEMO starfield_demo.o -C ./apple2_1000.inc

starfield_demo.o:	starfield_demo.s \
	../asm_routines/gr_scroll.s \
	../asm_routines/pageflip.s \
	../asm_routines/gr_setpage.s \
	../asm_routines/gr_fast_clear.s
	ca65 -o starfield_demo.o starfield_demo.s -l starfield_demo.lst

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
	SCROLL_DEMO *.lst

