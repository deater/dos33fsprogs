
custom_sprites_data_l:
	.byte <haystack_sprite0,<haystack_sprite1,<haystack_sprite2

        .byte <blown_sprite0,<blown_sprite1,<blown_sprite2
        .byte <blown_sprite3,<blown_sprite4

custom_sprites_data_h:
	.byte >haystack_sprite0,>haystack_sprite1,>haystack_sprite2

        .byte >blown_sprite0,>blown_sprite1,>blown_sprite2
        .byte >blown_sprite3,>blown_sprite4

custom_mask_data_l:
	.byte <haystack_mask0,<haystack_mask1,<haystack_mask2

        .byte <blown_mask0,<blown_mask1,<blown_mask2
        .byte <blown_mask3,<blown_mask4

custom_mask_data_h:
	.byte >haystack_mask0,>haystack_mask1,>haystack_mask2

        .byte >blown_mask0,>blown_mask1,>blown_mask2
        .byte >blown_mask3,>blown_mask4

custom_sprites_xsize:
	.byte 6,6,6
        .byte  6, 6, 7, 4, 2

custom_sprites_ysize:
	.byte 43,43,43
        .byte 43,35,32,26,11
