include ../Makefile.inc

DOS33 = ../utils/dos33fs-utils/dos33

all:	combo_disk.dsk

combo_disk.dsk:	../basic/two-liners/ENTROPY \
	../demos/waterfall/WATERFALL \
	../music/still_alive/SA_COMPRESSED \
	../demos/split_screen/CREDITS \
	../demos/mode7_demo/MODE7_DEMO \
	../music/mockingboard/KSP_THEME_6CH \
	../vaporlock/fancy_lores/DISP4096 \
	../demos/fireworks/FIREWORKS \
	../demos/space_bars/SPACE_BARS
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x0c00 ../basic/two-liners/ENTROPY
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x1000 ../demos/waterfall/WATERFALL
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x5900 ../music/still_alive/SA_COMPRESSED
	$(DOS33) -y combo_disk.dsk SAVE A ../music/still_alive/STILL_ALIVE.BAS STILLALIVE.BAS
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x1000 ../demos/split_screen/CREDITS
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x2000 ../demos/mode7_demo/MODE7_DEMO_C MODE7-DEMO
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x4000 ../music/mockingboard/KSP_THEME_6CH KSP-THEME
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x1000 ../vaporlock/fancy_lores/DISP4096
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x1000 ../vaporlock/fancy_lores/DISP4048D
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x1000 ../demos/fireworks/FIREWORKS
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x4000 ../games/space_bars/SPACE_BARS SPACE-BARS

clean:	
	rm -f *~ *.o *.lst
