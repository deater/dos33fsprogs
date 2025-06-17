HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
LINKER_SCRIPTS = ../../../../linker_scripts

all:	title_sprites.inc

####

title_sprites.inc:     title_sprites.png
	$(HGR_SPRITE) -s -l fire0_sprite title_sprites.png  14  10  69   97 > title_sprites.inc
	$(HGR_SPRITE) -s -l fire1_sprite title_sprites.png  84  10  139  97 >> title_sprites.inc
	$(HGR_SPRITE) -s -l fire2_sprite title_sprites.png 154  10  209  97 >> title_sprites.inc
	$(HGR_SPRITE) -s -l direction_sprite title_sprites.png  14  134 174 141 >> title_sprites.inc

clean:	
	rm -f *~ *.zx02 title_sprites.inc

distclean:
	make clean
