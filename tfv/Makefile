include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr
PNG2RLE = ../gr-utils/png2rle

all:	tfv.dsk

tfv.dsk:	TFV ED HIGHWIND.ED FIGHTING.ED
	$(DOS33) -y tfv.dsk BSAVE -a 0x1000 TFV
	$(DOS33) -y tfv.dsk BSAVE -a 0x900 ED
	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 HIGHWIND.ED
	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 FIGHTING.ED

ED:	duet.o
	ld65 -o ED duet.o -C ./apple2_900.inc

duet.o:	duet.s
	ca65 -o duet.o duet.s -l duet.lst


$(PNG2RLE):	
	cd ../gr-utils && make

backgrounds.inc:	$(PNG2RLE) \
	title.png map.png \
	landing.png harfco.png \
	belair.png \
	math_office.png video_hr.png \
	collegep.png \
	umcp.png \
	dining.png metro.png talbot.png
	$(PNG2RLE) asm title.png title_rle > backgrounds.inc
	$(PNG2RLE) asm map.png map_rle >> backgrounds.inc
	$(PNG2RLE) asm landing.png landing_rle >> backgrounds.inc
	$(PNG2RLE) asm harfco.png harfco_rle >> backgrounds.inc
	$(PNG2RLE) asm belair.png belair_rle >> backgrounds.inc
	$(PNG2RLE) asm math_office.png math_office_rle >> backgrounds.inc
	$(PNG2RLE) asm video_hr.png video_hr_rle >> backgrounds.inc
	$(PNG2RLE) asm collegep.png collegep_rle >> backgrounds.inc
	$(PNG2RLE) asm umcp.png umcp_rle >> backgrounds.inc
	$(PNG2RLE) asm dining.png dining_rle >> backgrounds.inc
	$(PNG2RLE) asm metro.png metro_rle >> backgrounds.inc
	$(PNG2RLE) asm talbot.png talbot_rle >> backgrounds.inc

###

TFV:	tfv.o
	ld65 -o TFV tfv.o -C ./apple2_1000.inc

tfv.o:	tfv.s opener.s utils.s backgrounds.inc zp.inc
	ca65 -o tfv.o tfv.s -l tfv.lst



clean:	
	rm -f *~ TITLE.GR *.o *.lst ED

