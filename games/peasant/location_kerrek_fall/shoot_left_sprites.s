; shoot_mask_l
	.byte <shoot0_l_mask,<shoot1_l_mask,<shoot2_l_mask
	.byte <shoot3_l_mask,<shoot4_l_mask,<shoot5_l_mask
	.byte <shoot6_l_mask,<shoot7_l_mask,<shoot8_l_mask
; shoot_mask_h
	.byte >shoot0_l_mask,>shoot1_l_mask,>shoot2_l_mask
	.byte >shoot3_l_mask,>shoot4_l_mask,>shoot5_l_mask
	.byte >shoot6_l_mask,>shoot7_l_mask,>shoot8_l_mask
; shoot_sprite_l
	.byte <shoot0_l_sprite,<shoot1_l_sprite,<shoot2_l_sprite
	.byte <shoot3_l_sprite,<shoot4_l_sprite,<shoot5_l_sprite
	.byte <shoot6_l_sprite,<shoot7_l_sprite,<shoot8_l_sprite
; shoot_sprite_h
	.byte >shoot0_l_sprite,>shoot1_l_sprite,>shoot2_l_sprite
	.byte >shoot3_l_sprite,>shoot4_l_sprite,>shoot5_l_sprite
	.byte >shoot6_l_sprite,>shoot7_l_sprite,>shoot8_l_sprite
; sprites_xsize
	.byte 3,3,3,3, 3,4,4,4, 3
; sprites_ysize
	.byte 30,30,30,30, 30,30,30,30, 30

	.include "sprites_kerrek_fall/peasant_shoot_sprites_left.inc"
