DHGR_SPRITE = ../../../utils/hgr-utils/dhgr_make_sprite

all:	numbers.inc \
	ball_sprites.inc


numbers.inc:	a2_nine.png
	$(DHGR_SPRITE) -s -l one a2_nine.png 14 7  41 28 > numbers.inc

ball_sprites.inc:	ball_sprites.png
	$(DHGR_SPRITE) -s -l red0 ball_sprites.png 14  28  41  42 > ball_sprites.inc
	$(DHGR_SPRITE) -s -l red1 ball_sprites.png 14  43  41  57 >> ball_sprites.inc
	$(DHGR_SPRITE) -s -l red2 ball_sprites.png 14  58  41  72 >> ball_sprites.inc
	$(DHGR_SPRITE) -s -l red3 ball_sprites.png 14  73  41  87 >> ball_sprites.inc
	$(DHGR_SPRITE) -s -l red4 ball_sprites.png 14  88  41 102 >> ball_sprites.inc
	$(DHGR_SPRITE) -s -l red5 ball_sprites.png 14 103  41 117 >> ball_sprites.inc
	$(DHGR_SPRITE) -s -l red6 ball_sprites.png 14 118  41 132 >> ball_sprites.inc




clean:
	rm -f *~ numbers.inc

