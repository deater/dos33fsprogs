include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	fish_title.hgr.zx02 fish_bg.hgr.zx02 boat2_sb.hgr.zx02 \
	boat_sprites.inc strongbad_sprites.inc


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
	$(HGR_SPRITE) -s -l sb_boat3_sprite strongbad_sprites.png   161 112 230 192 >> strongbad_sprites.inc







####

clean:
	rm -f *~ *.o *.lst *.zx02 *.hgr strongbad_sprites.inc boat_sprites.inc

