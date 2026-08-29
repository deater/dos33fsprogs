	; left next
        .byte <kerrek_body0l_mask,<kerrek_body1l_mask
        .byte <kerrek_body2l_mask,<kerrek_body3l_mask

	; left next
	.byte >kerrek_body0l_mask,>kerrek_body1l_mask
	.byte >kerrek_body2l_mask,>kerrek_body3l_mask

	; left next
	.byte <kerrek_body0l_sprite,<kerrek_body1l_sprite
	.byte <kerrek_body2l_sprite,<kerrek_body3l_sprite

	; left next
	.byte >kerrek_body0l_sprite,>kerrek_body1l_sprite
	.byte >kerrek_body2l_sprite,>kerrek_body3l_sprite

; sprites_xsize
	.byte 7,7,7,7

; sprites_ysize
	.byte 14,14,14,14

	.include "sprites_kerrek1/kerrek_body_left_sprites.inc"
