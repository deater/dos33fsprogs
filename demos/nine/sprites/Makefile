DHGR_SPRITE = ../../../utils/hgr-utils/dhgr_make_sprite

all:	numbers.inc


numbers.inc:	a2_nine.png
	$(DHGR_SPRITE) -s -l one a2_nine.png 14 7  41 28 > numbers.inc

clean:
	rm -f *~ numbers.inc

