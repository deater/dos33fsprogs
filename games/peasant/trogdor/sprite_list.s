TINY_WALK_OFFSET_LEFT		= 1
TINY_WALK_OFFSET_RIGHT		= 1

sprites_mask_l:
	; 0
	.byte <tiny0r_mask,<tiny0r_mask,<tiny0r_mask,<tiny0r_mask


sprites_mask_h:
	.byte >tiny0r_mask,>tiny0r_mask,>tiny0r_mask,>tiny0r_mask

sprites_data_l:
	.byte <tiny0r_sprite,<tiny0r_sprite,<tiny0r_sprite,<tiny0r_sprite

sprites_data_h:
	.byte >tiny0r_sprite,>tiny0r_sprite,>tiny0r_sprite,>tiny0r_sprite

sprites_xsize:
	.byte 2,2,2,2

sprites_ysize:
	.byte 5,5,5,5


