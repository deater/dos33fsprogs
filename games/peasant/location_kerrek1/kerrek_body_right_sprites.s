	; left next
        .byte <kerrek_body0r_mask,<kerrek_body1r_mask
        .byte <kerrek_body2r_mask,<kerrek_body3r_mask

	; left next
	.byte >kerrek_body0r_mask,>kerrek_body1r_mask
	.byte >kerrek_body2r_mask,>kerrek_body3r_mask

	; left next
	.byte <kerrek_body0r_sprite,<kerrek_body1r_sprite
	.byte <kerrek_body2r_sprite,<kerrek_body3r_sprite

	; left next
	.byte >kerrek_body0r_sprite,>kerrek_body1r_sprite
	.byte >kerrek_body2r_sprite,>kerrek_body3r_sprite

; sprites_xsize
	.byte 7,7,7,7

; sprites_ysize
	.byte 14,14,14,14

	.include "sprites_kerrek1/kerrek_body_right_sprites.inc"
