

walk_sprites_xsize:
	.byte	2, 2, 2, 2, 2, 2	; right		; 0
	.byte	2, 2, 2, 2, 2, 2	; left		; 6
	.byte	2, 2, 2, 2, 2, 2	; up		; 12
	.byte	2, 2, 2, 2, 2, 2	; down		; 18
flame_sprites_xsize:
	.byte	2, 2, 2			; right		; 24
	.byte	2, 2, 2			; left		; 27
	.byte	2, 2, 2			; up		; 30
	.byte	2, 2, 2			; down		; 33


walk_sprites_ysize:
	.byte	30, 30, 30, 30, 30, 30	; right
	.byte	30, 30, 30, 30, 30, 30	; left
	.byte	30, 30, 30, 30, 30, 30	; up
	.byte	30, 30, 30, 30, 30, 30	; down
flame_sprites_ysize:
	.byte	9, 9, 9			; right
	.byte	9, 9, 9			; left
	.byte	9, 9, 9			; up
	.byte	9, 9, 9			; down

walk_sprites_data_l:
	.byte <walk_r0_sprite,<walk_r1_sprite,<walk_r2_sprite
	.byte <walk_r3_sprite,<walk_r4_sprite,<walk_r5_sprite
	.byte <walk_l0_sprite,<walk_l1_sprite,<walk_l2_sprite
	.byte <walk_l3_sprite,<walk_l4_sprite,<walk_l5_sprite
	.byte <walk_u0_sprite,<walk_u1_sprite,<walk_u2_sprite
	.byte <walk_u3_sprite,<walk_u4_sprite,<walk_u5_sprite
	.byte <walk_d0_sprite,<walk_d1_sprite,<walk_d2_sprite
	.byte <walk_d3_sprite,<walk_d4_sprite,<walk_d5_sprite
flame_sprites_data_l:
	.byte <flame_r0_sprite,<flame_r1_sprite,<flame_r2_sprite
	.byte <flame_l0_sprite,<flame_l1_sprite,<flame_l2_sprite
	.byte <flame_u0_sprite,<flame_u1_sprite,<flame_u2_sprite
	.byte <flame_d0_sprite,<flame_d1_sprite,<flame_d2_sprite

walk_sprites_data_h:
	.byte >walk_r0_sprite,>walk_r1_sprite,>walk_r2_sprite
	.byte >walk_r3_sprite,>walk_r4_sprite,>walk_r5_sprite
	.byte >walk_l0_sprite,>walk_l1_sprite,>walk_l2_sprite
	.byte >walk_l3_sprite,>walk_l4_sprite,>walk_l5_sprite
	.byte >walk_u0_sprite,>walk_u1_sprite,>walk_u2_sprite
	.byte >walk_u3_sprite,>walk_u4_sprite,>walk_u5_sprite
	.byte >walk_d0_sprite,>walk_d1_sprite,>walk_d2_sprite
	.byte >walk_d3_sprite,>walk_d4_sprite,>walk_d5_sprite
flame_sprites_data_h:
	.byte >flame_r0_sprite,>flame_r1_sprite,>flame_r2_sprite
	.byte >flame_l0_sprite,>flame_l1_sprite,>flame_l2_sprite
	.byte >flame_u0_sprite,>flame_u1_sprite,>flame_u2_sprite
	.byte >flame_d0_sprite,>flame_d1_sprite,>flame_d2_sprite

walk_mask_data_l:
	.byte <walk_r0_mask,<walk_r1_mask,<walk_r2_mask
	.byte <walk_r3_mask,<walk_r4_mask,<walk_r5_mask
	.byte <walk_l0_mask,<walk_l1_mask,<walk_l2_mask
	.byte <walk_l3_mask,<walk_l4_mask,<walk_l5_mask
	.byte <walk_u0_mask,<walk_u1_mask,<walk_u2_mask
	.byte <walk_u3_mask,<walk_u4_mask,<walk_u5_mask
	.byte <walk_d0_mask,<walk_d1_mask,<walk_d2_mask
	.byte <walk_d3_mask,<walk_d4_mask,<walk_d5_mask
flame_mask_data_l:
	.byte <flame_r0_mask,<flame_r1_mask,<flame_r2_mask
	.byte <flame_l0_mask,<flame_l1_mask,<flame_l2_mask
	.byte <flame_u0_mask,<flame_u1_mask,<flame_u2_mask
	.byte <flame_d0_mask,<flame_d1_mask,<flame_d2_mask

walk_mask_data_h:
	.byte >walk_r0_mask,>walk_r1_mask,>walk_r2_mask
	.byte >walk_r3_mask,>walk_r4_mask,>walk_r5_mask
	.byte >walk_l0_mask,>walk_l1_mask,>walk_l2_mask
	.byte >walk_l3_mask,>walk_l4_mask,>walk_l5_mask
	.byte >walk_u0_mask,>walk_u1_mask,>walk_u2_mask
	.byte >walk_u3_mask,>walk_u4_mask,>walk_u5_mask
	.byte >walk_d0_mask,>walk_d1_mask,>walk_d2_mask
	.byte >walk_d3_mask,>walk_d4_mask,>walk_d5_mask
flame_mask_data_h:
	.byte >flame_r0_mask,>flame_r1_mask,>flame_r2_mask
	.byte >flame_l0_mask,>flame_l1_mask,>flame_l2_mask
	.byte >flame_u0_mask,>flame_u1_mask,>flame_u2_mask
	.byte >flame_d0_mask,>flame_d1_mask,>flame_d2_mask

	.include "mud_sprites.inc"

	.include "flame_sprites.inc"
