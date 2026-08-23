KERREK_WALK_OFFSET		= 0
PEASANT_BOW_OFFSET		= 8

sprites_mask_l:
	; KERREK_WALK_OFFSET
	.byte $dd,$dd,$dd,$dd, $dd,$dd,$dd,$dd

;	.byte <kerrek_walk0l_mask,<kerrek_walk1l_mask
;	.byte <kerrek_walk2l_mask,<kerrek_walk3l_mask
;	.byte <kerrek_walk4l_mask,<kerrek_walk5l_mask
;	.byte <kerrek_walk6l_mask,<kerrek_walk7l_mask


	; PEASANT_BOW_OFFSET
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd

sprites_mask_h:
	; KERREK_WALK_OFFSET
	.byte $dd,$dd,$dd,$dd, $dd,$dd,$dd,$dd

;	.byte >kerrek_walk0l_mask,>kerrek_walk1l_mask
;	.byte >kerrek_walk2l_mask,>kerrek_walk3l_mask
;	.byte >kerrek_walk4l_mask,>kerrek_walk5l_mask
;	.byte >kerrek_walk6l_mask,>kerrek_walk7l_mask

;	.byte >kerrek_walk0r_mask,>kerrek_walk1r_mask
;	.byte >kerrek_walk2r_mask,>kerrek_walk3r_mask
;	.byte >kerrek_walk4r_mask,>kerrek_walk5r_mask
;	.byte >kerrek_walk6r_mask,>kerrek_walk7r_mask

	; PEASANT_BOW_OFFSET
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd

sprites_data_l:
	; KERREK_WALK_OFFSET
	.byte $dd,$dd,$dd,$dd, $dd,$dd,$dd,$dd

;	.byte <kerrek_walk0l_sprite,<kerrek_walk1l_sprite
;	.byte <kerrek_walk2l_sprite,<kerrek_walk3l_sprite
;	.byte <kerrek_walk4l_sprite,<kerrek_walk5l_sprite
;	.byte <kerrek_walk6l_sprite,<kerrek_walk7l_sprite

;	.byte <kerrek_walk0r_sprite,<kerrek_walk1r_sprite
;	.byte <kerrek_walk2r_sprite,<kerrek_walk3r_sprite
;	.byte <kerrek_walk4r_sprite,<kerrek_walk5r_sprite
;	.byte <kerrek_walk6r_sprite,<kerrek_walk7r_sprite

	; PEASANT_BOW_OFFSET
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd

sprites_data_h:
	; KERREK_WALK_OFFSET
	.byte $dd,$dd,$dd,$dd, $dd,$dd,$dd,$dd

;	.byte >kerrek_walk0l_sprite,>kerrek_walk1l_sprite
;	.byte >kerrek_walk2l_sprite,>kerrek_walk3l_sprite
;	.byte >kerrek_walk4l_sprite,>kerrek_walk5l_sprite
;	.byte >kerrek_walk6l_sprite,>kerrek_walk7l_sprite

;	.byte >kerrek_walk0r_sprite,>kerrek_walk1r_sprite
;	.byte >kerrek_walk2r_sprite,>kerrek_walk3r_sprite
;	.byte >kerrek_walk4r_sprite,>kerrek_walk5r_sprite
;	.byte >kerrek_walk6r_sprite,>kerrek_walk7r_sprite

	; PEASANT_BOW_OFFSET
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd

sprites_xsize:
	; KERREK_WALK_OFFSET
;	.byte 3,3,3,3, 3,3,3,3
	.byte $dd,$dd,$dd,$dd, $dd,$dd,$dd,$dd

	; PEASANT_BOW_OFFSET
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd

sprites_ysize:
	; KERREK_WALK_OFFSET

;	.byte 48,48,48,48, 48,48,48,48
	.byte $dd,$dd,$dd,$dd, $dd,$dd,$dd,$dd

	; PEASANT_BOW_OFFSET
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
