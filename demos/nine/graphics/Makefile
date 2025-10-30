ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_DHGR = ../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR_RAW = ../../../utils/hgr-utils/png2dhgr_raw
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	a2_nine_woz.aux.zx02 a2_nine_woz.bin.zx02 \
	new_woz.raw_top.zx02 new_woz.raw_bottom.zx02

####

new_woz.raw_top.zx02:	new_woz.raw_top
	$(ZX02) new_woz.raw_top new_woz.raw_top.zx02

new_woz.raw_top:	new_woz.png
	$(PNG_TO_DHGR_RAW) -t new_woz.png new_woz

new_woz.raw_bottom.zx02:	new_woz.raw_bottom
	$(ZX02) new_woz.raw_bottom new_woz.raw_bottom.zx02

new_woz.raw_bottom:	new_woz.png
	$(PNG_TO_DHGR_RAW) -t new_woz.png new_woz

####

a2_nine_woz.aux.zx02:	a2_nine_woz.AUX
	$(ZX02) a2_nine_woz.AUX a2_nine_woz.aux.zx02

a2_nine_woz.AUX:	a2_nine_woz.png
	$(PNG_TO_DHGR) a2_nine_woz.png a2_nine_woz

a2_nine_woz.bin.zx02:	a2_nine_woz.BIN
	$(ZX02) a2_nine_woz.BIN a2_nine_woz.bin.zx02

a2_nine_woz.BIN:	a2_nine_woz.png
	$(PNG_TO_DHGR) a2_nine_woz.png a2_nine_woz

####


