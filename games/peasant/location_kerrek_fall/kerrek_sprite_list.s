KERREK_WALK_OFFSET_LEFT		= 0
KERREK_WALK_OFFSET_RIGHT	= 8
PEASANT_BOW_OFFSET		= 16

sprites_mask_l:
	; 0
	.byte <kerrek_walk0l_mask,<kerrek_walk1l_mask
	.byte <kerrek_walk2l_mask,<kerrek_walk3l_mask
	.byte <kerrek_walk4l_mask,<kerrek_walk5l_mask
	.byte <kerrek_walk6l_mask,<kerrek_walk7l_mask
	; 8
	.byte <kerrek_walk0r_mask,<kerrek_walk1r_mask
	.byte <kerrek_walk2r_mask,<kerrek_walk3r_mask
	.byte <kerrek_walk4r_mask,<kerrek_walk5r_mask
	.byte <kerrek_walk6r_mask,<kerrek_walk7r_mask
	; 16
	.byte <shoot0_l_mask,<shoot1_l_mask,<shoot2_l_mask
	.byte <shoot3_l_mask,<shoot4_l_mask,<shoot5_l_mask
	.byte <shoot6_l_mask,<shoot7_l_mask,<shoot8_l_mask


sprites_mask_h:
	.byte >kerrek_walk0l_mask,>kerrek_walk1l_mask
	.byte >kerrek_walk2l_mask,>kerrek_walk3l_mask
	.byte >kerrek_walk4l_mask,>kerrek_walk5l_mask
	.byte >kerrek_walk6l_mask,>kerrek_walk7l_mask

	.byte >kerrek_walk0r_mask,>kerrek_walk1r_mask
	.byte >kerrek_walk2r_mask,>kerrek_walk3r_mask
	.byte >kerrek_walk4r_mask,>kerrek_walk5r_mask
	.byte >kerrek_walk6r_mask,>kerrek_walk7r_mask

	.byte >shoot0_l_mask,>shoot1_l_mask,>shoot2_l_mask
	.byte >shoot3_l_mask,>shoot4_l_mask,>shoot5_l_mask
	.byte >shoot6_l_mask,>shoot7_l_mask,>shoot8_l_mask

sprites_data_l:
	.byte <kerrek_walk0l_sprite,<kerrek_walk1l_sprite
	.byte <kerrek_walk2l_sprite,<kerrek_walk3l_sprite
	.byte <kerrek_walk4l_sprite,<kerrek_walk5l_sprite
	.byte <kerrek_walk6l_sprite,<kerrek_walk7l_sprite

	.byte <kerrek_walk0r_sprite,<kerrek_walk1r_sprite
	.byte <kerrek_walk2r_sprite,<kerrek_walk3r_sprite
	.byte <kerrek_walk4r_sprite,<kerrek_walk5r_sprite
	.byte <kerrek_walk6r_sprite,<kerrek_walk7r_sprite
	; 16

	.byte <shoot0_l_sprite,<shoot1_l_sprite,<shoot2_l_sprite
	.byte <shoot3_l_sprite,<shoot4_l_sprite,<shoot5_l_sprite
	.byte <shoot6_l_sprite,<shoot7_l_sprite,<shoot8_l_sprite

sprites_data_h:
	.byte >kerrek_walk0l_sprite,>kerrek_walk1l_sprite
	.byte >kerrek_walk2l_sprite,>kerrek_walk3l_sprite
	.byte >kerrek_walk4l_sprite,>kerrek_walk5l_sprite
	.byte >kerrek_walk6l_sprite,>kerrek_walk7l_sprite

	.byte >kerrek_walk0r_sprite,>kerrek_walk1r_sprite
	.byte >kerrek_walk2r_sprite,>kerrek_walk3r_sprite
	.byte >kerrek_walk4r_sprite,>kerrek_walk5r_sprite
	.byte >kerrek_walk6r_sprite,>kerrek_walk7r_sprite

	; 16

	.byte >shoot0_l_sprite,>shoot1_l_sprite,>shoot2_l_sprite
	.byte >shoot3_l_sprite,>shoot4_l_sprite,>shoot5_l_sprite
	.byte >shoot6_l_sprite,>shoot7_l_sprite,>shoot8_l_sprite

sprites_xsize:
	.byte 3,3,3,3, 3,3,3,3, 3,3,3,3, 3,3,3,3		; walk

	.byte 3,3,3,3, 3,4,4,4, 3

sprites_ysize:
	.byte 48,48,48,48, 48,48,48,48, 48,48,48,48, 48,48,48,48

	.byte 30,30,30,30, 30,30,30,30, 30
