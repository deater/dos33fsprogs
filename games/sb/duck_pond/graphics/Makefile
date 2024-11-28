include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../../utils/gr-utils/png2sprites

all:	a2_duckpond_title.gr.zx02 \
	a2_duckpond.gr.zx02 \
	a2_duckpond_twilight.gr.zx02 \
	a2_duckpond_night.gr.zx02 \
	num_sprites.inc \
	duck_sprites.inc

####

num_sprites.inc:	lores_font.png
	$(PNG2SPRITES) lores_font.png zero_sprite   0 0 3 6 >  num_sprites.inc
	$(PNG2SPRITES) lores_font.png one_sprite    4 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png two_sprite    8 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png three_sprite 12 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png four_sprite  16 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png five_sprite  20 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png six_sprite   24 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png seven_sprite 28 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png eight_sprite  0 6 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png nine_sprite   4 6 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png colon_sprite  8 6 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png d_sprite     12 6 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png space_sprite 16 6 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png zero_mask     0 14 3 6 >>  num_sprites.inc
	$(PNG2SPRITES) lores_font.png one_mask      4 14 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png two_mask      8 14 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png three_mask   12 14 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png four_mask    16 14 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png five_mask    20 14 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png six_mask     24 14 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png seven_mask   28 14 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png eight_mask    0 20 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png nine_mask     4 20 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png colon_mask    8 20 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png d_mask       12 20 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png space_mask   16 20 3 6 >> num_sprites.inc


####

duck_sprites.inc:	duck1_sprites_left.png duck1_sprites_right.png \
			duck2_sprites_left.png duck2_sprites_right.png
	$(PNG2SPRITES) duck1_sprites_left.png d1_left1_sprite   1   2 11 12 >  duck_sprites.inc
	$(PNG2SPRITES) duck1_sprites_left.png d1_left2_sprite   1  16 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck1_sprites_left.png d1_left3_sprite   1  30 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck1_sprites_left.png d1_left1_mask     13  2 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck1_sprites_left.png d1_left2_mask     13 16 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck1_sprites_left.png d1_left3_mask     13 30 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck1_sprites_right.png d1_right1_sprite 1   2 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck1_sprites_right.png d1_right2_sprite 1  16 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck1_sprites_right.png d1_right3_sprite 1  30 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck1_sprites_right.png d1_right1_mask   13  2 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck1_sprites_right.png d1_right2_mask   13 16 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck1_sprites_right.png d1_right3_mask   13 30 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck2_sprites_left.png d2_left1_sprite   1   2 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck2_sprites_left.png d2_left2_sprite   1  16 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck2_sprites_left.png d2_left3_sprite   1  30 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck2_sprites_left.png d2_left1_mask     13  2 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck2_sprites_left.png d2_left2_mask     13 16 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck2_sprites_left.png d2_left3_mask     13 30 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck2_sprites_right.png d2_right1_sprite 1   2 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck2_sprites_right.png d2_right2_sprite 1  16 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck2_sprites_right.png d2_right3_sprite 1  30 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck2_sprites_right.png d2_right1_mask   13  2 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck2_sprites_right.png d2_right2_mask   13 16 11 12 >>  duck_sprites.inc
	$(PNG2SPRITES) duck2_sprites_right.png d2_right3_mask   13 30 11 12 >>  duck_sprites.inc

####

a2_duckpond_title.gr.zx02:	a2_duckpond_title.gr
	$(ZX02) a2_duckpond_title.gr a2_duckpond_title.gr.zx02

a2_duckpond_title.gr:	a2_duckpond_title.png
	$(PNG2GR) a2_duckpond_title.png a2_duckpond_title.gr

####

a2_duckpond.gr.zx02:	a2_duckpond.gr
	$(ZX02) a2_duckpond.gr a2_duckpond.gr.zx02

a2_duckpond.gr:	a2_duckpond.png
	$(PNG2GR) a2_duckpond.png a2_duckpond.gr

####

a2_duckpond_twilight.gr.zx02:	a2_duckpond_twilight.gr
	$(ZX02) a2_duckpond_twilight.gr a2_duckpond_twilight.gr.zx02

a2_duckpond_twilight.gr:	a2_duckpond_twilight.png
	$(PNG2GR) a2_duckpond_twilight.png a2_duckpond_twilight.gr

####

a2_duckpond_night.gr.zx02:	a2_duckpond_night.gr
	$(ZX02) a2_duckpond_night.gr a2_duckpond_night.gr.zx02

a2_duckpond_night.gr:	a2_duckpond_night.png
	$(PNG2GR) a2_duckpond_night.png a2_duckpond_night.gr




####

clean:
	rm -f *~ *.o *.lst *.zx02 *.gr

