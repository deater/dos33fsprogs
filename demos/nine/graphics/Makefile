ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_DHGR = ../../../utils/hgr-utils/png2dhgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	a2_nine_woz.aux.zx02 a2_nine_woz.bin.zx02

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


