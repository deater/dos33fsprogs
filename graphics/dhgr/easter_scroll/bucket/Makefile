include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR4 = ../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../linker_scripts/

all:	BUCKET

###

BUCKET:	bucket.o
	ld65 -o BUCKET bucket.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

bucket.o:	bucket.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	bucket_top.bin.zx02 bucket_top.aux.zx02 \
	bucket_bottom.bin.zx02 bucket_bottom.aux.zx02
	ca65 -o bucket.o bucket.s -l bucket.lst

###

#BUCKET_MAIN:	bucket_main.o
#	ld65 -o BUCKET_MAIN bucket_main.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

#bucket_main.o:	bucket_main.s \
#	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
#	bucket_aux.inc \
#	headphone.bin.zx02 \
#	hip1.bin.zx02 \
#	hip2.bin.zx02 \
#	hip3.bin.zx02
#	ca65 -o bucket_main.o bucket_main.s -l bucket_main.lst


###

bucket_aux.inc:	../generate_common BUCKET_AUX
	../generate_common -a 0x6000 -s headphone_aux bucket_aux.lst > bucket_aux.inc
	../generate_common -a 0x6000 -s hip1_aux bucket_aux.lst >> bucket_aux.inc
	../generate_common -a 0x6000 -s hip2_aux bucket_aux.lst >> bucket_aux.inc
	../generate_common -a 0x6000 -s hip3_aux bucket_aux.lst >> bucket_aux.inc

###

#BUCKET_AUX:	bucket_aux.o
#	ld65 -o BUCKET_AUX bucket_aux.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

#bucket_aux.o:	bucket_aux.s \
#	headphone.aux.zx02 \
#	hip1.aux.zx02 \
#	hip2.aux.zx02 \
#	hip3.aux.zx02
#	ca65 -o bucket_aux.o bucket_aux.s -l bucket_aux.lst


####

bucket_top.aux.zx02:     bucket_top.AUX
	$(ZX02) bucket_top.AUX bucket_top.aux.zx02

bucket_top.AUX:  bucket_top.png
	$(PNG_TO_DHGR) bucket_top.png bucket_top

bucket_top.bin.zx02:     bucket_top.BIN
	$(ZX02) bucket_top.BIN bucket_top.bin.zx02

bucket_top.BIN: bucket_top.png
	$(PNG_TO_DHGR) bucket_top.png bucket_top

####

bucket_bottom.aux.zx02:     bucket_bottom.AUX
	$(ZX02) bucket_bottom.AUX bucket_bottom.aux.zx02

bucket_bottom.AUX:  bucket_bottom.png
	$(PNG_TO_DHGR) bucket_bottom.png bucket_bottom

bucket_bottom.bin.zx02:     bucket_bottom.BIN
	$(ZX02) bucket_bottom.BIN bucket_bottom.bin.zx02

bucket_bottom.BIN: bucket_bottom.png
	$(PNG_TO_DHGR) bucket_bottom.png bucket_bottom


####

clean:
	rm -f *~ BUCKET *.AUX *.BIN *.o *.lst *.zx02
