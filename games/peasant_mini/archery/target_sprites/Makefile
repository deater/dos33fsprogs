HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	bow_sprites.inc flag_sprites.inc arrow_sprites.inc

bow_sprites.inc:	bow_sprites.png bow_drawn.png
	$(HGR_SPRITE) -s -l bow_sprite_odd0 bow_sprites.png  28 168  76 183 > bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_odd1 bow_sprites.png  77 159 125 183 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_odd2 bow_sprites.png 126 159 174 183 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_odd3 bow_sprites.png 175 168 223 183 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_sprite_odd0 bow_sprites.png  35 183 125 184 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_sprite_odd1 bow_sprites.png 126 183 216 184 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_even0 bow_sprites.png  21  16  69  31 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_even1 bow_sprites.png  70   7 118  31 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_even2 bow_sprites.png 119   7 167  31 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_even3 bow_sprites.png 168  16 216  31 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_sprite_even0 bow_sprites.png  28 31 118 32 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_sprite_even1 bow_sprites.png 119 31 209 32 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_drawn_even0 bow_drawn.png  35  31  69  40 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_drawn_even1 bow_drawn.png 161  31 202  40 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_drawn_odd0  bow_drawn.png  42 183  76 192 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_drawn_odd1  bow_drawn.png 168 183 209 192 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l circle_sprite      bow_sprites.png 14  77 27  88 >> bow_sprites.inc


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

arrow_sprites.inc:	arrow_sprites.png arrows_moving.png
	$(HGR_SPRITE) -s -l l_pointer arrow_sprites.png 245 172 251 181 > arrow_sprites.inc
	$(HGR_SPRITE) -s -l r_pointer arrow_sprites.png 266 172 272 181 >> arrow_sprites.inc
	$(HGR_SPRITE) -s -l l_pointer_erase arrow_sprites.png 245 152 251 161 >> arrow_sprites.inc
	$(HGR_SPRITE) -s -l r_pointer_erase arrow_sprites.png 266 152 272 161 >> arrow_sprites.inc
	$(HGR_SPRITE) -s -l arrow_odd_sprite arrow_sprites.png  119   6 132 49 >> arrow_sprites.inc
	$(HGR_SPRITE) -s -l arrow_even_sprite arrow_sprites.png 126 149 139 192 >> arrow_sprites.inc
	$(HGR_SPRITE) -s -l arrow_nostring_odd_sprite  arrow_sprites.png  7 77 20 120 >> arrow_sprites.inc
	$(HGR_SPRITE) -s -l arrow_nostring_even_sprite arrow_sprites.png 28 77 41 120 >> arrow_sprites.inc
	$(HGR_SPRITE) -s -l arrow_delete_sprite arrow_sprites.png 70 48 76 72 >> arrow_sprites.inc
	$(HGR_SPRITE) -s -l meter_bottom arrow_sprites.png 252 63 265 93 >> arrow_sprites.inc
	$(HGR_SPRITE) -l shoot0e_sprite arrows_moving.png  28   3  41  33 >> arrow_sprites.inc
	$(HGR_SPRITE) -l shoot0e_mask   arrows_moving.png  28  34  41  64 >> arrow_sprites.inc
	$(HGR_SPRITE) -l shoot1e_sprite arrows_moving.png  56   3  69  15 >> arrow_sprites.inc
	$(HGR_SPRITE) -l shoot1e_mask   arrows_moving.png  56  34  69  46 >> arrow_sprites.inc
	$(HGR_SPRITE) -l shoot2e_sprite arrows_moving.png  84   3  97  11 >> arrow_sprites.inc
	$(HGR_SPRITE) -l shoot2e_mask   arrows_moving.png  84  34  97  42 >> arrow_sprites.inc
	$(HGR_SPRITE) -l hit1e_sprite   arrows_moving.png 112   3 125   8 >> arrow_sprites.inc
	$(HGR_SPRITE) -l hit1e_mask     arrows_moving.png 112  34 125  39 >> arrow_sprites.inc
	$(HGR_SPRITE) -l hit2e_sprite   arrows_moving.png 140   3 153   9 >> arrow_sprites.inc
	$(HGR_SPRITE) -l hit2e_mask     arrows_moving.png 140  34 153  40 >> arrow_sprites.inc
	$(HGR_SPRITE) -l miss1e_sprite  arrows_moving.png  28  68  41  77 >> arrow_sprites.inc
	$(HGR_SPRITE) -l miss1e_mask    arrows_moving.png  28  84  41  93 >> arrow_sprites.inc
	$(HGR_SPRITE) -l miss2e_sprite  arrows_moving.png  56  68  69  77 >> arrow_sprites.inc
	$(HGR_SPRITE) -l miss2e_mask    arrows_moving.png  56  84  69  93 >> arrow_sprites.inc
	$(HGR_SPRITE) -l miss3e_sprite  arrows_moving.png  84  68  97  77 >> arrow_sprites.inc
	$(HGR_SPRITE) -l miss3e_mask    arrows_moving.png  84  84  97  93 >> arrow_sprites.inc
	$(HGR_SPRITE) -l miss4e_sprite  arrows_moving.png 112  68 125  76 >> arrow_sprites.inc
	$(HGR_SPRITE) -l miss4e_mask    arrows_moving.png 112  84 125  92 >> arrow_sprites.inc
	$(HGR_SPRITE) -l miss5e_sprite  arrows_moving.png 140  68 153  76 >> arrow_sprites.inc
	$(HGR_SPRITE) -l miss5e_mask    arrows_moving.png 140  84 153  92 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l shoot0o_sprite arrows_moving.png  21 100  34 130 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l shoot0o_mask   arrows_moving.png  21 131  34 161 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l shoot1o_sprite arrows_moving.png  49 100  62 112 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l shoot1o_mask   arrows_moving.png  49 131  62 143 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l shoot2o_sprite arrows_moving.png  77 100  90 108 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l shoot2o_mask   arrows_moving.png  77 131  90 139 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l hit1o_sprite   arrows_moving.png 105 100 118 105 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l hit1o_mask     arrows_moving.png 105 131 118 136 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l hit2o_sprite   arrows_moving.png 133 100 146 106 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l hit2o_mask     arrows_moving.png 133 131 146 137 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l miss1o_sprite  arrows_moving.png  21 165  34 174 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l miss1o_mask    arrows_moving.png  21 181  34 190 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l miss2o_sprite  arrows_moving.png  49 165  62 174 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l miss2o_mask    arrows_moving.png  49 181  62 190 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l miss3o_sprite  arrows_moving.png  77 165  90 174 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l miss3o_mask    arrows_moving.png  77 181  90 190 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l miss4o_sprite  arrows_moving.png 105 165 118 173 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l miss4o_mask    arrows_moving.png 105 181 118 189 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l miss5o_sprite  arrows_moving.png 133 165 146 173 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l miss5o_mask    arrows_moving.png 133 181 146 189 >> arrow_sprites.inc

#	$(HGR_SPRITE) -l arrow0_sprite arrow_sprites.png 126 104 139 147 >> arrow_sprites.inc
#	$(HGR_SPRITE) -l arrow0_mask   arrow_sprites.png 154 104 167 147 >> arrow_sprites.inc

clean:	
	rm -f *~ bow_sprites.inc arrow_sprites.inc

