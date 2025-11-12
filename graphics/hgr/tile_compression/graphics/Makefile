include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR_RAW = ../../../../utils/hgr-utils/png2dhgr_raw
PNG_TO_DHGR4 = ../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../linker_scripts/

all:	pa_house_bottom2.hgr.zx02 \
	a2_saturn_warrior.hgr.zx02

####

pa_house_bottom2.hgr.zx02:	pa_house_bottom2.hgr
	$(ZX02) pa_house_bottom2.hgr pa_house_bottom2.hgr.zx02

pa_house_bottom2.hgr:  pa_house_bottom2.png
	$(PNG_TO_HGR) pa_house_bottom2.png > pa_house_bottom2.hgr

####

a2_saturn_warrior.hgr.zx02:	a2_saturn_warrior.hgr
	$(ZX02) a2_saturn_warrior.hgr a2_saturn_warrior.hgr.zx02

a2_saturn_warrior.hgr:  a2_saturn_warrior.png
	$(PNG_TO_HGR) a2_saturn_warrior.png > a2_saturn_warrior.hgr


####

clean:
	rm -f *~ *.zx02 *.lst *.o *.AUX *.BIN *.raw_top *.raw_bottom *.hgr house_sprites.inc

