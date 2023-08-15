include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr

all:	icekngdm.hgr.zx02 mntscrl3.hgr.zx02 final3.hgr.zx02 fc_sr_logo.hgr.zx02

####

icekngdm.hgr.zx02:	icekngdm.hgr
	$(ZX02) icekngdm.hgr icekngdm.hgr.zx02

####

mntscrl3.hgr.zx02:	mntscrl3.hgr
	$(ZX02) mntscrl3.hgr mntscrl3.hgr.zx02

####

final3.hgr.zx02:	final3.hgr
	$(ZX02) final3.hgr final3.hgr.zx02

####

fc_sr_logo.hgr.zx02:	fc_sr_logo.hgr
	$(ZX02) fc_sr_logo.hgr fc_sr_logo.hgr.zx02


####

clean:
	rm -f *~
