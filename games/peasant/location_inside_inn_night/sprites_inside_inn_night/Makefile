HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	sleep_sprites.inc pantry_sprites.inc

sleep_sprites.inc:	peasant_sleeping.png
	$(HGR_SPRITE) -s -l sleep0 peasant_sleeping.png 224 131 258 142 > sleep_sprites.inc
	$(HGR_SPRITE) -s -l sleep1 peasant_sleeping.png 140 131 174 142 >> sleep_sprites.inc
	$(HGR_SPRITE) -s -l sleep2 peasant_sleeping.png  56 131  90 142 >> sleep_sprites.inc

# FIXME: if we run out of room we could be more efficient with the sprites here
pantry_sprites.inc:	peasant_pot.png
	$(HGR_SPRITE) -s -l pantry_peasant0 peasant_pot.png  70  68  83  98 > pantry_sprites.inc
	$(HGR_SPRITE) -s -l pantry_peasant1 peasant_pot.png 112  68 132  98 >> pantry_sprites.inc
	$(HGR_SPRITE) -s -l pantry_peasant2 peasant_pot.png  28 138  48 168 >> pantry_sprites.inc
	$(HGR_SPRITE) -s -l pantry_peasant3 peasant_pot.png  70 138  83 168 >> pantry_sprites.inc
	$(HGR_SPRITE) -s -l pantry_peasant4 peasant_pot.png 112 135 125 168 >> pantry_sprites.inc
	$(HGR_SPRITE) -s -l pantry_peasant5 peasant_pot.png 238  67 251  98 >> pantry_sprites.inc
	$(HGR_SPRITE) -s -l pantry_peasant6 peasant_pot.png 238 137 251 168 >> pantry_sprites.inc
	$(HGR_SPRITE) -s -l pantry_no_pot   peasant_pot.png 189  42 202  51 >> pantry_sprites.inc
	$(HGR_SPRITE) -s -l pantry_pot0     peasant_pot.png 140 111 160 122 >> pantry_sprites.inc
	$(HGR_SPRITE) -s -l pantry_pot1     peasant_pot.png 182 110 202 122 >> pantry_sprites.inc	
	$(HGR_SPRITE) -s -l pantry_pot2     peasant_pot.png 231 111 244 122 >> pantry_sprites.inc	
	$(HGR_SPRITE) -s -l pantry_pot3     peasant_pot.png 147  46 167  58 >> pantry_sprites.inc	
	$(HGR_SPRITE) -s -l pantry_pot4     peasant_pot.png 196  55 209  64 >> pantry_sprites.inc	
	$(HGR_SPRITE) -s -l pantry_pot5     peasant_pot.png  21  42  34  51 >> pantry_sprites.inc



	








clean:
	rm -f *~ \
		sleep_sprites.inc pantry_sprites.inc


