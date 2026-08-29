KERREK_WALK_OFFSET_LEFT		= 0
KERREK_WALK_OFFSET_RIGHT	= 8
KERREK_SMASH_BASE_OFFSET_LEFT	= 16
KERREK_SMASH_BASE_OFFSET_RIGHT	= 17
KERREK_SMASH_ARM_OFFSET_LEFT	= 18
KERREK_SMASH_ARM_OFFSET_RIGHT	= 26
KERREK_SMASHED_PEASANT_OFFSET	= 34
KERREK_SMASH1_OFFSET		= 35
KERREK_SMASH2_OFFSET		= 36

KERREK_BODY_OFFSET		= 37
KERREK_FLIES_OFFSET		= 41

PEASANT_BELT_BASE_OFFSET	= 44
PEASANT_BELT_OFFSET		= 45

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
	.byte <kerrek_smash_basel_mask
	.byte <kerrek_smash_baser_mask
	; 18
	.byte <kerrek_smash_arm0l_sprite,<kerrek_smash_arm1l_sprite
	.byte <kerrek_smash_arm2l_sprite,<kerrek_smash_arm3l_sprite
	.byte <kerrek_smash_arm4l_sprite,<kerrek_smash_arm5l_sprite
	.byte <kerrek_smash_arm6l_sprite,<kerrek_smash_arm7l_sprite
	; 26
	.byte <kerrek_smash_arm0r_sprite,<kerrek_smash_arm1r_sprite
	.byte <kerrek_smash_arm2r_sprite,<kerrek_smash_arm3r_sprite
	.byte <kerrek_smash_arm4r_sprite,<kerrek_smash_arm5r_sprite
	.byte <kerrek_smash_arm6r_sprite,<kerrek_smash_arm7r_sprite

	; 34
	.byte <peasant_head_mask
	.byte <smash1_mask
	.byte <smash2_mask

	; 37
	.byte $dd,$dd,$dd,$dd

	; right first?
;	.byte <kerrek_body0r_mask,<kerrek_body1r_mask
;	.byte <kerrek_body2r_mask,<kerrek_body3r_mask
	; left next

;	.byte <kerrek_body0l_mask,<kerrek_body1l_mask
;	.byte <kerrek_body2l_mask,<kerrek_body3l_mask

	; 41

	; flies
	.byte <kerrek_flies0_mask,<kerrek_flies1_mask,<kerrek_flies2_mask
	; 44

	.byte $dd


	; peasant belt legs
;	.byte <belt_base_mask

	; 45

	.byte $dd,$dd,$dd,$dd, $dd,$dd,$dd,$dd, $dd

	; peasant belt animation
;	.byte <belt0_mask,<belt1_mask,<belt2_mask,<belt3_mask
;	.byte <belt4_mask,<belt5_mask,<belt6_mask,<belt7_mask
;	.byte <belt8_mask



sprites_mask_h:
	.byte >kerrek_walk0l_mask,>kerrek_walk1l_mask
	.byte >kerrek_walk2l_mask,>kerrek_walk3l_mask
	.byte >kerrek_walk4l_mask,>kerrek_walk5l_mask
	.byte >kerrek_walk6l_mask,>kerrek_walk7l_mask

	.byte >kerrek_walk0r_mask,>kerrek_walk1r_mask
	.byte >kerrek_walk2r_mask,>kerrek_walk3r_mask
	.byte >kerrek_walk4r_mask,>kerrek_walk5r_mask
	.byte >kerrek_walk6r_mask,>kerrek_walk7r_mask
	; 16
	.byte >kerrek_smash_basel_mask
	.byte >kerrek_smash_baser_mask
	; 18
	.byte >kerrek_smash_arm0l_sprite,>kerrek_smash_arm1l_sprite
	.byte >kerrek_smash_arm2l_sprite,>kerrek_smash_arm3l_sprite
	.byte >kerrek_smash_arm4l_sprite,>kerrek_smash_arm5l_sprite
	.byte >kerrek_smash_arm6l_sprite,>kerrek_smash_arm7l_sprite
	; 26
	.byte >kerrek_smash_arm0r_sprite,>kerrek_smash_arm1r_sprite
	.byte >kerrek_smash_arm2r_sprite,>kerrek_smash_arm3r_sprite
	.byte >kerrek_smash_arm4r_sprite,>kerrek_smash_arm5r_sprite
	.byte >kerrek_smash_arm6r_sprite,>kerrek_smash_arm7r_sprite
	; 34
	.byte >peasant_head_mask
	.byte >smash1_mask
	.byte >smash2_mask


	; right first?
;	.byte >kerrek_body0r_mask,>kerrek_body1r_mask
;	.byte >kerrek_body2r_mask,>kerrek_body3r_mask
	; left next
	.byte $dd,$dd,$dd,$dd
;	.byte >kerrek_body0l_mask,>kerrek_body1l_mask
;	.byte >kerrek_body2l_mask,>kerrek_body3l_mask
	; flies
	.byte >kerrek_flies0_mask,>kerrek_flies1_mask,>kerrek_flies2_mask

	; peasant belt legs
;	.byte >belt_base_mask
	; peasant belt animation
