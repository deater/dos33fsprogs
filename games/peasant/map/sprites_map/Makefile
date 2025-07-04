HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	map_sprites.inc

map_sprites.inc:	map_sprites.png
	$(HGR_SPRITE) -s -l head_sprite  map_sprites.png 210  41 216  49 > map_sprites.inc
	$(HGR_SPRITE) -s -l map00_sprite map_sprites.png  28  67  69  79 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map10_sprite map_sprites.png  70  52 111  81 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map20_sprite map_sprites.png 119  51 160  79 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map30_sprite map_sprites.png 168  58 202  84 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map40_sprite map_sprites.png 203  55 251  84 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map01_sprite map_sprites.png  21  80  62 105 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map11_sprite map_sprites.png  77  98 104 105 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map21_sprite map_sprites.png 112  89 153 105 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map31_sprite map_sprites.png 154  85 195 114 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map41_sprite map_sprites.png 217  85 251 105 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map02_sprite map_sprites.png  42 118  69 136 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map12_sprite map_sprites.png  70 105 104 134 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map22_sprite map_sprites.png 119 106 160 138 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map32_sprite map_sprites.png 161 115 195 138 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map42_sprite map_sprites.png 203 107 244 137 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map03_sprite map_sprites.png  28 145  48 163 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map13_sprite map_sprites.png  70 139  90 160 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map23_sprite map_sprites.png 112 157 153 166 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map33_sprite map_sprites.png 161 144 202 166 >> map_sprites.inc
	$(HGR_SPRITE) -s -l map43_sprite map_sprites.png 203 143 237 165 >> map_sprites.inc
	$(HGR_SPRITE) -s -l nohead_sprite  map_sprites.png 224  41 230  49 >> map_sprites.inc









clean:
	rm -f *~ \
		map_sprites.inc


