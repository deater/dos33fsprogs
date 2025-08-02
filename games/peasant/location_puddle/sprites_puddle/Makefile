HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	mud_sprites.inc fall_sprites.inc

mud_sprites.inc:	mud.png
	$(HGR_SPRITE) -s -l mud_sprite0 mud.png  77 126 188 140 > mud_sprites.inc
	$(HGR_SPRITE) -s -l mud_sprite1 mud.png  77 140 188 154 >> mud_sprites.inc

fall_sprites.inc:	slip.png
	$(HGR_SPRITE) -l fall0_sprite  slip.png  14 112  27 142 > slip_sprites.inc
	$(HGR_SPRITE) -l fall1_sprite  slip.png  42 112  69 141 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall2_sprite  slip.png  84 122 111 140 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall3_sprite  slip.png 126 116 153 140 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall4_sprite  slip.png 168 110 181 140 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall5_sprite  slip.png  14  17  41  29 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall6_sprite  slip.png  56  17  83  29 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall7_sprite  slip.png  98  17 125  29 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall8_sprite  slip.png 140  17 167  29 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall9_sprite  slip.png 182  17 209  29 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall10_sprite slip.png 224  20 251  29 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall11_sprite slip.png 266  20 279  29 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall12_sprite slip.png 196 127 209 140 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall13_sprite slip.png 224 117 237 140 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall14_sprite slip.png 252 110 265 140 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall0_mask    slip.png  14 147  27 177 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall1_mask    slip.png  42 147  69 176 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall2_mask    slip.png  84 157 111 175 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall3_mask    slip.png 126 152 153 175 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall4_mask    slip.png 168 145 181 175 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall5_mask    slip.png  14  32  41  44 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall6_mask    slip.png  56  32  83  44 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall7_mask    slip.png  98  32 125  44 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall8_mask    slip.png 140  32 167  44 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall9_mask    slip.png 182  32 209  44 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall10_mask   slip.png 224  35 251  44 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall11_mask   slip.png 266  35 279  44 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall12_mask   slip.png 196 162 209 175 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall13_mask   slip.png 224 152 237 175 >> slip_sprites.inc
	$(HGR_SPRITE) -l fall14_mask   slip.png 252 145 265 175 >> slip_sprites.inc

clean:
	rm -f *~ mud_sprites.inc slip_sprites.inc
