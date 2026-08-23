;sprites_mask_l:
	.byte <kerrek_hit_right0_mask,<kerrek_hit_right1_mask
	.byte <kerrek_hit_right2_mask,<kerrek_hit_right3_mask
	.byte <kerrek_hit_right4_mask,<kerrek_hit_right5_mask
	.byte <kerrek_hit_right6_mask

;sprites_mask_h:
	.byte >kerrek_hit_right0_mask,>kerrek_hit_right1_mask
	.byte >kerrek_hit_right2_mask,>kerrek_hit_right3_mask
	.byte >kerrek_hit_right4_mask,>kerrek_hit_right5_mask
	.byte >kerrek_hit_right6_mask

;sprites_data_l:
	.byte <kerrek_hit_right0_sprite,<kerrek_hit_right1_sprite
	.byte <kerrek_hit_right2_sprite,<kerrek_hit_right3_sprite
	.byte <kerrek_hit_right4_sprite,<kerrek_hit_right5_sprite
	.byte <kerrek_hit_right6_sprite

;sprites_data_h:
	.byte >kerrek_hit_right0_sprite,>kerrek_hit_right1_sprite
	.byte >kerrek_hit_right2_sprite,>kerrek_hit_right3_sprite
	.byte >kerrek_hit_right4_sprite,>kerrek_hit_right5_sprite
	.byte >kerrek_hit_right6_sprite

;sprites_xsize:
	.byte 3,3,3,3, 3,3,3

;sprites_ysize:
	.byte 48,48,48,48, 48,48,48

	.include "sprites_kerrek_fall/kerrek_hit_sprites_right.inc"
