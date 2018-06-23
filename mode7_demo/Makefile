include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr
PNG2RLE = ../gr-utils/png2rle

all:	mode7_demo.dsk

$(DOS33):	
	cd ../dos33fs-utils && make

mode7_demo.dsk:	$(DOS33) MODE7_DEMO MODE7_DEMO_C
#	$(DOS33) -y mode7_demo.dsk BSAVE -a 0x4000 MODE7_DEMO
	$(DOS33) -y mode7_demo.dsk BSAVE -a 0x2000 MODE7_DEMO_C



###

MODE7_DEMO_C:	mode7_decompress.o
	ld65 -o MODE7_DEMO_C mode7_decompress.o -C ../linker_scripts/apple2_2000.inc

mode7_decompress.o:	mode7_decompress.s MODE7_DEMO.lz4 \
		zp.inc
	ca65 -o mode7_decompress.o mode7_decompress.s


MODE7_DEMO.lz4:	MODE7_DEMO
	lz4 -f -16 MODE7_DEMO

###

MODE7_DEMO:	mode7_demo.o
	ld65 -o MODE7_DEMO mode7_demo.o -C ../linker_scripts/apple2_4000.inc

mode7_demo.o:	mode7_demo.s mode7_demo_backgrounds.inc sprites.inc \
		a2.scrolltext deater.scrolltext wave.krg \
		gr_unrle.s \
		gr_fast_clear.s \
		gr_setpage.s \
		gr_fade.s \
		gr_copy.s \
		gr_scroll.s \
		mockingboard.s \
		credits.s mode7.s rasterbars.s starfield_demo.s \
		interrupt_handler.s \
		zp.inc
	ca65 -o mode7_demo.o mode7_demo.s -l mode7_demo.lst

$(PNG2RLE):	
	cd ../gr-utils && make


mode7_demo_backgrounds.inc:	$(PNG2RLE) \
	demo.png
	$(PNG2RLE) asm demo.png demo_rle > mode7_demo_backgrounds.inc


clean:	
	rm -f *~ *.o MODE7_DEMO MODE7_DEMO_C MODE7_DEMO.lz4 *.lst
	cd docs && make clean
