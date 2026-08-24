;sprites_mask_l:
	.byte <kerrek_hit_left0_mask,<kerrek_hit_left1_mask
	.byte <kerrek_hit_left2_mask,<kerrek_hit_left3_mask
	.byte <kerrek_hit_left4_mask,<kerrek_hit_left5_mask
	.byte <kerrek_hit_left6_mask

;sprites_mask_h:
	.byte >kerrek_hit_left0_mask,>kerrek_hit_left1_mask
	.byte >kerrek_hit_left2_mask,>kerrek_hit_left3_mask
	.byte >kerrek_hit_left4_mask,>kerrek_hit_left5_mask
	.byte >kerrek_hit_left6_mask

;sprites_data_l:
	.byte <kerrek_hit_left0_sprite,<kerrek_hit_left1_sprite
	.byte <kerrek_hit_left2_sprite,<kerrek_hit_left3_sprite
	.byte <kerrek_hit_left4_sprite,<kerrek_hit_left5_sprite
	.byte <kerrek_hit_left6_sprite

;sprites_data_h:
	.byte >kerrek_hit_left0_sprite,>kerrek_hit_left1_sprite
	.byte >kerrek_hit_left2_sprite,>kerrek_hit_left3_sprite
	.byte >kerrek_hit_left4_sprite,>kerrek_hit_left5_sprite
	.byte >kerrek_hit_left6_sprite

;sprites_xsize:
	.byte 4,7,5,6, 7,7,6

;sprites_ysize:
	.byte 48,48,45,45, 23,14,23

	.include "sprites_kerrek_fall/kerrek_hit_sprites_left.inc"
