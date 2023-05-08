include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_DGR = ../../../utils/gr-utils/png2dgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	dlores_plain.dsk

####

DLORES:	dlores_plain.o
	ld65 -o DLORES dlores_plain.o -C $(LINKER_SCRIPTS)/apple2_1000.inc

dlores_plain.o:	dlores_plain.s ../dlores_main.s ../zx02_optim.s \
		../zp.inc ../hardware.inc
	ca65 -o dlores_plain.o dlores_plain.s -l dlores_plain.lst
####

HELLO:	../hello.bas
	$(TOKENIZE) < ../hello.bas > HELLO

####

dlores_plain.dsk:	HELLO DLORES\
		myst.gr.main.zx02 myst.gr.aux.zx02\
		channelwood.gr.main.zx02 channelwood.gr.aux.zx02\
		selenetic.gr.main.zx02 selenetic.gr.aux.zx02\
		sworg_dgr.gr.main.zx02 sworg_dgr.gr.aux.zx02\
		dgr_test_bar.gr.main.zx02 dgr_test_bar.gr.aux.zx02
	cp $(EMPTY_DISK) dlores_plain.dsk
	$(DOS33) -y dlores_plain.dsk SAVE A HELLO
	$(DOS33) -y dlores_plain.dsk BSAVE -a 0x1000 DLORES
	$(DOS33) -y dlores_plain.dsk BSAVE -a 0xa000 myst.gr.main.zx02 MYST.MAIN.ZX02
	$(DOS33) -y dlores_plain.dsk BSAVE -a 0xa000 myst.gr.aux.zx02 MYST.AUX.ZX02
	$(DOS33) -y dlores_plain.dsk BSAVE -a 0xa000 channelwood.gr.main.zx02 CHANNEL.MAIN.ZX02
	$(DOS33) -y dlores_plain.dsk BSAVE -a 0xa000 channelwood.gr.aux.zx02 CHANNEL.AUX.ZX02
	$(DOS33) -y dlores_plain.dsk BSAVE -a 0xa000 selenetic.gr.main.zx02 SELEN.MAIN.ZX02
	$(DOS33) -y dlores_plain.dsk BSAVE -a 0xa000 selenetic.gr.aux.zx02 SELEN.AUX.ZX02
	$(DOS33) -y dlores_plain.dsk BSAVE -a 0xa000 sworg_dgr.gr.main.zx02 SWORG.MAIN.ZX02
	$(DOS33) -y dlores_plain.dsk BSAVE -a 0xa000 sworg_dgr.gr.aux.zx02 SWORG.AUX.ZX02
	$(DOS33) -y dlores_plain.dsk BSAVE -a 0xa000 dgr_test_bar.gr.main.zx02 TEST.MAIN.ZX02
	$(DOS33) -y dlores_plain.dsk BSAVE -a 0xa000 dgr_test_bar.gr.aux.zx02 TEST.AUX.ZX02
####

clean:
	rm -f *~ *.o *.lst

