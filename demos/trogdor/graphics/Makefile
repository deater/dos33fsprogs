include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	\
	actual00_trog_peasant.hgr.zx02 \
	actual01_dragonman.hgr.zx02 \
	actual02_updown_cottage.hgr.zx02 \
	trog00_trogdor.hgr.zx02 \
	trog01_countryside.hgr.zx02 \
	trog02_countryside.hgr.zx02 \
	trog03_man.hgr.zx02 \
	trog04_dragonman.hgr.zx02 \
	trog05_zoom.hgr.zx02 \
	trog07_peasant.hgr.zx02 \
	trog08_close1.hgr.zx02 \
	trog09_close.hgr.zx02 \
	trog10_peasants.hgr.zx02 \
	trog11_cottage.hgr.zx02 \
	a2_strongbad.hgr.zx02 \
	trogdor.hgr.zx02 \
	flame_sprites.inc

####

flame_sprites.inc:	compact_flames.png
	$(HGR_SPRITE) -s -l left_flame_small ./compact_flames.png 0 8 55 48  > flame_sprites.inc
	$(HGR_SPRITE) -s -l right_flame_small ./compact_flames.png 56 8 111 48  >> flame_sprites.inc
	$(HGR_SPRITE) -s -l left_flame_big ./compact_flames.png 0 54 55 192  >> flame_sprites.inc
	$(HGR_SPRITE) -s -l right_flame_big ./compact_flames.png 56 54 111 192  >> flame_sprites.inc
	$(HGR_SPRITE) -s -l left_flame_small_mask ./compact_flames.png 112 8 167 48  >> flame_sprites.inc
	$(HGR_SPRITE) -s -l right_flame_small_mask ./compact_flames.png 168 8 223 48  >> flame_sprites.inc
	$(HGR_SPRITE) -s -l left_flame_big_mask ./compact_flames.png 112 54 167 192  >> flame_sprites.inc
	$(HGR_SPRITE) -s -l right_flame_big_mask ./compact_flames.png 168 54 223 192  >> flame_sprites.inc


####

trogdor.hgr.zx02:	trogdor.hgr
	$(ZX02) trogdor.hgr trogdor.hgr.zx02

trogdor.hgr:	trogdor.png
	$(PNG_TO_HGR) trogdor.png > trogdor.hgr

####

a2_strongbad.hgr.zx02:	a2_strongbad.hgr
	$(ZX02) a2_strongbad.hgr a2_strongbad.hgr.zx02

a2_strongbad.hgr:	a2_strongbad.png
	$(PNG_TO_HGR) a2_strongbad.png > a2_strongbad.hgr


####

actual00_trog_peasant.hgr.zx02:	actual00_trog_peasant.hgr
	$(ZX02) actual00_trog_peasant.hgr actual00_trog_peasant.hgr.zx02

actual00_trog_peasant.hgr:	actual00_trog_peasant.png
	$(PNG_TO_HGR) actual00_trog_peasant.png > actual00_trog_peasant.hgr

####

actual01_dragonman.hgr.zx02:	actual01_dragonman.hgr
	$(ZX02) actual01_dragonman.hgr actual01_dragonman.hgr.zx02

actual01_dragonman.hgr:	actual01_dragonman.png
	$(PNG_TO_HGR) actual01_dragonman.png > actual01_dragonman.hgr

####

actual02_updown_cottage.hgr.zx02:	actual02_updown_cottage.hgr
	$(ZX02) actual02_updown_cottage.hgr actual02_updown_cottage.hgr.zx02

actual02_updown_cottage.hgr:	actual02_updown_cottage.png
	$(PNG_TO_HGR) actual02_updown_cottage.png > actual02_updown_cottage.hgr


####

trog00_trogdor.hgr.zx02:	trog00_trogdor.hgr
	$(ZX02) trog00_trogdor.hgr trog00_trogdor.hgr.zx02

trog00_trogdor.hgr:	trog00_trogdor.png
	$(PNG_TO_HGR) trog00_trogdor.png > trog00_trogdor.hgr

####

trog01_countryside.hgr.zx02:	trog01_countryside.hgr
	$(ZX02) trog01_countryside.hgr trog01_countryside.hgr.zx02

trog01_countryside.hgr:	trog01_countryside.png
	$(PNG_TO_HGR) trog01_countryside.png > trog01_countryside.hgr

####

trog02_countryside.hgr.zx02:	trog02_countryside.hgr
	$(ZX02) trog02_countryside.hgr trog02_countryside.hgr.zx02

trog02_countryside.hgr:	trog02_countryside.png
	$(PNG_TO_HGR) trog02_countryside.png > trog02_countryside.hgr


####

trog03_man.hgr.zx02:	trog03_man.hgr
	$(ZX02) trog03_man.hgr trog03_man.hgr.zx02

trog03_man.hgr:	trog03_man.png
	$(PNG_TO_HGR) trog03_man.png > trog03_man.hgr

####

trog04_dragonman.hgr.zx02:	trog04_dragonman.hgr
	$(ZX02) trog04_dragonman.hgr trog04_dragonman.hgr.zx02

trog04_dragonman.hgr:	trog04_dragonman.png
	$(PNG_TO_HGR) trog04_dragonman.png > trog04_dragonman.hgr

####

trog05_zoom.hgr.zx02:	trog05_zoom.hgr
	$(ZX02) trog05_zoom.hgr trog05_zoom.hgr.zx02

trog05_zoom.hgr:	trog05_zoom.png
	$(PNG_TO_HGR) trog05_zoom.png > trog05_zoom.hgr

####

trog07_peasant.hgr.zx02:	trog07_peasant.hgr
	$(ZX02) trog07_peasant.hgr trog07_peasant.hgr.zx02

trog07_peasant.hgr:	trog07_peasant.png
	$(PNG_TO_HGR) trog07_peasant.png > trog07_peasant.hgr

####

trog08_close1.hgr.zx02:	trog08_close1.hgr
	$(ZX02) trog08_close1.hgr trog08_close1.hgr.zx02

trog08_close1.hgr:	trog08_close1.png
	$(PNG_TO_HGR) trog08_close1.png > trog08_close1.hgr

####

trog09_close.hgr.zx02:	trog09_close.hgr
	$(ZX02) trog09_close.hgr trog09_close.hgr.zx02

trog09_close.hgr:	trog09_close.png
	$(PNG_TO_HGR) trog09_close.png > trog09_close.hgr


####

trog10_peasants.hgr.zx02:	trog10_peasants.hgr
	$(ZX02) trog10_peasants.hgr trog10_peasants.hgr.zx02

trog10_peasants.hgr:	trog10_peasants.png
	$(PNG_TO_HGR) trog10_peasants.png > trog10_peasants.hgr

####

trog11_cottage.hgr.zx02:	trog11_cottage.hgr
	$(ZX02) trog11_cottage.hgr trog11_cottage.hgr.zx02

trog11_cottage.hgr:	trog11_cottage.png
	$(PNG_TO_HGR) trog11_cottage.png > trog11_cottage.hgr



####

clean:
	rm -f *~ *.zx02
