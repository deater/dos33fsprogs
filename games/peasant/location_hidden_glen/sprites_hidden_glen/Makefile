HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	archer_sprites.inc leaving_sprites.inc

archer_sprites.inc:	sprites_hidden_glen.png
	$(HGR_SPRITE) -s -l archer0 sprites_hidden_glen.png 161 154 181 185 > archer_sprites.inc
	$(HGR_SPRITE) -s -l archer1 sprites_hidden_glen.png 133  81 153 112 >> archer_sprites.inc
	$(HGR_SPRITE) -s -l archer2 sprites_hidden_glen.png 161  81 181 112 >> archer_sprites.inc
	$(HGR_SPRITE) -s -l archer3 sprites_hidden_glen.png 189  81 209 112 >> archer_sprites.inc
	$(HGR_SPRITE) -s -l archer4 sprites_hidden_glen.png 217  81 237 112 >> archer_sprites.inc
	$(HGR_SPRITE) -s -l archer5 sprites_hidden_glen.png 105 119 132 150 >> archer_sprites.inc
	$(HGR_SPRITE) -s -l archer6 sprites_hidden_glen.png 161 119 188 150 >> archer_sprites.inc
	$(HGR_SPRITE) -s -l archer7 sprites_hidden_glen.png 217 119 244 150 >> archer_sprites.inc
	$(HGR_SPRITE) -s -l archer8 sprites_hidden_glen.png 105 154 125 185 >> archer_sprites.inc
	$(HGR_SPRITE) -s -l archer9 sprites_hidden_glen.png 133 154 153 185 >> archer_sprites.inc
	$(HGR_SPRITE) -s -l arrow0 sprites_hidden_glen.png  140  54 160  59 >> archer_sprites.inc
	$(HGR_SPRITE) -s -l arrow1 sprites_hidden_glen.png  133  63 153  68 >> archer_sprites.inc
	$(HGR_SPRITE) -s -l arrow2 sprites_hidden_glen.png  105  36 125  41 >> archer_sprites.inc
	$(HGR_SPRITE) -s -l arrow3 sprites_hidden_glen.png   91  85 111  90 >> archer_sprites.inc

leaving_sprites.inc:	sprites_leaving.png
	$(HGR_SPRITE) -l leaving0_sprite sprites_leaving.png  14  63 27  96 > leaving_sprites.inc
	$(HGR_SPRITE) -l leaving1_sprite sprites_leaving.png  42  63 55  96 >> leaving_sprites.inc
	$(HGR_SPRITE) -l leaving2_sprite sprites_leaving.png  70  63 83  96 >> leaving_sprites.inc
	$(HGR_SPRITE) -l leaving0_mask   sprites_leaving.png  14 105 27 138 >> leaving_sprites.inc
	$(HGR_SPRITE) -l leaving1_mask   sprites_leaving.png  42 105 55 138 >> leaving_sprites.inc
	$(HGR_SPRITE) -l leaving2_mask   sprites_leaving.png  70 105 83 138 >> leaving_sprites.inc


clean:
	rm -f *~ \
		archer_sprites.inc leaving_sprites.inc


