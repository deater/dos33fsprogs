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
; I've got a match
; your embrace, and my collapse

collapse_progression:
	.word	collapse1
	.word	collapse2
	.word	collapse3
	.word	collapse4
	.word	collapse5
	.word	collapse5	; 6
	.word	collapse5	; 7
	.word	collapse5	; 8
	.word	collapse5	; 9

collapse1:
	.byte $4,$8
	.byte $aa,$aa,$9a,$9a
	.byte $aa,$aa,$99,$ab
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$aa,$bb,$aa
	.byte $aa,$aa,$44,$aa
	.byte $aa,$4a,$a4,$aa
	.byte $aa,$f4,$fa,$aa

collapse2:
	.byte $5,$8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$99,$b9
	.byte $aa,$aa,$aa,$b9,$ab
	.byte $aa,$aa,$aa,$b0,$aa
	.byte $aa,$aa,$00,$bb,$aa
	.byte $aa,$4a,$44,$bb,$aa
	.byte $4a,$a4,$aa,$ab,$aa
	.byte $f4,$fa,$aa,$aa,$aa

collapse3:
	.byte $6,$8
	.byte $aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$9a,$9a
	.byte $aa,$aa,$aa,$aa,$99,$bb
	.byte $aa,$aa,$aa,$0a,$0b,$aa
	.byte $aa,$aa,$4a,$00,$bb,$aa
	.byte $fa,$44,$44,$a0,$bb,$aa
	.byte $ff,$a4,$aa,$aa,$ab,$aa

collapse4:
	.byte $7,$8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$9a,$9a
	.byte $aa,$aa,$aa,$0a,$00,$bb,$99
	.byte $fa,$4a,$44,$00,$bb,$aa,$aa
	.byte $ff,$a4,$aa,$bb,$aa,$aa,$aa

collapse5:
	.byte $8,$8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$4a,$bb,$00,$b0,$00,$b9,$99
	.byte $ff,$44,$b4,$bb,$aa,$aa,$ab,$a9


;=======================
; Crouching

crouch_progression:
	.word	crouch1
	.word	crouch2

crouch1:
	.byte $3,$8
	.byte $aa,$aa,$aa
	.byte $9a,$9a,$aa
	.byte $bb,$99,$aa
	.byte $aa,$0b,$aa
	.byte $aa,$bb,$aa
	.byte $aa,$bb,$aa
	.byte $44,$44,$aa
	.byte $5a,$fc,$f4

crouch2:
	.byte $3,$8
	.byte $aa,$aa,$aa
	.byte $aa,$aa,$aa
	.byte $9a,$9a,$aa
	.byte $bb,$99,$aa
	.byte $aa,$0b,$0a
	.byte $aa,$bb,$00
	.byte $ba,$4b,$aa
	.byte $54,$f4,$f4


;=======================
; Kicking
; note: he needs to be facing left by default
kick1:
	.byte $4,$8
	.byte $aa,$9a,$9a,$aa
	.byte $aa,$bb,$99,$aa
	.byte $aa,$aa,$0b,$aa
	.byte $aa,$ba,$0b,$aa
	.byte $bb,$ab,$00,$ba
	.byte $aa,$aa,$44,$aa
	.byte $aa,$44,$a4,$ca
	.byte $af,$f4,$5a,$5c



