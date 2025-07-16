
robe_sprites_xsize:
	.byte	2, 2, 2, 2, 2, 2	; right		; 0
	.byte	2, 2, 2, 2, 2, 2	; left		; 6
	.byte	2, 2, 2, 2, 2, 2	; up		; 12
	.byte	2, 2, 2, 2, 2, 2	; down		; 18
flame_sprites_xsize:
	.byte	2, 2, 2			; right		; 24
	.byte	2, 2, 2			; left		; 27
	.byte	2, 2, 2			; up		; 30
	.byte	2, 2, 2			; down		; 33


robe_sprites_ysize:
	.byte	30, 30, 30, 30, 30, 30	; right
	.byte	30, 30, 30, 30, 30, 30	; left
	.byte	30, 30, 30, 30, 30, 30	; up
	.byte	30, 30, 30, 30, 30, 30	; down
flame_sprites_ysize:
	.byte	9, 9, 9			; right
	.byte	9, 9, 9			; left
	.byte	9, 9, 9			; up
	.byte	9, 9, 9			; down

robe_sprites_data_l:
	.byte <robe_r0_sprite,<robe_r1_sprite,<robe_r2_sprite
	.byte <robe_r3_sprite,<robe_r4_sprite,<robe_r5_sprite
	.byte <robe_l0_sprite,<robe_l1_sprite,<robe_l2_sprite
	.byte <robe_l3_sprite,<robe_l4_sprite,<robe_l5_sprite
	.byte <robe_u0_sprite,<robe_u1_sprite,<robe_u2_sprite
	.byte <robe_u3_sprite,<robe_u4_sprite,<robe_u5_sprite
	.byte <robe_d0_sprite,<robe_d1_sprite,<robe_d2_sprite
	.byte <robe_d3_sprite,<robe_d4_sprite,<robe_d5_sprite
flame_sprites_data_l:
	.byte <flame_r0_sprite,<flame_r1_sprite,<flame_r2_sprite
	.byte <flame_l0_sprite,<flame_l1_sprite,<flame_l2_sprite
	.byte <flame_u0_sprite,<flame_u1_sprite,<flame_u2_sprite
	.byte <flame_d0_sprite,<flame_d1_sprite,<flame_d2_sprite

robe_sprites_data_h:
	.byte >robe_r0_sprite,>robe_r1_sprite,>robe_r2_sprite
	.byte >robe_r3_sprite,>robe_r4_sprite,>robe_r5_sprite
	.byte >robe_l0_sprite,>robe_l1_sprite,>robe_l2_sprite
	.byte >robe_l3_sprite,>robe_l4_sprite,>robe_l5_sprite
	.byte >robe_u0_sprite,>robe_u1_sprite,>robe_u2_sprite
	.byte >robe_u3_sprite,>robe_u4_sprite,>robe_u5_sprite
	.byte >robe_d0_sprite,>robe_d1_sprite,>robe_d2_sprite
	.byte >robe_d3_sprite,>robe_d4_sprite,>robe_d5_sprite
flame_sprites_data_h:
	.byte >flame_r0_sprite,>flame_r1_sprite,>flame_r2_sprite
	.byte >flame_l0_sprite,>flame_l1_sprite,>flame_l2_sprite
	.byte >flame_u0_sprite,>flame_u1_sprite,>flame_u2_sprite
	.byte >flame_d0_sprite,>flame_d1_sprite,>flame_d2_sprite

robe_mask_data_l:
	.byte <robe_r0_mask,<robe_r1_mask,<robe_r2_mask
	.byte <robe_r3_mask,<robe_r4_mask,<robe_r5_mask
	.byte <robe_l0_mask,<robe_l1_mask,<robe_l2_mask
	.byte <robe_l3_mask,<robe_l4_mask,<robe_l5_mask
	.byte <robe_u0_mask,<robe_u1_mask,<robe_u2_mask
	.byte <robe_u3_mask,<robe_u4_mask,<robe_u5_mask
	.byte <robe_d0_mask,<robe_d1_mask,<robe_d2_mask
	.byte <robe_d3_mask,<robe_d4_mask,<robe_d5_mask
flame_mask_data_l:
	.byte <flame_r0_mask,<flame_r1_mask,<flame_r2_mask
	.byte <flame_l0_mask,<flame_l1_mask,<flame_l2_mask
	.byte <flame_u0_mask,<flame_u1_mask,<flame_u2_mask
	.byte <flame_d0_mask,<flame_d1_mask,<flame_d2_mask

robe_mask_data_h:
	.byte >robe_r0_mask,>robe_r1_mask,>robe_r2_mask
	.byte >robe_r3_mask,>robe_r4_mask,>robe_r5_mask
	.byte >robe_l0_mask,>robe_l1_mask,>robe_l2_mask
	.byte >robe_l3_mask,>robe_l4_mask,>robe_l5_mask
	.byte >robe_u0_mask,>robe_u1_mask,>robe_u2_mask
	.byte >robe_u3_mask,>robe_u4_mask,>robe_u5_mask
	.byte >robe_d0_mask,>robe_d1_mask,>robe_d2_mask
	.byte >robe_d3_mask,>robe_d4_mask,>robe_d5_mask
flame_mask_data_h:
	.byte >flame_r0_mask,>flame_r1_mask,>flame_r2_mask
	.byte >flame_l0_mask,>flame_l1_mask,>flame_l2_mask
	.byte >flame_u0_mask,>flame_u1_mask,>flame_u2_mask
	.byte >flame_d0_mask,>flame_d1_mask,>flame_d2_mask

	.include "robe_helm_sprites.inc"

	.include "flame_sprites.inc"
