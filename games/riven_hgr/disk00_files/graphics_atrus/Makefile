include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	atrus_graphics.inc

atrus_graphics.inc:	\
	atrus1_iipix.hgr.zx02 \
	atrus2_iipix.hgr.zx02 \
	atrus3_iipix.hgr.zx02 \
	atrus4_iipix.hgr.zx02 \
	atrus5_iipix.hgr.zx02 \
	atrus6_iipix.hgr.zx02 \
	atrus7_iipix.hgr.zx02 \
	atrus8_iipix.hgr.zx02 \
	atrus9_iipix.hgr.zx02 \
	atrus10_iipix.hgr.zx02 \
	book_combined.zx02
	echo "atrus1_zx02: .incbin \"atrus1_iipix.hgr.zx02\"" > atrus_graphics.inc
	echo "atrus2_zx02: .incbin \"atrus2_iipix.hgr.zx02\"" >> atrus_graphics.inc
	echo "atrus3_zx02: .incbin \"atrus3_iipix.hgr.zx02\"" >> atrus_graphics.inc
	echo "atrus4_zx02: .incbin \"atrus4_iipix.hgr.zx02\"" >> atrus_graphics.inc
	echo "atrus5_zx02: .incbin \"atrus5_iipix.hgr.zx02\"" >> atrus_graphics.inc
	echo "atrus6_zx02: .incbin \"atrus6_iipix.hgr.zx02\"" >> atrus_graphics.inc
	echo "atrus7_zx02: .incbin \"atrus7_iipix.hgr.zx02\"" >> atrus_graphics.inc
	echo "atrus8_zx02: .incbin \"atrus8_iipix.hgr.zx02\"" >> atrus_graphics.inc
	echo "atrus9_zx02: .incbin \"atrus9_iipix.hgr.zx02\"" >> atrus_graphics.inc
	echo "atrus10_zx02: .incbin \"atrus10_iipix.hgr.zx02\"" >> atrus_graphics.inc
	echo "atrus11_zx02: .incbin \"book_combined.zx02\"" >> atrus_graphics.inc
#	echo "atrus11_zx02: .incbin \"atrus11_iipix.hgr.zx02\"" >> atrus_graphics.inc


####

book_combined.zx02:	atrus11_iipix.hgr atrus15_iipix.hgr
	cat atrus11_iipix.hgr > book_combined
	cat atrus15_iipix.hgr >> book_combined
	$(ZX02) -f book_combined book_combined.zx02

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr atrus_graphics.inc book_combined

