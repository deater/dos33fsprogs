include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr
PNG2RLE = ../gr-utils/png2rle

ARTDIR = ./art

all:	tfv.dsk

$(PNG2RLE):	
	cd ../gr-utils && make

$(DOS33):	
	cd ../dos33fs-utils && make

tfv.dsk:	$(DOS33) TFV
	$(DOS33) -y tfv.dsk BSAVE -a 0x1000 TFV
#	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 HIGHWIND.ED
#	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 FIGHTING.ED


tfv_backgrounds.inc:	$(PNG2RLE) \
	$(ARTDIR)/title.png $(ARTDIR)/map.png \
	$(ARTDIR)/landing.png $(ARTDIR)/harfco.png \
	$(ARTDIR)/belair.png \
	$(ARTDIR)/math_office.png $(ARTDIR)/video_hr.png \
	$(ARTDIR)/collegep.png \
	$(ARTDIR)/umcp.png \
	$(ARTDIR)/dining.png $(ARTDIR)/metro.png $(ARTDIR)/talbot.png
	$(PNG2RLE) asm $(ARTDIR)/title.png title_rle > tfv_backgrounds.inc
	$(PNG2RLE) asm $(ARTDIR)/map.png map_rle >> tfv_backgrounds.inc
	$(PNG2RLE) asm $(ARTDIR)/landing.png landing_rle >> tfv_backgrounds.inc
	$(PNG2RLE) asm $(ARTDIR)/harfco.png harfco_rle >> tfv_backgrounds.inc
	$(PNG2RLE) asm $(ARTDIR)/belair.png belair_rle >> tfv_backgrounds.inc
	$(PNG2RLE) asm $(ARTDIR)/math_office.png math_office_rle >> tfv_backgrounds.inc
	$(PNG2RLE) asm $(ARTDIR)/video_hr.png video_hr_rle >> tfv_backgrounds.inc
	$(PNG2RLE) asm $(ARTDIR)/collegep.png collegep_rle >> tfv_backgrounds.inc
	$(PNG2RLE) asm $(ARTDIR)/umcp.png umcp_rle >> tfv_backgrounds.inc
	$(PNG2RLE) asm $(ARTDIR)/dining.png dining_rle >> tfv_backgrounds.inc
	$(PNG2RLE) asm $(ARTDIR)/metro.png metro_rle >> tfv_backgrounds.inc
	$(PNG2RLE) asm $(ARTDIR)/talbot.png talbot_rle >> tfv_backgrounds.inc

###

TFV:	tfv.o
	ld65 -o TFV tfv.o -C ../linker_scripts/apple2_1000.inc

tfv.o:	tfv.s \
	tfv_flying.s tfv_info.s tfv_opener.s tfv_title.s \
	tfv_textentry.s tfv_worldmap.s \
	tfv_backgrounds.inc tfv_sprites.inc tfv_zp.inc \
	../asm_routines/multiply_fast.s \
	../asm_routines/gr_fast_clear.s \
	../asm_routines/pageflip.s \
	../asm_routines/gr_setpage.s \
	../asm_routines/keypress.s \
	../asm_routines/gr_putsprite.s \
	../asm_routines/text_print.s \
	../asm_routines/memset.s \
	../asm_routines/gr_vlin.s \
	../asm_routines/gr_copy.s \
	../asm_routines/gr_unrle.s
	ca65 -o tfv.o tfv.s -l tfv.lst



clean:	
	rm -f *~ TITLE.GR *.o *.lst ED TFV

