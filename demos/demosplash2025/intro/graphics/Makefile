include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR_RAW = ../../../../utils/hgr-utils/png2dhgr_raw
PNG_TO_DHGR4 = ../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../linker_scripts/

all:	logo_dSr_D2.bin.zx02 logo_dSr_D2.aux.zx02 \
	logo_dSr_D2.raw_top.zx02 logo_dSr_D2.raw_bottom.zx02 \
	logo_grafA.bin.zx02 logo_grafA.aux.zx02 \
	logo_grafA.raw_top.zx02 logo_grafA.raw_bottom.zx02 \
	logo_pump-kin.bin.zx02 logo_pump-kin.aux.zx02 \
	logo_splatdsr.bin.zx02 logo_splatdsr.aux.zx02 \
	ms_title.hgr.zx02

####

ms_title.hgr.zx02:	ms_title.hgr
	$(ZX02) ms_title.hgr ms_title.hgr.zx02

ms_title.hgr:  ms_title.png
	$(PNG_TO_HGR) ms_title.png > ms_title.hgr

####

logo_dSr_D2.aux.zx02:     logo_dSr_D2.AUX
	$(ZX02) logo_dSr_D2.AUX logo_dSr_D2.aux.zx02

logo_dSr_D2.AUX:  logo_dSr_D2.png
	$(PNG_TO_DHGR) logo_dSr_D2.png logo_dSr_D2

logo_dSr_D2.bin.zx02:     logo_dSr_D2.BIN
	$(ZX02) logo_dSr_D2.BIN logo_dSr_D2.bin.zx02

logo_dSr_D2.BIN: logo_dSr_D2.png
	$(PNG_TO_DHGR) logo_dSr_D2.png logo_dSr_D2

####

logo_dSr_D2.raw_top.zx02:     logo_dSr_D2.raw_top
	$(ZX02) logo_dSr_D2.raw_top logo_dSr_D2.raw_top.zx02

logo_dSr_D2.raw_top:  logo_dSr_D2.png
	$(PNG_TO_DHGR_RAW) -t logo_dSr_D2.png logo_dSr_D2

logo_dSr_D2.raw_bottom.zx02:     logo_dSr_D2.raw_bottom
	$(ZX02) logo_dSr_D2.raw_bottom logo_dSr_D2.raw_bottom.zx02

logo_dSr_D2.raw_bottom: logo_dSr_D2.png
	$(PNG_TO_DHGR_RAW) -t logo_dSr_D2.png logo_dSr_D2

####

logo_grafA.aux.zx02:     logo_grafA.AUX
	$(ZX02) logo_grafA.AUX logo_grafA.aux.zx02

logo_grafA.AUX:  logo_grafA.png
	$(PNG_TO_DHGR) logo_grafA.png logo_grafA

logo_grafA.bin.zx02:     logo_grafA.BIN
	$(ZX02) logo_grafA.BIN logo_grafA.bin.zx02

logo_grafA.BIN: logo_grafA.png
	$(PNG_TO_DHGR) logo_grafA.png logo_grafA

####

logo_grafA.raw_top.zx02:     logo_grafA.raw_top
	$(ZX02) logo_grafA.raw_top logo_grafA.raw_top.zx02

logo_grafA.raw_top:  logo_grafA.png
	$(PNG_TO_DHGR_RAW) -t logo_grafA.png logo_grafA

logo_grafA.raw_bottom.zx02:     logo_grafA.raw_bottom
	$(ZX02) logo_grafA.raw_bottom logo_grafA.raw_bottom.zx02

logo_grafA.raw_bottom: logo_grafA.png
	$(PNG_TO_DHGR_RAW) -t logo_grafA.png logo_grafA


####

logo_pump-kin.aux.zx02:     logo_pump-kin.AUX
	$(ZX02) logo_pump-kin.AUX logo_pump-kin.aux.zx02

logo_pump-kin.AUX:  logo_pump-kin.png
	$(PNG_TO_DHGR) logo_pump-kin.png logo_pump-kin

logo_pump-kin.bin.zx02:     logo_pump-kin.BIN
	$(ZX02) logo_pump-kin.BIN logo_pump-kin.bin.zx02

logo_pump-kin.BIN: logo_pump-kin.png
	$(PNG_TO_DHGR) logo_pump-kin.png logo_pump-kin

####

logo_splatdsr.aux.zx02:     logo_splatdsr.AUX
	$(ZX02) logo_splatdsr.AUX logo_splatdsr.aux.zx02

logo_splatdsr.AUX:  logo_splatdsr.png
	$(PNG_TO_DHGR) logo_splatdsr.png logo_splatdsr

logo_splatdsr.bin.zx02:     logo_splatdsr.BIN
	$(ZX02) logo_splatdsr.BIN logo_splatdsr.bin.zx02

logo_splatdsr.BIN: logo_splatdsr.png
	$(PNG_TO_DHGR) logo_splatdsr.png logo_splatdsr



####

clean:
	rm -f *~ *.zx02 *.lst *.o *.AUX *.BIN *.raw_top *.raw_bottom
