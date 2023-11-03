include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	igl.hgr.zx02 igr.hgr.zx02 fc_sr_logo.hgr.zx02 \
	demosplash.hgr.zx02 mockingboard.hgr.zx02 \
	vmw.hgr.zx02 ship_sprites.hgr.zx02

####

fc_sr_logo.hgr.zx02:	fc_sr_logo.hgr
	$(ZX02) fc_sr_logo.hgr fc_sr_logo.hgr.zx02

fc_sr_logo.hgr:	fc_sr_logo.png
	$(PNG_TO_HGR) fc_sr_logo.png > fc_sr_logo.hgr

####

igl.hgr.zx02:	igl.hgr
	$(ZX02) igl.hgr igl.hgr.zx02

igl.hgr:	igl.png
	$(PNG_TO_HGR) igl.png > igl.hgr

####

ship_sprites.hgr.zx02:	ship_sprites.hgr
	$(ZX02) ship_sprites.hgr ship_sprites.hgr.zx02

ship_sprites.hgr:	ship_sprites.png
	$(PNG_TO_HGR) ship_sprites.png > ship_sprites.hgr

####

mockingboard.hgr.zx02:	mockingboard.hgr
	$(ZX02) mockingboard.hgr mockingboard.hgr.zx02

mockingboard.hgr:	mockingboard.png
	$(PNG_TO_HGR) mockingboard.png > mockingboard.hgr

####

demosplash.hgr.zx02:	demosplash.hgr
	$(ZX02) demosplash.hgr demosplash.hgr.zx02

demosplash.hgr:	demosplash.png
	$(PNG_TO_HGR) demosplash.png > demosplash.hgr



####

igr.hgr.zx02:	igr.hgr
	$(ZX02) igr.hgr igr.hgr.zx02

igr.hgr:	igr.png
	$(PNG_TO_HGR) igr.png > igr.hgr

####

vmw.hgr.zx02:	vmw.hgr
	$(ZX02) vmw.hgr vmw.hgr.zx02

vmw.hgr:	vmw.png
	$(PNG_TO_HGR) vmw.png > vmw.hgr


####



####

clean:
	rm -f *~ *.zx02
