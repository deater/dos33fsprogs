include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../../utils/gr-utils/png2sprites
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	a2_fortnight.hgr.zx02 \
	a2_fortnight_99.hgr.zx02 \
	a2_fortnight_100.hgr.zx02 \
	a2_fortnight_rat1.hgr.zx02 \
	a2_fortnight_rat2.hgr.zx02 \
	a2_break.hgr.zx02 \
	disk_sprites.inc


####

disk_sprites.inc:	a2_fortnight_sprites.png
	$(HGR_SPRITE) -s -l disk_sprite0 a2_fortnight_sprites.png  14   7 41  34 > disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_sprite1 a2_fortnight_sprites.png  14  42 41  69 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_sprite2 a2_fortnight_sprites.png  14  77 41 104 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_sprite3 a2_fortnight_sprites.png  14 112 41 139 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_mask0   a2_fortnight_sprites.png  56   7 83  34 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_mask1   a2_fortnight_sprites.png  56  42 83  69 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_mask2   a2_fortnight_sprites.png  56  77 83 104 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_mask3   a2_fortnight_sprites.png  56 112 83 139 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_sprite4 a2_fortnight_sprites.png  98   7 125  34 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_sprite5 a2_fortnight_sprites.png  98  42 125  69 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_sprite6 a2_fortnight_sprites.png  98  77 125 104 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_sprite7 a2_fortnight_sprites.png  98 112 125 139 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_mask4   a2_fortnight_sprites.png 140   7 167  34 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_mask5   a2_fortnight_sprites.png 140  42 167  69 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_mask6   a2_fortnight_sprites.png 140  77 167 104 >> disk_sprites.inc
	$(HGR_SPRITE) -s -l disk_mask7   a2_fortnight_sprites.png 140 112 167 139 >> disk_sprites.inc



####

a2_break.hgr.zx02:	a2_break.hgr
	$(ZX02) a2_break.hgr a2_break.hgr.zx02

a2_break.hgr:	a2_break.png
	$(PNG_TO_HGR) a2_break.png > a2_break.hgr


####

a2_fortnight_99.hgr.zx02:	a2_fortnight_99.hgr
	$(ZX02) a2_fortnight_99.hgr a2_fortnight_99.hgr.zx02

a2_fortnight_99.hgr:	a2_fortnight_99.png
	$(PNG_TO_HGR) a2_fortnight_99.png > a2_fortnight_99.hgr

####

a2_fortnight_100.hgr.zx02:	a2_fortnight_100.hgr
	$(ZX02) a2_fortnight_100.hgr a2_fortnight_100.hgr.zx02

a2_fortnight_100.hgr:	a2_fortnight_100.png
	$(PNG_TO_HGR) a2_fortnight_100.png > a2_fortnight_100.hgr

####

a2_fortnight.hgr.zx02:	a2_fortnight.hgr
	$(ZX02) a2_fortnight.hgr a2_fortnight.hgr.zx02

a2_fortnight.hgr:	a2_fortnight.png
	$(PNG_TO_HGR) a2_fortnight.png > a2_fortnight.hgr



####

a2_fortnight_rat1.hgr.zx02:	a2_fortnight_rat1.hgr
	$(ZX02) a2_fortnight_rat1.hgr a2_fortnight_rat1.hgr.zx02

a2_fortnight_rat1.hgr:	a2_fortnight_rat1.png
	$(PNG_TO_HGR) a2_fortnight_rat1.png > a2_fortnight_rat1.hgr

####

a2_fortnight_rat2.hgr.zx02:	a2_fortnight_rat2.hgr
	$(ZX02) a2_fortnight_rat2.hgr a2_fortnight_rat2.hgr.zx02

a2_fortnight_rat2.hgr:	a2_fortnight_rat2.png
	$(PNG_TO_HGR) a2_fortnight_rat2.png > a2_fortnight_rat2.hgr


####

clean:
	rm -f *~ *.o *.lst disk_sprites.inc *.zx02 *.hgr

