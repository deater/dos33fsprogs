HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	bow_sprites.inc flag_sprites.inc arrow_sprites.inc

bow_sprites.inc:	bow_sprites.png
	$(HGR_SPRITE) -s -l bow_sprite_odd0 bow_sprites.png  21 159  76 183 > bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_odd1 bow_sprites.png  77 159 125 183 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_odd2 bow_sprites.png 126 159 174 183 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_odd3 bow_sprites.png 175 159 230 183 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_sprite_odd0 bow_sprites.png  35 183 125 184 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_sprite_odd1 bow_sprites.png 126 183 216 184 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_even0 bow_sprites.png  14   7  69  31 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_even1 bow_sprites.png  70   7 118  31 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_even2 bow_sprites.png 119   7 167  31 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_even3 bow_sprites.png 168   7 223  31 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_sprite_even0 bow_sprites.png  28 31 118 32 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_sprite_even1 bow_sprites.png 119 31 209 32 >> bow_sprites.inc

flag_sprites.inc:	flag_sprites.png
	$(HGR_SPRITE) -s -l flag_nowind0 flag_sprites.png  14   0  41  37 > flag_sprites.inc
	$(HGR_SPRITE) -s -l flag_rwindl0 flag_sprites.png  91   0 125  28 >> flag_sprites.inc
	$(HGR_SPRITE) -s -l flag_rwindl1 flag_sprites.png 161   0 195  28 >> flag_sprites.inc
	$(HGR_SPRITE) -s -l flag_lwindl0 flag_sprites.png   0  72  41 100 >> flag_sprites.inc
	$(HGR_SPRITE) -s -l flag_lwindl1 flag_sprites.png  70  72 111 100 >> flag_sprites.inc
	$(HGR_SPRITE) -s -l flag_lwindh0 flag_sprites.png 140  72 181  83 >> flag_sprites.inc
	$(HGR_SPRITE) -s -l flag_lwindh1 flag_sprites.png   0 140  41 151 >> flag_sprites.inc
	$(HGR_SPRITE) -s -l flag_rwindh0 flag_sprites.png  91 140 132 151 >> flag_sprites.inc
	$(HGR_SPRITE) -s -l flag_rwindh1 flag_sprites.png 161 140 202 151 >> flag_sprites.inc
	$(HGR_SPRITE) -s -l flag_bg0     flag_sprites.png 210 140 272 161 >> flag_sprites.inc
	$(HGR_SPRITE) -s -l flag_bg1     flag_sprites.png 210 161 272 179 >> flag_sprites.inc

arrow_sprites.inc:	arrow_sprites.png
	$(HGR_SPRITE) -s -l l_pointer arrow_sprites.png 245 172 251 181 > arrow_sprites.inc
	$(HGR_SPRITE) -s -l r_pointer arrow_sprites.png 266 172 272 181 >> arrow_sprites.inc
	$(HGR_SPRITE) -l arrow0_sprite arrow_sprites.png 126 104 139 147 >> arrow_sprites.inc
	$(HGR_SPRITE) -l arrow0_mask   arrow_sprites.png 154 104 167 147 >> arrow_sprites.inc






clean:	
	rm -f *~ bow_sprites.inc arrow_sprites.inc