;	.byte >belt0_mask,>belt1_mask,>belt2_mask,>belt3_mask
;	.byte >belt4_mask,>belt5_mask,>belt6_mask,>belt7_mask
;	.byte >belt8_mask

	.byte $dd, $dd,$dd,$dd,$dd, $dd,$dd,$dd,$dd, $dd

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
	.byte <kerrek_smash_basel_sprite
	.byte <kerrek_smash_baser_sprite
	; 18
	.byte <kerrek_smash_arm0l_sprite,<kerrek_smash_arm1l_sprite
	.byte <kerrek_smash_arm2l_sprite,<kerrek_smash_arm3l_sprite
	.byte <kerrek_smash_arm4l_sprite,<kerrek_smash_arm5l_sprite
	.byte <kerrek_smash_arm6l_sprite,<kerrek_smash_arm7l_sprite
	; 26
	.byte <kerrek_smash_arm0r_sprite,<kerrek_smash_arm1r_sprite
	.byte <kerrek_smash_arm2r_sprite,<kerrek_smash_arm3r_sprite
	.byte <kerrek_smash_arm4r_sprite,<kerrek_smash_arm5r_sprite
	.byte <kerrek_smash_arm6r_sprite,<kerrek_smash_arm7r_sprite
	; 34
	.byte <peasant_head_sprite
	.byte <smash1_sprite
	.byte <smash2_sprite


	; right first?
;	.byte <kerrek_body0r_sprite,<kerrek_body1r_sprite
;	.byte <kerrek_body2r_sprite,<kerrek_body3r_sprite
	; left next
	.byte $dd,$dd,$dd,$dd
;	.byte <kerrek_body0l_sprite,<kerrek_body1l_sprite
;	.byte <kerrek_body2l_sprite,<kerrek_body3l_sprite
	; flies
	.byte <kerrek_flies0_sprite,<kerrek_flies1_sprite,<kerrek_flies2_sprite

	; peasant belt legs
;	.byte <belt_base_sprite
	; peasant belt animation
;	.byte <belt0_sprite,<belt1_sprite,<belt2_sprite,<belt3_sprite
;	.byte <belt4_sprite,<belt5_sprite,<belt6_sprite,<belt7_sprite
;	.byte <belt8_sprite

	.byte $dd, $dd,$dd,$dd,$dd, $dd,$dd,$dd,$dd, $dd

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
	.byte >kerrek_smash_basel_sprite
	.byte >kerrek_smash_baser_sprite
	; 18
	.byte >kerrek_smash_arm0l_sprite,>kerrek_smash_arm1l_sprite
	.byte >kerrek_smash_arm2l_sprite,>kerrek_smash_arm3l_sprite
	.byte >kerrek_smash_arm4l_sprite,>kerrek_smash_arm5l_sprite
	.byte >kerrek_smash_arm6l_sprite,>kerrek_smash_arm7l_sprite
	; 26
	.byte >kerrek_smash_arm0r_sprite,>kerrek_smash_arm1r_sprite
	.byte >kerrek_smash_arm2r_sprite,>kerrek_smash_arm3r_sprite
	.byte >kerrek_smash_arm4r_sprite,>kerrek_smash_arm5r_sprite
	.byte >kerrek_smash_arm6r_sprite,>kerrek_smash_arm7r_sprite
	; 34
	.byte >peasant_head_sprite
	.byte >smash1_sprite
	.byte >smash2_sprite

	; right first?
;	.byte >kerrek_body0r_sprite,>kerrek_body1r_sprite
;	.byte >kerrek_body2r_sprite,>kerrek_body3r_sprite
	; left next
;	.byte >kerrek_body0l_sprite,>kerrek_body1l_sprite
;	.byte >kerrek_body2l_sprite,>kerrek_body3l_sprite

	.byte $dd,$dd,$dd,$dd
	; flies
	.byte >kerrek_flies0_sprite,>kerrek_flies1_sprite,>kerrek_flies2_sprite

	; peasant belt legs
;	.byte >belt_base_sprite
	; peasant belt animation
;	.byte >belt0_sprite,>belt1_sprite,>belt2_sprite,>belt3_sprite
;	.byte >belt4_sprite,>belt5_sprite,>belt6_sprite,>belt7_sprite
;	.byte >belt8_sprite

	.byte $dd, $dd,$dd,$dd,$dd, $dd,$dd,$dd,$dd, $dd

sprites_xsize:
	.byte 3,3,3,3, 3,3,3,3, 3,3,3,3, 3,3,3,3		; walk

	.byte 3,3						; smash base
	.byte 2,3,2,3,     3,2,2,4				; arml
	.byte 2,3,2,3,     3,2,2,4				; armr
	.byte 2,4,4

	.byte $dd,$dd,$dd,$dd					; body
	.byte 3,3,3						; flies

;	.byte 2, 4,4,4,4, 2,2,2,2, 4				; belt lift
	.byte $dd, $dd,$dd,$dd,$dd, $dd,$dd,$dd,$dd, $dd

sprites_ysize:
	.byte 48,48,48,48, 48,48,48,48, 48,48,48,48, 48,48,48,48

	.byte 48,48
	.byte 18,16,14,9,  12,15,16,16
	.byte 18,16,14,9,  12,15,16,16
	.byte 14,7,5

	.byte 14,14,14,14					; body

	.byte 11,11,10						; flies

;	.byte 20, 23,19,16,12, 13,13,19,22, 24
	.byte $dd, $dd,$dd,$dd,$dd, $dd,$dd,$dd,$dd, $dd	; raise
