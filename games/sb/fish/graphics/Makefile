include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	fish_title.hgr.zx02 fish_bg.hgr.zx02 boat2_sb.hgr.zx02 \
	boat_sprites.inc strongbad_sprites.inc fish_sprites.inc


####

fish_title.hgr.zx02:	fish_title.hgr
	$(ZX02) fish_title.hgr fish_title.hgr.zx02

fish_title.hgr:	fish_title.png
	$(PNG_TO_HGR) fish_title.png > fish_title.hgr

####

fish_bg.hgr.zx02:	fish_bg.hgr
	$(ZX02) fish_bg.hgr fish_bg.hgr.zx02

fish_bg.hgr:	fish_bg.png
	$(PNG_TO_HGR) fish_bg.png > fish_bg.hgr

####

boat2_sb.hgr.zx02:	boat2_sb.hgr
	$(ZX02) boat2_sb.hgr boat2_sb.hgr.zx02

boat2_sb.hgr:	boat2_sb.png
	$(PNG_TO_HGR) boat2_sb.png > boat2_sb.hgr



####

boat_sprites.inc:	boat_sprites.png
	$(HGR_SPRITE) -s -l boat1_sprite boat_sprites.png   0  0 188 45 > boat_sprites.inc
	$(HGR_SPRITE) -s -l boat2_sprite boat_sprites.png   0  46 188 91 >> boat_sprites.inc
	$(HGR_SPRITE) -s -l boat3_sprite boat_sprites.png   0  92 188 137 >> boat_sprites.inc

####

strongbad_sprites.inc:	strongbad_sprites.png
	$(HGR_SPRITE) -s -l sb_sprite strongbad_sprites.png   0  0 55 66 > strongbad_sprites.inc
	$(HGR_SPRITE) -s -l sb_fish1_sprite strongbad_sprites.png   70  0 125 66 >> strongbad_sprites.inc
	$(HGR_SPRITE) -s -l sb_fish2_sprite strongbad_sprites.png   140  0 195 66 >> strongbad_sprites.inc
	$(HGR_SPRITE) -s -l sb_boat1_sprite strongbad_sprites.png   0 112 69 192 >> strongbad_sprites.inc
	$(HGR_SPRITE) -s -l sb_boat2_sprite strongbad_sprites.png   84 112 153 192 >> strongbad_sprites.inc
	$(HGR_SPRITE) -s -l sb_boat3_sprite strongbad_sprites.png   168 112 237 192 >> strongbad_sprites.inc

####

fish_sprites.inc:	fish_sprites.png
	$(HGR_SPRITE) -s -l grey_fish_sprite  fish_sprites.png   0   0  20  7 > fish_sprites.inc
	$(HGR_SPRITE) -s -l green_fish_sprite fish_sprites.png   0   9  20 16 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l red_fish_sprite   fish_sprites.png   0  18  27 25 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l grey_fish_mask    fish_sprites.png   42  0  62  7 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l green_fish_mask   fish_sprites.png   42  9  62 16 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l red_fish_mask     fish_sprites.png   42 18  69 25 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l left_fish_sprite  fish_sprites.png   0  29  20 36 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l right_fish_sprite fish_sprites.png   0  38  20 45 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l big_fish_sprite   fish_sprites.png   0  47  27 54 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l left_fish_mask    fish_sprites.png   42 29  62 36 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l right_fish_mask   fish_sprites.png   42 38  62 45 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l big_fish_mask     fish_sprites.png   42 47  69 54 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l zero_sprite  fish_sprites.png   0 72  6 79 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l one_sprite   fish_sprites.png  14 72 20 79 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l two_sprite   fish_sprites.png  28 72 34 79 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l three_sprite fish_sprites.png  42 72 48 79 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l four_sprite  fish_sprites.png  56 72 62 79 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l five_sprite  fish_sprites.png   0 80  6 87 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l six_sprite   fish_sprites.png  14 80 20 87 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l seven_sprite fish_sprites.png  28 80 34 87 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l eight_sprite fish_sprites.png  42 80 48 87 >> fish_sprites.inc
	$(HGR_SPRITE) -s -l nine_sprite  fish_sprites.png  56 80 62 87 >> fish_sprites.inc




####

clean:
	rm -f *~ *.o *.lst *.zx02 *.hgr strongbad_sprites.inc boat_sprites.inc fish_sprites.inc

