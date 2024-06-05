include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	fish_title.hgr.zx02

# sb_sprites.inc


####

fish_title.hgr.zx02:	fish_title.hgr
	$(ZX02) fish_title.hgr fish_title.hgr.zx02

fish_title.hgr:	fish_title.png
	$(PNG_TO_HGR) fish_title.png > fish_title.hgr


####

# TODO: optimize these a bit

sb_sprites.inc:	sb_sprites.png
	$(HGR_SPRITE) -s -l big_head0_sprite sb_sprites.png   0 78  47 134 > sb_sprites.inc
	$(HGR_SPRITE) -s -l big_head1_sprite sb_sprites.png  56 78 103 134 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l big_head2_sprite sb_sprites.png 112 78 159 134 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l big_head3_sprite sb_sprites.png  56 21 103  77 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l big_head4_sprite sb_sprites.png 112 21 159  77 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l player_sprite sb_sprites.png 98 138 181 192 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l shield_left_sprite sb_sprites.png 0 138 83 192 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l shield_center_sprite sb_sprites.png 196 83 279 137 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l shield_right_sprite sb_sprites.png 196 138 279 192 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet0_sprite sb_sprites.png 168 1 181 7 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet1_sprite sb_sprites.png 168 8 181 14 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet2_sprite sb_sprites.png 168 15 181 21 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet3_sprite sb_sprites.png 168 22 181 28 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet4_sprite sb_sprites.png 168 29 181 35 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet5_sprite sb_sprites.png 168 36 181 42 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet6_sprite sb_sprites.png 168 43 181 49 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet7_sprite sb_sprites.png 168 50 181 56 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet8_sprite sb_sprites.png 168 57 181 63 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet9_sprite sb_sprites.png 168 64 181 70 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet10_sprite sb_sprites.png 168 71 181 77 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet11_sprite sb_sprites.png 168 78 181 84 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet12_sprite sb_sprites.png 168 85 181 91 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet13_sprite sb_sprites.png 168 92 181 98 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet14_sprite sb_sprites.png 168 99 181 105 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet15_sprite sb_sprites.png 168 106 181 112 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l your_sprite sb_sprites.png 0 0 41 20 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l head_sprite sb_sprites.png 56 0 90 20 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l a_sprite sb_sprites.png 98 0 104 20 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l splode_sprite sb_sprites.png 112 0 166 20 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l your_med_sprite sb_sprites.png 0 22 33 31 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l head_med_sprite sb_sprites.png 0 32 26 41 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l a_med_sprite sb_sprites.png 42 32 47 41 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l splode_med_sprite sb_sprites.png 0 42 40 51 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l your_sm_sprite sb_sprites.png 0 52 19 57 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l head_sm_sprite sb_sprites.png 28 52 47 57 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l a_sm_sprite sb_sprites.png 0 58 5 63 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l splode_sm_sprite sb_sprites.png 14 58 33 63 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet_done_sprite sb_sprites.png 168 114 180 123 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l asploding1_sprite sb_sprites.png 196 27 222 52 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l asploding2_sprite sb_sprites.png 238 27 264 52 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l asploding3_sprite sb_sprites.png 196 53 222 78 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l asploding4_sprite sb_sprites.png 238 53 264 78 >> sb_sprites.inc

###

bob_sprites.inc:	bob_sprites.png Makefile
	$(HGR_SPRITE) -s -l back_sprite bob_sprites.png 0 0 41 20 > bob_sprites.inc
	$(HGR_SPRITE) -s -l off_sprite bob_sprites.png 56 0 90 20 >> bob_sprites.inc
	$(HGR_SPRITE) -s -l baby_sprite bob_sprites.png 98 0 131 20 >> bob_sprites.inc
	$(HGR_SPRITE) -s -l back_med_sprite bob_sprites.png 0 22 33 31 >> bob_sprites.inc
	$(HGR_SPRITE) -s -l off_med_sprite bob_sprites.png 0 32 26 41 >> bob_sprites.inc
	$(HGR_SPRITE) -s -l baby_med_sprite bob_sprites.png 0 42 40 51 >> bob_sprites.inc
	$(HGR_SPRITE) -s -l back_sm_sprite bob_sprites.png 0 52 19 57 >> bob_sprites.inc
	$(HGR_SPRITE) -s -l off_sm_sprite bob_sprites.png 28 52 47 57 >> bob_sprites.inc
	$(HGR_SPRITE) -s -l baby_sm_sprite bob_sprites.png 14 58 33 63 >> bob_sprites.inc

####

clean:
	rm -f *~ *.o *.lst *.zx02 *.hgr sb_sprites.inc bob_sprites.inc

