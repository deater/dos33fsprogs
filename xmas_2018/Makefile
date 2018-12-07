include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
B2D = ../bmp2dhr/b2d
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_RLE = ../gr-utils/png2rle

all:	xmas2018.dsk

xmas2018.dsk:	wreath.img
#	$(DOS33) -y xmas2018.dsk BSAVE -a 0x4000 XMAS2018
	$(DOS33) -y xmas2018.dsk BSAVE -a 0x2000 wreath.img WREATH.IMG

####

MEGADEMO:	megademo.o
	ld65 -o MEGADEMO megademo.o -C ../linker_scripts/apple2_4000.inc

megademo.o:	megademo.s \
	zp.inc hardware.inc \
	gr_hline.s gr_offsets.s vapor_lock.s delay_a.s wait_keypress.s \
	mockingboard.s \
	c64_opener.s c64.img.lz4 \
	falling_apple.s apple_40_96.inc \
	starring.s starring1.inc starring2.inc starring3.img.lz4\
	starring_people.s sp_names.inc fs.inc FS_HGRC.BIN.lz4 \
		deater.inc DEATER_HGRC.BIN.lz4 lg.inc LG_HGRC.BIN.lz4 \
	check_email.s email_40_96.inc \
	leaving.s leaving.inc tfv_sprites.inc \
	arrival.s arrival.inc \
	bird_mountain.s letters.s \
	waterfall.s waterfall_page1.inc waterfall_page2.inc \
	takeoff.s takeoff.inc takeoff.img.lz4 \
	mode7.s \
	space_bars.s text_print.s \
	fireworks.s fw_background.inc fw_state_machine.s fw.s \
	hgr.s random16.s move_letters.s
	ca65 -o megademo.o megademo.s -l megademo.lst


####

#c64.img.lz4:	c64.img
#	lz4 -f -16 c64.img
#
#c64.img:	c64_updated.png
#	../hgr-utils/png2hgr c64_updated.png > c64.img

####

#D_HGRC.BIN:	d_hgr.bmp
#	$(B2D) d_hgr.bmp HGR -d

wreath.img:	WREATHC.BIN
	cp WREATHC.BIN wreath.img

WREATHC.BIN:	wreath.bmp
	$(B2D) wreath.bmp HGR -d

clean:
		rm -f *~ *.o *.lst XMAS2018 wreath.img WREATHC.BIN

