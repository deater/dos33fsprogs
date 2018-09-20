include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33

all:	combo_disk.dsk

combo_disk.dsk:	../two-liners/ENTROPY \
	../waterfall/WATERFALL \
	../still_alive/SA_COMPRESSED \
	../split_screen/CREDITS \
	../mode7_demo/MODE7_DEMO \
	../mockingboard/KSP_THEME_6CH \
	../fancy_lores/DISP4096 \
	../fireworks/FIREWORKS
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x0c00 ../two-liners/ENTROPY
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x1000 ../waterfall/WATERFALL
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x5900 ../still_alive/SA_COMPRESSED
	$(DOS33) -y combo_disk.dsk SAVE A ../still_alive/STILL_ALIVE.BAS STILLALIVE.BAS
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x1000 ../split_screen/CREDITS
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x2000 ../mode7_demo/MODE7_DEMO_C MODE7-DEMO
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x4000 ../mockingboard/KSP_THEME_6CH KSP-THEME
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x1000 ../fancy_lores/DISP4096
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x1000 ../fancy_lores/DISP4048D
	$(DOS33) -y combo_disk.dsk BSAVE -a 0x1000 ../fireworks/FIREWORKS

clean:	
	rm -f *~ *.o *.lst
