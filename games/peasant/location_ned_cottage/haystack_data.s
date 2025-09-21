
custom_sprites_data_l:
        .byte <blown_sprite0,<blown_sprite1,<blown_sprite2
        .byte <blown_sprite3,<blown_sprite4

	.byte <baby_sprite0,<baby_sprite1,<baby_sprite2
	.byte <baby_sprite3,<baby_sprite4,<baby_sprite5
	.byte <baby_sprite6,<baby_sprite7,<baby_sprite8


custom_sprites_data_h:
	.byte >blown_sprite0,>blown_sprite1,>blown_sprite2
	.byte >blown_sprite3,>blown_sprite4

	.byte >baby_sprite0,>baby_sprite1,>baby_sprite2
	.byte >baby_sprite3,>baby_sprite4,>baby_sprite5
	.byte >baby_sprite6,>baby_sprite7,>baby_sprite8

custom_mask_data_l:
	.byte <blown_mask0,<blown_mask1,<blown_mask2
	.byte <blown_mask3,<blown_mask4

	.byte <baby_mask0,<baby_mask1,<baby_mask2
	.byte <baby_mask3,<baby_mask4,<baby_mask5
	.byte <baby_mask6,<baby_mask7,<baby_mask8

custom_mask_data_h:
	.byte >blown_mask0,>blown_mask1,>blown_mask2
	.byte >blown_mask3,>blown_mask4

	.byte >baby_mask0,>baby_mask1,>baby_mask2
	.byte >baby_mask3,>baby_mask4,>baby_mask5
	.byte >baby_mask6,>baby_mask7,>baby_mask8

custom_sprites_xsize:
        .byte  6, 6, 7, 4, 2

	.byte 4,4,4, 4,3,3, 3,3,2

custom_sprites_ysize:
        .byte 43,35,32,26,11

	.byte 7,7,7, 7,7,7, 7,7,7
