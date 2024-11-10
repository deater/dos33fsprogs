include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../../utils/hgr-utils/png2dhgr
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	floater_wide_steffest.hgr.zx02 \
	riven_233.aux.zx02 riven_233.bin.zx02 \
	a2_atrus.hgr.zx02 \
	atrus_iipix.hgr.zx02 atrus_light_iipix.hgr.zx02 \
	atrus.aux.zx02 atrus.bin.zx02

####

floater_wide_steffest.hgr.zx02:	floater_wide_steffest.hgr
	$(ZX02) floater_wide_steffest.hgr floater_wide_steffest.hgr.zx02

floater_wide_steffest.hgr:	floater_wide_steffest.png
	$(PNG_TO_HGR) floater_wide_steffest.png > floater_wide_steffest.hgr

####

a2_atrus.hgr.zx02:	a2_atrus.hgr
	$(ZX02) a2_atrus.hgr a2_atrus.hgr.zx02

a2_atrus.hgr:	a2_atrus.png
	$(PNG_TO_HGR) a2_atrus.png > a2_atrus.hgr

####

atrus_iipix.hgr.zx02:	atrus_iipix.hgr
	$(ZX02) atrus_iipix.hgr atrus_iipix.hgr.zx02

atrus_iipix.hgr:	atrus_iipix.png
	$(PNG_TO_HGR) atrus_iipix.png > atrus_iipix.hgr

####

atrus_light_iipix.hgr.zx02:	atrus_light_iipix.hgr
	$(ZX02) atrus_light_iipix.hgr atrus_light_iipix.hgr.zx02

atrus_light_iipix.hgr:	atrus_light_iipix.png
	$(PNG_TO_HGR) atrus_light_iipix.png > atrus_light_iipix.hgr

####

atrus.aux.zx02:     atrus.AUX
	$(ZX02) atrus.AUX atrus.aux.zx02

atrus.AUX:  atrus_iipix_dhgr.png
	$(PNG_TO_DHGR) atrus_iipix_dhgr.png atrus

atrus.bin.zx02:     atrus.BIN
	$(ZX02) atrus.BIN atrus.bin.zx02

atrus.BIN: atrus_iipix_dhgr.png
	$(PNG_TO_DHGR) atrus_iipix_dhgr.png atrus


####

riven_233.aux.zx02:     riven_233.AUX
	$(ZX02) riven_233.AUX riven_233.aux.zx02

riven_233.AUX:  riven_233_dhgr.png
	$(PNG_TO_DHGR) riven_233_dhgr.png riven_233

riven_233.bin.zx02:     riven_233.BIN
	$(ZX02) riven_233.BIN riven_233.bin.zx02

riven_233.BIN: riven_233_dhgr.png
	$(PNG_TO_DHGR) riven_233_dhgr.png riven_233


####

clean:
	rm -f *~ *.zx02
