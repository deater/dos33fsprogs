	; peasant belt legs
	.byte <belt_base_mask
	; peasant belt animation
	.byte <belt0_mask,<belt1_mask,<belt2_mask,<belt3_mask
	.byte <belt4_mask,<belt5_mask,<belt6_mask,<belt7_mask
	.byte <belt8_mask

	; peasant belt legs
	.byte >belt_base_mask
	; peasant belt animation
	.byte >belt0_mask,>belt1_mask,>belt2_mask,>belt3_mask
	.byte >belt4_mask,>belt5_mask,>belt6_mask,>belt7_mask
	.byte >belt8_mask

	; peasant belt legs
	.byte <belt_base_sprite
	; peasant belt animation
	.byte <belt0_sprite,<belt1_sprite,<belt2_sprite,<belt3_sprite
	.byte <belt4_sprite,<belt5_sprite,<belt6_sprite,<belt7_sprite
	.byte <belt8_sprite

	; peasant belt legs
	.byte >belt_base_sprite
	; peasant belt animation
	.byte >belt0_sprite,>belt1_sprite,>belt2_sprite,>belt3_sprite
	.byte >belt4_sprite,>belt5_sprite,>belt6_sprite,>belt7_sprite
	.byte >belt8_sprite

; sprites_xsize
	.byte 2, 4,4,4,4, 2,2,2,2, 4			; belt lift

; sprites_ysize
	.byte 20, 23,19,16,12, 13,13,19,22, 24

	.include "sprites_kerrek1/peasant_belt.inc"
