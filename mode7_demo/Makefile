include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr
PNG2RLE = ../gr-utils/png2rle

all:	mode7_demo.dsk

$(DOS33):	
	cd ../dos33fs-utils && make

mode7_demo.dsk:	$(DOS33) MODE7_DEMO
	$(DOS33) -y mode7_demo.dsk BSAVE -a 0x2000 MODE7_DEMO



###

MODE7_DEMO:	mode7_demo.o
	ld65 -o MODE7_DEMO mode7_demo.o -C ./apple2_2000.inc

mode7_demo.o:	mode7_demo.s mode7_demo_backgrounds.inc \
		a2.scrolltext deater.scrolltext \
		../asm_routines/gr_unrle.s \
		../asm_routines/hlin_clearscreen.s \
		../asm_routines/gr_setpage.s \
		../asm_routines/gr_fade.s \
		../asm_routines/gr_copy.s \
		../asm_routines/gr_scroll.s \
		mode7.s
	ca65 -o mode7_demo.o mode7_demo.s -l mode7_demo.lst


mode7_demo_backgrounds.inc:	$(PNG2RLE) \
	../tfv/demo.png
	$(PNG2RLE) asm ../tfv/demo.png demo_rle > mode7_demo_backgrounds.inc


clean:	
	rm -f *~ *.o MODE7_DEMO *.lst

