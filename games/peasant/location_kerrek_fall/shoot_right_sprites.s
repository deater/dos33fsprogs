
; shoot_mask_l
	.byte <shoot0_r_mask,<shoot1_r_mask,<shoot2_r_mask
	.byte <shoot3_r_mask,<shoot4_r_mask,<shoot5_r_mask
	.byte <shoot6_r_mask,<shoot7_r_mask,<shoot8_r_mask
; shoot_mask_h
	.byte >shoot0_r_mask,>shoot1_r_mask,>shoot2_r_mask
	.byte >shoot3_r_mask,>shoot4_r_mask,>shoot5_r_mask
	.byte >shoot6_r_mask,>shoot7_r_mask,>shoot8_r_mask
; shoot_sprite_l
	.byte <shoot0_r_sprite,<shoot1_r_sprite,<shoot2_r_sprite
	.byte <shoot3_r_sprite,<shoot4_r_sprite,<shoot5_r_sprite
	.byte <shoot6_r_sprite,<shoot7_r_sprite,<shoot8_r_sprite
; shoot_sprite_h
	.byte >shoot0_r_sprite,>shoot1_r_sprite,>shoot2_r_sprite
	.byte >shoot3_r_sprite,>shoot4_r_sprite,>shoot5_r_sprite
	.byte >shoot6_r_sprite,>shoot7_r_sprite,>shoot8_r_sprite
; sprites_xsize
	.byte 3,3,3,3, 3,4,4,4, 3
; sprites_ysize
	.byte 30,30,30,30, 30,30,30,30, 30

	.include "sprites_kerrek_fall/peasant_shoot_sprites_right.inc"
