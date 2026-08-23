;sprites_mask_l:
	.byte <kerrek_walk0l_mask,<kerrek_walk1l_mask
	.byte <kerrek_walk2l_mask,<kerrek_walk3l_mask
	.byte <kerrek_walk4l_mask,<kerrek_walk5l_mask
	.byte <kerrek_walk6l_mask,<kerrek_walk7l_mask

;sprites_mask_h:
	.byte >kerrek_walk0l_mask,>kerrek_walk1l_mask
	.byte >kerrek_walk2l_mask,>kerrek_walk3l_mask
	.byte >kerrek_walk4l_mask,>kerrek_walk5l_mask
	.byte >kerrek_walk6l_mask,>kerrek_walk7l_mask

;sprites_data_l:
	.byte <kerrek_walk0l_sprite,<kerrek_walk1l_sprite
	.byte <kerrek_walk2l_sprite,<kerrek_walk3l_sprite
	.byte <kerrek_walk4l_sprite,<kerrek_walk5l_sprite
	.byte <kerrek_walk6l_sprite,<kerrek_walk7l_sprite

;sprites_data_h:
	.byte >kerrek_walk0l_sprite,>kerrek_walk1l_sprite
	.byte >kerrek_walk2l_sprite,>kerrek_walk3l_sprite
	.byte >kerrek_walk4l_sprite,>kerrek_walk5l_sprite
	.byte >kerrek_walk6l_sprite,>kerrek_walk7l_sprite

;sprites_xsize:
	.byte 3,3,3,3, 3,3,3,3

;sprites_ysize:
	.byte 48,48,48,48, 48,48,48,48

	.include "sprites_kerrek_fall/kerrek_walk_sprites_left.inc"


