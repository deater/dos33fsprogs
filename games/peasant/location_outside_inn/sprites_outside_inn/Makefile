HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	sprites_inn.inc pot_remove.inc


sprites_inn.inc:	sprites_inn.png
	$(HGR_SPRITE) -s -l note_sprite sprites_inn.png 63 100  76 113 > sprites_inn.inc

pot_remove.inc:	pot_remove.png
	$(HGR_SPRITE) -s -l peasant_bottom pot_remove.png  28 40  41  56 > pot_remove.inc
	$(HGR_SPRITE) -s -l peasant_top0   pot_remove.png  21 23  48  40 >> pot_remove.inc
	$(HGR_SPRITE) -s -l peasant_top1   pot_remove.png  63 24  90  40 >> pot_remove.inc
	$(HGR_SPRITE) -s -l peasant_top2   pot_remove.png 105 24 132  40 >> pot_remove.inc
	$(HGR_SPRITE) -s -l peasant_top3   pot_remove.png 147 15 167  40 >> pot_remove.inc
	$(HGR_SPRITE) -s -l peasant_top4   pot_remove.png 189 16 216  40 >> pot_remove.inc
	$(HGR_SPRITE) -s -l peasant_top5   pot_remove.png 231 21 258  40 >> pot_remove.inc
	$(HGR_SPRITE) -s -l peasant_top6   pot_remove.png 147 87 174 103 >> pot_remove.inc









clean:
	rm -f *~ sprites_inn.inc pot_remove.inc

