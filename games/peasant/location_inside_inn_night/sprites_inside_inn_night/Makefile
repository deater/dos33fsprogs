HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	sleep_sprites.inc

sleep_sprites.inc:	peasant_sleeping.png
	$(HGR_SPRITE) -s -l sleep0 peasant_sleeping.png 224 131 258 142 > sleep_sprites.inc
	$(HGR_SPRITE) -s -l sleep1 peasant_sleeping.png 140 131 174 142 >> sleep_sprites.inc
	$(HGR_SPRITE) -s -l sleep2 peasant_sleeping.png  56 131  90 142 >> sleep_sprites.inc


clean:
	rm -f *~ \
		sleep_sprites.inc


