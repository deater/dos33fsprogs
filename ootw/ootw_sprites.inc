phys_walk_progression:
	.word	phys_stand
	.word	phys_walk_left1
	.word	phys_walk_left2
	.word	phys_walk_left3
	.word	phys_walk_left4
	.word	phys_walk_left5
	.word	phys_walk_left6
	.word	phys_walk_left7

	;====================
	; Going Left

phys_stand:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$fa,$f4,$aa

phys_walk_left1:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$ba,$0b,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$cc,$44,$aa
	.byte $aa,$fa,$f4,$a5

phys_walk_left2:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $ba,$ab,$00,$ba
	.byte $aa,$aa,$44,$aa
	.byte $aa,$cc,$44,$4a
	.byte $aa,$a5,$fc,$f4

phys_walk_left3:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $ba,$ab,$00,$ba
	.byte $aa,$aa,$44,$aa
	.byte $aa,$cc,$a4,$4a
	.byte $5a,$5c,$fa,$f4

phys_walk_left4:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$ba,$0b,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$aa,$c4,$4a
	.byte $aa,$5a,$5f,$af

phys_walk_left5:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$44,$c4,$aa
	.byte $af,$5f,$5c,$aa

phys_walk_left6:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$ba,$00,$bb
	.byte $aa,$aa,$44,$aa
	.byte $aa,$aa,$44,$aa
	.byte $fa,$f4,$5c,$5c

phys_walk_left7:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$aa,$0b,$ba
	.byte $aa,$aa,$44,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$fa,$f4,$5c



;=======================
; scenery

foreground_plant:
	.byte	$5,$5
	.byte	$aa,$00,$aa,$aa,$aa
	.byte	$aa,$a0,$0a,$aa,$aa
	.byte	$aa,$aa,$00,$aa,$aa
	.byte	$0a,$0a,$00,$aa,$0a
	.byte	$aa,$aa,$00,$aa,$00


pool_ripples:
	.word	ripple1
	.word	ripple2
	.word	ripple3


ripple1:
	.byte	$3,$1
	.byte	$5a,$5a,$5a

ripple2:
	.byte	$3,$1
	.byte	$aa,$5a,$aa

ripple3:
	.byte	$3,$1
	.byte	$aa,$aa,$aa



;=========================
; slug creatures
;	going left

slug1:
	.byte	$4,$2
	.byte	$aa,$aa,$aa,$aa
	.byte	$0a,$0a,$0a,$0a

slug2:
	.byte	$4,$2
	.byte	$aa,$aa,$aa,$aa
	.byte	$0a,$a0,$0a,$aa

slug_attack:
	.byte	$4,$2
	.byte	$00,$aa,$aa,$aa
	.byte	$00,$aa,$aa,$aa
