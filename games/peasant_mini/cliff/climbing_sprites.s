climb_sprites_xsize:
	.byte	3, 3, 3, 3		; right		; 0
	.byte	3, 3, 3, 3		; left		; 4
	.byte	3, 3, 3, 3		; up		; 8
	.byte	3, 3, 3, 3		; down		; 12
flame_sprites_xsize:
	.byte	2, 2, 2			; right		; 16
	.byte	2, 2, 2			; left		; 19
	.byte	2, 2, 2			; up		; 22
	.byte	2, 2, 2			; down		; 25
fall_sprites_xsize:
	.byte	3, 3, 3, 3				; 28
splat_sprites_xsize:
	.byte	3,3			;		; 32


climb_sprites_ysize:
	.byte	30, 30, 30, 30		; right
	.byte	30, 30, 30, 30		; left
	.byte	30, 30, 30, 30		; up
	.byte	30, 30, 30, 30		; down
flame_sprites_ysize:
	.byte	9, 9, 9			; right
	.byte	9, 9, 9			; left
	.byte	9, 9, 9			; up
	.byte	9, 9, 9			; down
fall_sprites_ysize:
	.byte	21,21,21,21
splat_sprites_ysize:
	.byte	21,21

climb_sprites_data_l:
	.byte <climb_r0_sprite,<climb_r1_sprite,<climb_r2_sprite
	.byte <climb_r3_sprite
	.byte <climb_l3_sprite,<climb_l2_sprite,<climb_l1_sprite
	.byte <climb_l0_sprite
	.byte <climb_u0_sprite,<climb_u1_sprite,<climb_u2_sprite
	.byte <climb_u3_sprite
	.byte <climb_u3_sprite,<climb_u2_sprite,<climb_u1_sprite
	.byte <climb_u0_sprite
flame_sprites_data_l:
	.byte <flame_r0_sprite,<flame_r1_sprite,<flame_r2_sprite
	.byte <flame_l0_sprite,<flame_l1_sprite,<flame_l2_sprite
	.byte <flame_u0_sprite,<flame_u1_sprite,<flame_u2_sprite
	.byte <flame_d0_sprite,<flame_d1_sprite,<flame_d2_sprite
fall_sprites_data_l:
	.byte <climb_f0_sprite,<climb_f1_sprite,<climb_f2_sprite
	.byte <climb_f3_sprite
splat_sprites_data_l:
	.byte <climb_s0_sprite,<climb_s1_sprite

climb_sprites_data_h:
	.byte >climb_r0_sprite,>climb_r1_sprite,>climb_r2_sprite
	.byte >climb_r3_sprite
	.byte >climb_l3_sprite,>climb_l2_sprite,>climb_l1_sprite
	.byte >climb_l0_sprite
	.byte >climb_u0_sprite,>climb_u1_sprite,>climb_u2_sprite
	.byte >climb_u3_sprite
	.byte >climb_u3_sprite,>climb_u2_sprite,>climb_u1_sprite
	.byte >climb_u0_sprite
flame_sprites_data_h:
	.byte >flame_r0_sprite,>flame_r1_sprite,>flame_r2_sprite
	.byte >flame_l0_sprite,>flame_l1_sprite,>flame_l2_sprite
	.byte >flame_u0_sprite,>flame_u1_sprite,>flame_u2_sprite
	.byte >flame_d0_sprite,>flame_d1_sprite,>flame_d2_sprite
fall_sprites_data_h:
	.byte >climb_f0_sprite,>climb_f1_sprite,>climb_f2_sprite
	.byte >climb_f3_sprite
splat_sprites_data_h:
	.byte >climb_s0_sprite,>climb_s1_sprite


climb_mask_data_l:
	.byte <climb_r0_mask,<climb_r1_mask,<climb_r2_mask
	.byte <climb_r3_mask
	.byte <climb_l3_mask,<climb_l2_mask,<climb_l1_mask
	.byte <climb_l0_mask
	.byte <climb_u0_mask,<climb_u1_mask,<climb_u2_mask
	.byte <climb_u3_mask
	.byte <climb_u3_mask,<climb_u2_mask,<climb_u1_mask
	.byte <climb_u0_mask
flame_mask_data_l:
	.byte <flame_r0_mask,<flame_r1_mask,<flame_r2_mask
	.byte <flame_l0_mask,<flame_l1_mask,<flame_l2_mask
	.byte <flame_u0_mask,<flame_u1_mask,<flame_u2_mask
	.byte <flame_d0_mask,<flame_d1_mask,<flame_d2_mask
fall_mask_data_l:
	.byte >climb_f0_mask,>climb_f1_mask,>climb_f2_mask
	.byte >climb_f3_mask
splat_mask_data_l:
	.byte >climb_s0_mask,>climb_s1_mask


climb_mask_data_h:
	.byte >climb_r0_mask,>climb_r1_mask,>climb_r2_mask
	.byte >climb_r3_mask
	.byte >climb_l3_mask,>climb_l2_mask,>climb_l1_mask
	.byte >climb_l0_mask
	.byte >climb_u0_mask,>climb_u1_mask,>climb_u2_mask
	.byte >climb_u3_mask
	.byte >climb_u3_mask,>climb_u2_mask,>climb_u1_mask
	.byte >climb_u0_mask
flame_mask_data_h:
	.byte >flame_r0_mask,>flame_r1_mask,>flame_r2_mask
	.byte >flame_l0_mask,>flame_r1_mask,>flame_l2_mask
	.byte >flame_u0_mask,>flame_u1_mask,>flame_u2_mask
	.byte >flame_d0_mask,>flame_d1_mask,>flame_d2_mask
fall_mask_data_h:
	.byte <climb_f0_mask,<climb_f1_mask,<climb_f2_mask
	.byte <climb_f3_mask
splat_mask_data_h:
	.byte <climb_s0_mask,<climb_s1_mask



	.include "sprites/climb_sprites.inc"

	.include "sprites/flame_sprites.inc"
