include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	mist.dsk

mist.dsk:	HELLO MIST MIST_TITLE MIST_TITLE.LZ4
	cp empty.dsk mist.dsk
	$(DOS33) -y mist.dsk SAVE A HELLO
	$(DOS33) -y mist.dsk BSAVE -a 0x1000 MIST
	$(DOS33) -y mist.dsk BSAVE -a 0x1000 MIST_TITLE
	$(DOS33) -y mist.dsk BSAVE -a 0xa000 MIST_TITLE.LZ4
#	$(DOS33) -y mist.dsk BSAVE -a 0x4000 STEPS_HGRC.BIN

###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####

MIST_TITLE:	mist_title.o
	ld65 -o MIST_TITLE mist_title.o -C ../linker_scripts/apple2_1000.inc

mist_title.o:	mist_title.s zp.inc hardware.inc
#gr_copy.s gr_unrle.s gr_unrle_large.s gr_copy_large.s
	ca65 -o mist_title.o mist_title.s -l mist_title.lst

####

MIST:	mist.o
	ld65 -o MIST mist.o -C ../linker_scripts/apple2_1000.inc

mist.o:	mist.s zp.inc hardware.inc \
	mist_graphics.inc \
	gr_copy.s gr_unrle.s audio.s
	ca65 -o mist.o mist.s -l mist.lst

####

mist_graphics.inc:	\
	m_link_book.png \
	dock_n.png dock_s.png dock_e.png dock_w.png \
	dock_switch_n.png \
	dock_steps_w.png \
	above_dock_e.png above_dock_n.png above_dock_s.png \
	step_base_s.png step_base_n.png \
	step_land1_w.png step_land1_e.png \
	step_land2_e.png step_land2_w.png \
	step_dentist_e.png step_dentist_w.png \
	step_land3_w.png step_land3_e.png \
	step_top_e.png step_top_w.png step_top_n.png step_top_s.png \
	temple_door_n.png temple_door_s.png \
	temple_center_n.png temple_center_w.png \
	red_book_shelf.png \
	pool_s.png \
	clock_s.png \
	spaceship_far_n.png
	$(PNG2RLE) asm m_link_book.png link_book_rle > mist_graphics.inc
	$(PNG2RLE) asm dock_n.png dock_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm dock_s.png dock_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm dock_e.png dock_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm dock_w.png dock_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm dock_switch_n.png dock_switch_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm dock_switch_s.png dock_switch_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm dock_steps_w.png dock_steps_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm above_dock_e.png above_dock_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm above_dock_s.png above_dock_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm above_dock_n.png above_dock_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_base_n.png step_base_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_base_s.png step_base_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_land1_w.png step_land1_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_land1_e.png step_land1_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_land2_w.png step_land2_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_land2_e.png step_land2_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_dentist_w.png step_dentist_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_dentist_e.png step_dentist_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_land3_w.png step_land3_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_land3_e.png step_land3_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_top_e.png step_top_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_top_w.png step_top_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_top_n.png step_top_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm step_top_s.png step_top_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm temple_door_n.png temple_door_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm temple_door_s.png temple_door_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm temple_center_n.png temple_center_n_rle >> mist_graphics.inc
	$(PNG2RLE) asm temple_center_s.png temple_center_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm temple_center_e.png temple_center_e_rle >> mist_graphics.inc
	$(PNG2RLE) asm temple_center_w.png temple_center_w_rle >> mist_graphics.inc
	$(PNG2RLE) asm red_book_shelf.png red_book_shelf_rle >> mist_graphics.inc
	$(PNG2RLE) asm pool_s.png pool_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm clock_s.png clock_s_rle >> mist_graphics.inc
	$(PNG2RLE) asm spaceship_far_n.png ss_far_n_rle >> mist_graphics.inc


####

MIST_TITLE.LZ4:	MIST_TITLEC.BIN
	lz4 -f -16 MIST_TITLEC.BIN
	dd if=MIST_TITLEC.BIN.lz4 of=MIST_TITLE.LZ4 bs=1 skip=11
	truncate MIST_TITLE.LZ4 -s -8

MIST_TITLEC.BIN:	mist_title.bmp
	$(B2D) mist_title.bmp HGR -d

####

clean:		
		rm -f *~ *.o *.lst MIST_TITLEC.BIN MIST MIST_TITLE
