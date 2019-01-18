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
	.word	collapse5
	.word	collapse5

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



;=======================
; scenery

plant_wind:
	.word	plant1
	.word	plant2
	.word	plant3
	.word	plant4

plant1:
	.byte	$4,$5
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$00
	.byte	$aa,$00,$aa,$00

plant2:
	.byte	$4,$5
	.byte	$a0,$0a,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$00
	.byte	$aa,$00,$aa,$00

plant3:
	.byte	$4,$5
	.byte	$00,$aa,$aa,$aa
	.byte	$a0,$0a,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$00
	.byte	$aa,$00,$aa,$00

plant4:
	.byte	$4,$5
	.byte	$00,$aa,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$00
	.byte	$aa,$00,$aa,$00


pool_ripples:
	.word	ripple1
	.word	ripple2
	.word	ripple3
	.word	ripple4


ripple1:
	.byte	$3,$1
	.byte	$5a,$5a,$aa

ripple2:
	.byte	$3,$1
	.byte	$aa,$5a,$aa

ripple3:
	.byte	$3,$1
	.byte	$aa,$aa,$aa

ripple4:
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


;=======================
; Tentacle


tentacle_progression:
	.word	tentacle0	; 0
	.word	tentacle1	; 1
	.word	tentacle2	; 2
	.word	tentacle3	; 3
	.word	tentacle4	; 4
	.word	tentacle5	; 5
	.word	tentacle5	; 6
	.word	tentacle5	; 7
	.word	tentacle4	; 8
	.word	tentacle3	; 9
	.word	tentacle2	; 10
	.word	tentacle1	; 11
	.word	tentacle0	; 12





tentacle0:
	.byte	$2,$5
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$5a

tentacle1:
	.byte	$2,$5
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$00

tentacle2:
	.byte	$2,$5
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$00,$aa
	.byte	$aa,$00

tentacle3:
	.byte	$2,$5
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$00
	.byte	$00,$aa
	.byte	$aa,$00

tentacle4:
	.byte	$2,$5
	.byte	$aa,$aa
	.byte	$00,$aa
	.byte	$aa,$00
	.byte	$00,$aa
	.byte	$aa,$00

tentacle5:
	.byte	$2,$5
	.byte	$aa,$00
	.byte	$00,$aa
	.byte	$aa,$00
	.byte	$00,$aa
	.byte	$aa,$00

caught_progression:
	.word	caught0
	.word	caught1
	.word	caught2
	.word	caught3
	.word	caught4
	.word	caught5
	.word	caught6
	.word	caught7
	.word	caught8
	.word	ripple4
	.word	ripple4
	.word	ripple4	; 12



caught0:
	.byte	$5,$8
	.byte	$aa,$aa,$aa,$9a,$9a
	.byte	$aa,$00,$00,$99,$bb
	.byte	$aa,$00,$aa,$0b,$aa
	.byte	$00,$aa,$aa,$bb,$aa
	.byte	$aa,$00,$aa,$bb,$aa
	.byte	$aa,$aa,$aa,$44,$aa
	.byte	$aa,$aa,$aa,$44,$aa
	.byte	$aa,$aa,$aa,$f4,$fa

caught1:
	.byte	$6,$8
	.byte	$aa,$aa,$aa,$9a,$9a,$aa
	.byte	$aa,$aa,$aa,$99,$bb,$aa
	.byte	$aa,$00,$00,$0b,$00,$aa
	.byte	$00,$aa,$aa,$bb,$00,$0a
	.byte	$aa,$00,$aa,$bb,$aa,$aa
	.byte	$aa,$aa,$aa,$44,$aa,$aa
	.byte	$aa,$aa,$aa,$44,$aa,$aa
	.byte	$aa,$aa,$aa,$f4,$fa,$aa

caught2:
	.byte	$7,$8
	.byte	$aa,$aa,$aa,$9a,$9a,$aa,$aa
	.byte	$aa,$bb,$aa,$bb,$bb,$aa,$bb
	.byte	$aa,$aa,$bb,$0b,$0b,$bb,$aa
	.byte	$aa,$0a,$0a,$00,$00,$0a,$aa
	.byte	$aa,$00,$aa,$00,$00,$a0,$aa
	.byte	$aa,$aa,$aa,$44,$44,$aa,$aa
	.byte	$aa,$aa,$aa,$44,$44,$aa,$aa
	.byte	$aa,$aa,$aa,$f4,$f4,$aa,$aa

caught3:
	.byte	$6,$7
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$b9,$b9,$aa
	.byte	$aa,$aa,$bb,$0b,$0b,$bb
	.byte	$aa,$0a,$0a,$00,$00,$0a
	.byte	$aa,$00,$aa,$00,$00,$a0
	.byte	$aa,$aa,$aa,$44,$44,$aa
	.byte	$aa,$aa,$aa,$af,$af,$aa


caught4:
	.byte	$6,$6
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$9a,$aa,$aa
	.byte	$aa,$aa,$aa,$bb,$aa,$aa
	.byte	$aa,$aa,$0a,$0b,$aa,$aa
	.byte	$aa,$aa,$00,$40,$0a,$a0
	.byte	$aa,$aa,$aa,$af,$aa,$aa

caught5:
	.byte	$5,$5
	.byte	$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$9a,$aa
	.byte	$aa,$ae,$0a,$b0,$ae

caught6:
	.byte	$6,$5
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$ea,$aa,$aa,$aa,$ea
	.byte	$aa,$aa,$5a,$0e,$5a,$aa


caught7:
	.byte	$6,$5
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$ea,$aa,$aa
	.byte	$aa,$ae,$5a,$5a,$5a,$ae

caught8:
	.byte	$4,$5
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$5e

	;============================
	; Falling boulder

boulder:
	.byte	$3,$2
	.byte	$22,$22,$2a
	.byte	$22,$22,$22



