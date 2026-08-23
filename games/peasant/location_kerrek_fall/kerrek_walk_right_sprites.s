;sprites_mask_l:
	.byte <kerrek_walk0r_mask,<kerrek_walk1r_mask
	.byte <kerrek_walk2r_mask,<kerrek_walk3r_mask
	.byte <kerrek_walk4r_mask,<kerrek_walk5r_mask
	.byte <kerrek_walk6r_mask,<kerrek_walk7r_mask

;sprites_mask_h:
	.byte >kerrek_walk0r_mask,>kerrek_walk1r_mask
	.byte >kerrek_walk2r_mask,>kerrek_walk3r_mask
	.byte >kerrek_walk4r_mask,>kerrek_walk5r_mask
	.byte >kerrek_walk6r_mask,>kerrek_walk7r_mask

;sprites_data_l:
	.byte <kerrek_walk0r_sprite,<kerrek_walk1r_sprite
	.byte <kerrek_walk2r_sprite,<kerrek_walk3r_sprite
	.byte <kerrek_walk4r_sprite,<kerrek_walk5r_sprite
	.byte <kerrek_walk6r_sprite,<kerrek_walk7r_sprite

;sprites_data_h:
	.byte >kerrek_walk0r_sprite,>kerrek_walk1r_sprite
	.byte >kerrek_walk2r_sprite,>kerrek_walk3r_sprite
	.byte >kerrek_walk4r_sprite,>kerrek_walk5r_sprite
	.byte >kerrek_walk6r_sprite,>kerrek_walk7r_sprite

;sprites_xsize:
	.byte 3,3,3,3, 3,3,3,3

;sprites_ysize:
	.byte 48,48,48,48, 48,48,48,48

	.include "sprites_kerrek_fall/kerrek_walk_sprites_right.inc"


