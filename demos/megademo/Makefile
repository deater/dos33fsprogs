include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
B2D = ../../utils/bmp2dhr/b2d
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_RLE = ../../utils/gr-utils/png2rle
PNG_TO_HGR = ../../utils/hgr-utils/png2hgr
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	megademo.dsk

megademo.dsk:	MEGADEMO MEGALOAD c64.img MUSIC.D000X2 MUSIC.D000 MUSIC.1000
	$(DOS33) -y megademo.dsk BSAVE -a 0x4000 MEGADEMO
	$(DOS33) -y megademo.dsk BSAVE -a 0x800 MEGALOAD
	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 c64.img C64.IMG
	$(DOS33) -y megademo.dsk BSAVE -a 0x1000 MUSIC.1000
	$(DOS33) -y megademo.dsk BSAVE -a 0x4000 MUSIC.D000
	$(DOS33) -y megademo.dsk BSAVE -a 0x4000 MUSIC.D000X2
#	$(DOS33) -y megademo.dsk RAWWRITE -t 27 -s 0 MEGADEMO MEGA2
#	$(DOS33) -y megademo.dsk BSAVE -a 0x4000 D_HGRC.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x4000 FS_HGRC.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 C64C.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 C64.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 C64_BW.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x4000 C64_UPDATE.BIN

####

MEGADEMO:	megademo.o
	ld65 -o MEGADEMO megademo.o -C ../../linker_scripts/apple2_4000.inc

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

MEGALOAD:        megaload.o
	ld65 -o MEGALOAD megaload.o -C ../../linker_scripts/apple2_800.inc

megaload.o:      megaload.s
	ca65 -o megaload.o megaload.s -l megaload.lst

####

MUSIC.1000:	music_1000.o
	ld65 -o MUSIC.1000 music_1000.o -C ../../linker_scripts/apple2_1000.inc

music_1000.o:	music_1000.s mockingboard.s
	ca65 -o music_1000.o music_1000.s -l music_1000.lst

####

MUSIC.D000:	music_d000.o
	ld65 -o MUSIC.D000 music_d000.o -C ../../linker_scripts/apple2_d000.inc

music_d000.o:	music_d000.s
	ca65 -o music_d000.o music_d000.s

####

MUSIC.D000X2:	music_2nd_d000.o
	ld65 -o MUSIC.D000X2 music_2nd_d000.o -C ../../linker_scripts/apple2_d000.inc

music_2nd_d000.o:	music_2nd_d000.s
	ca65 -o music_2nd_d000.o music_2nd_d000.s

####

apple_40_96.inc:	./images/apple_40_96.png
	$(PNG_TO_40x96) asm ./images/apple_40_96.png apple > apple_40_96.inc

####

email_40_96.inc:	./email_40_96.png
	$(PNG_TO_40x96) asm ./email_40_96.png email > email_40_96.inc

####

starring1.inc:	./starring_1.png
	$(PNG_TO_RLE) asm ./starring_1.png starring1 > starring1.inc

starring2.inc:	./starring_2.png
	$(PNG_TO_RLE) asm ./starring_2.png starring2 > starring2.inc


starring3.img.lz4:	starring3.img
	lz4 -f -16 starring3.img

starring3.img:	./starring_3_hgr.png
	$(PNG_TO_HGR) starring_3_hgr.png > starring3.img




####
leaving.inc:	./leaving.png
	$(PNG_TO_RLE) asm ./leaving.png leaving > leaving.inc

####
arrival.inc:	./arrival.png
	$(PNG_TO_RLE) asm ./arrival.png arrival > arrival.inc

####
takeoff.inc:	./takeoff.png
	$(PNG_TO_RLE) asm ./takeoff.png takeoff > takeoff.inc

takeoff.img.lz4:	takeoff.img
	lz4 -f -16 takeoff.img

takeoff.img:	takeoff_hgr.png
	$(PNG_TO_HGR) takeoff_hgr.png > takeoff.img

####

sp_names.inc:	sp_names.png
	$(PNG_TO_RLE) asm ./sp_names.png sp_names > sp_names.inc

####

fs.inc:	./fs.png
	$(PNG_TO_RLE) asm ./fs.png fs > fs.inc

FS_HGRC.BIN.lz4:	FS_HGRC.BIN
	lz4 -f -16 FS_HGRC.BIN

FS_HGRC.BIN:	fs_hgr.bmp
	$(B2D) fs_hgr.bmp HGR -d

####

deater.inc:	deater.png
	$(PNG_TO_RLE) asm ./deater.png deater > deater.inc

DEATER_HGRC.BIN.lz4:	DEATER_HGRC.BIN
	lz4 -f -16 DEATER_HGRC.BIN

DEATER_HGRC.BIN:	deater_hgr.bmp
	$(B2D) deater_hgr.bmp HGR -d

####

lg.inc:	lg.png
	$(PNG_TO_RLE) asm ./lg.png lg > lg.inc

LG_HGRC.BIN.lz4:	LG_HGRC.BIN
	lz4 -f -16 LG_HGRC.BIN

LG_HGRC.BIN:	lg_hgr.bmp
	$(B2D) lg_hgr.bmp HGR -d



####

c64.img.lz4:	c64.img
	lz4 -f -16 c64.img

c64.img:	c64_updated.png
	$(PNG_TO_HGR)  c64_updated.png > c64.img

####

D_HGRC.BIN:	d_hgr.bmp
	$(B2D) d_hgr.bmp HGR -d


C64C.BIN:	c64.bmp
	$(B2D) c64.bmp HGR

clean:		
		rm -f *~ *.o *.lst MEGADEMO MEGALOAD c64.img \
			MUSIC.1000 MUSIC.D000 MUSIC.D000X2 destroy_disk
		cd disk && make clean
		cd music && make clean
