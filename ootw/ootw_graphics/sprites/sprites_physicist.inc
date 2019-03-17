; note, for some reason these are all facing left

;=====================
;=====================
; STANDING
;=====================
;=====================

	;====================
	; Going Left

phys_stand:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$fa,$f4,$aa,$aa


;=====================
;=====================
; WALKING
;=====================
;=====================

phys_walk_progression:
	.word	phys_walk_left1
	.word	phys_walk_left2
	.word	phys_walk_left3
	.word	phys_walk_left4
	.word	phys_walk_left5
	.word	phys_walk_left6
	.word	phys_walk_left7
	.word	phys_walk_left8
	.word	phys_walk_left9
	.word	phys_walk_left10



phys_walk_left1:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ab,$bb,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$44,$a4,$cc,$aa
	.byte $af,$af,$7a,$7c,$aa

phys_walk_left2:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$bb,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$44,$a4,$cc,$aa
	.byte $af,$f4,$7a,$7c,$aa

phys_walk_left3:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$44,$a4,$cc,$aa
	.byte $fa,$f4,$7a,$7c,$aa

phys_walk_left4:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$44,$a4,$ca,$aa
	.byte $fa,$f4,$aa,$7c,$a7

phys_walk_left5:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$bb,$00,$aa,$aa
	.byte $7a,$aa,$44,$aa,$aa
	.byte $aa,$cc,$44,$aa,$aa
	.byte $aa,$f7,$f4,$aa,$aa

phys_walk_left6:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $aa,$ca,$44,$aa,$aa
	.byte $7a,$cc,$a4,$4a,$aa
	.byte $aa,$a7,$fa,$f4,$aa

phys_walk_left7:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$ca,$44,$aa,$aa
	.byte $aa,$cc,$a4,$4a,$aa
	.byte $a7,$7c,$fa,$f4,$aa

phys_walk_left8:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $aa,$ca,$44,$aa,$aa
	.byte $aa,$cc,$a4,$44,$aa
	.byte $7a,$7c,$aa,$fa,$af

phys_walk_left9:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$aa,$c4,$a4,$fa
	.byte $aa,$7a,$7c,$af,$aa

phys_walk_left10:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$bb,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$fa,$7f,$7c,$aa


;=====================
;=====================
; RUNNING
;=====================
;=====================

phys_run_progression:
	.word	phys_run_left1
	.word	phys_run_left2
	.word	phys_run_left3
	.word	phys_run_left4
	.word	phys_run_left5
	.word	phys_run_left6
	.word	phys_run_left7
	.word	phys_run_left8
	.word	phys_run_left9
	.word	phys_run_left9

phys_run_left1:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$aa,$44,$ac,$77
	.byte $aa,$fa,$f4,$aa,$aa

phys_run_left2:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $ba,$ab,$00,$aa,$aa
	.byte $aa,$ca,$44,$aa,$aa
	.byte $aa,$ac,$44,$4a,$aa
	.byte $aa,$aa,$fa,$f4,$aa

phys_run_left3:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $ab,$ab,$00,$aa,$aa
	.byte $aa,$ca,$44,$aa,$aa
	.byte $aa,$cc,$a4,$4a,$aa
	.byte $a7,$a7,$fa,$af,$aa

phys_run_left4:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $ba,$ba,$0b,$aa,$aa
	.byte $aa,$ab,$00,$aa,$aa
	.byte $aa,$ca,$44,$aa,$aa
	.byte $aa,$cc,$aa,$44,$aa
	.byte $7a,$a7,$aa,$fa,$af

phys_run_left5:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ab,$0b,$aa,$aa
	.byte $aa,$aa,$44,$4a,$fa
	.byte $aa,$cc,$aa,$aa,$af
	.byte $7a,$7c,$aa,$aa,$aa

phys_run_left6:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ab,$00,$aa,$aa
	.byte $aa,$aa,$44,$4a,$fa
	.byte $aa,$aa,$cc,$aa,$af
	.byte $aa,$7a,$7c,$aa,$aa

phys_run_left7:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ab,$0b,$aa,$aa
	.byte $aa,$4a,$44,$aa,$aa
	.byte $aa,$a4,$c4,$ff,$aa
	.byte $aa,$7a,$7c,$aa,$aa

phys_run_left8:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$ba,$bb,$aa,$aa
	.byte $aa,$aa,$0b,$ba,$aa
	.byte $aa,$4a,$44,$aa,$aa
	.byte $aa,$44,$ac,$ca,$aa
	.byte $af,$af,$7a,$7c,$aa

phys_run_left9:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$ba,$0b,$bb,$aa
	.byte $aa,$aa,$00,$bb,$aa
	.byte $aa,$aa,$44,$ca,$aa
	.byte $aa,$44,$aa,$cc,$aa
	.byte $fa,$f4,$aa,$7a,$7c


;=====================
;=====================
; JUMPING
;=====================
;=====================

;=====================
;=====================
; KICKING
;=====================
;=====================

; note: he needs to be facing left by default
kick1:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $bb,$ab,$00,$ba,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$44,$a4,$ca,$aa
	.byte $af,$f4,$5a,$5c,$aa

;=====================
;=====================
; FALLING
;=====================
;=====================

; note: he falls into a crouch

phys_falling:
	.byte $5,$8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$9a,$9a,$aa
	.byte $aa,$aa,$bb,$99,$aa
	.byte $ab,$ba,$ba,$b0,$0b
	.byte $aa,$aa,$aa,$00,$00
	.byte $aa,$aa,$aa,$44,$44
	.byte $ca,$4c,$44,$a4,$aa
	.byte $f5,$f4,$aa,$aa,$aa



;=====================
;=====================
; CROUCHING
;=====================
;=====================

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


;=====================
;=====================
; SWIMMING
;=====================
;=====================

;=====================
;=====================
; COLLAPSING
;=====================
;=====================

	;=======================
	; I've got a match
	; your embrace, and my collapse

collapse_progression:
	.word	collapse1	; 00
	.word	collapse2	; 02
	.word	collapse3	; 04
	.word	collapse4	; 06
	.word	collapse5	; 08
	.word	collapse5	; 10
	.word	collapse5	; 12
	.word	collapse5	; 14
	.word	collapse5	; 16

collapse1:
	.byte $4,$8
;	.byte $aa,$aa,$9a,$9a
;	.byte $aa,$aa,$99,$ab
;	.byte $aa,$aa,$0b,$aa
;	.byte $aa,$aa,$bb,$aa
;	.byte $aa,$aa,$bb,$aa
;	.byte $aa,$aa,$44,$aa
;	.byte $aa,$4a,$a4,$aa
;	.byte $aa,$f4,$fa,$aa

	.byte $9a,$9a,$aa,$aa
	.byte $ab,$99,$aa,$aa
	.byte $aa,$0b,$aa,$aa
	.byte $aa,$bb,$aa,$aa
	.byte $aa,$bb,$aa,$aa
	.byte $aa,$44,$aa,$aa
	.byte $aa,$a4,$4a,$aa
	.byte $aa,$fa,$f4,$aa


collapse2:
	.byte $5,$8
;	.byte $aa,$aa,$aa,$aa,$aa
;	.byte $aa,$aa,$aa,$99,$b9
;	.byte $aa,$aa,$aa,$b9,$ab
;	.byte $aa,$aa,$aa,$b0,$aa
;	.byte $aa,$aa,$00,$bb,$aa
;	.byte $aa,$4a,$44,$bb,$aa
;	.byte $4a,$a4,$aa,$ab,$aa
;	.byte $f4,$fa,$aa,$aa,$aa

	.byte $aa,$aa,$aa,$aa,$aa
	.byte $b9,$99,$aa,$aa,$aa
	.byte $ab,$b9,$aa,$aa,$aa
	.byte $aa,$b0,$aa,$aa,$aa
	.byte $aa,$bb,$00,$aa,$aa
	.byte $aa,$bb,$44,$4a,$aa
	.byte $aa,$ab,$aa,$a4,$4a
	.byte $aa,$aa,$aa,$fa,$f4



collapse3:
	.byte $6,$8
;	.byte $aa,$aa,$aa,$aa,$aa,$aa
;	.byte $aa,$aa,$aa,$aa,$aa,$aa
;	.byte $aa,$aa,$aa,$aa,$9a,$9a
;	.byte $aa,$aa,$aa,$aa,$99,$bb
;	.byte $aa,$aa,$aa,$0a,$0b,$aa
;	.byte $aa,$aa,$4a,$00,$bb,$aa
;	.byte $fa,$44,$44,$a0,$bb,$aa
;	.byte $ff,$a4,$aa,$aa,$ab,$aa

	.byte $aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa
	.byte $9a,$9a,$aa,$aa,$aa,$aa
	.byte $bb,$99,$aa,$aa,$aa,$aa
	.byte $aa,$0b,$0a,$aa,$aa,$aa
	.byte $aa,$bb,$00,$4a,$aa,$aa
	.byte $aa,$bb,$a0,$44,$44,$fa
	.byte $aa,$ab,$aa,$aa,$a4,$ff

collapse4:
	.byte $7,$8
;	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
;	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
;	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
;	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
;	.byte $aa,$aa,$aa,$aa,$aa,$9a,$9a
;	.byte $aa,$aa,$aa,$0a,$00,$bb,$99
;	.byte $fa,$4a,$44,$00,$bb,$aa,$aa
;	.byte $ff,$a4,$aa,$bb,$aa,$aa,$aa

	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $9a,$9a,$aa,$aa,$aa,$aa,$aa
	.byte $99,$bb,$00,$0a,$aa,$aa,$aa
	.byte $aa,$aa,$bb,$00,$44,$4a,$fa
	.byte $aa,$aa,$aa,$bb,$aa,$a4,$ff


collapse5:
	.byte $8,$8
;	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
;	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
;	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
;	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
;	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
;	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
;	.byte $aa,$4a,$bb,$00,$b0,$00,$b9,$99
;	.byte $ff,$44,$b4,$bb,$aa,$aa,$ab,$a9

	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $99,$b9,$00,$b0,$00,$bb,$4a,$aa
	.byte $a9,$ab,$aa,$aa,$bb,$b4,$44,$ff



;=====================
;=====================
; JUMPING
;=====================
;=====================


phys_jump_progression:
	.word	jump1
	.word	jump2
	.word	jump3
	.word	jump4
	.word	jump5
	.word	jump6
	.word	jump7
	.word	jump8


jump1:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$44,$cc,$aa,$aa
	.byte $fa,$f4,$5c,$aa,$aa

jump2:
	.byte $5,$8
	.byte $9a,$9a,$aa,$aa,$aa
	.byte $bb,$99,$aa,$aa,$aa
	.byte $aa,$0b,$00,$aa,$aa
	.byte $aa,$00,$bb,$aa,$aa
	.byte $aa,$a0,$bb,$aa,$aa
	.byte $aa,$44,$cb,$aa,$aa
	.byte $aa,$44,$cc,$aa,$aa
	.byte $fa,$f4,$5c,$aa,$aa

jump3:
	.byte $5,$8
	.byte $9a,$9a,$aa,$aa,$aa
	.byte $bb,$99,$aa,$aa,$aa
	.byte $aa,$0b,$00,$aa,$aa
	.byte $aa,$00,$bb,$aa,$aa
	.byte $aa,$a0,$bb,$aa,$aa
	.byte $44,$c4,$cb,$aa,$aa
	.byte $a4,$4c,$cc,$cc,$aa
	.byte $fa,$f4,$5a,$a5,$aa

jump4:
	.byte $5,$8
	.byte $9a,$9a,$aa,$aa,$aa
	.byte $bb,$99,$aa,$aa,$aa
	.byte $aa,$0b,$00,$aa,$aa
	.byte $aa,$00,$bb,$aa,$aa
	.byte $aa,$a0,$bb,$aa,$aa
	.byte $aa,$4b,$c4,$ca,$5a
	.byte $aa,$44,$4c,$ac,$55
	.byte $aa,$aa,$f4,$f4,$aa

jump5:
	.byte $5,$8
	.byte $b9,$99,$aa,$aa,$aa
	.byte $ab,$b9,$aa,$aa,$aa
	.byte $ba,$b0,$0b,$aa,$aa
	.byte $aa,$aa,$00,$aa,$aa
	.byte $aa,$aa,$00,$aa,$aa
	.byte $aa,$cc,$44,$4a,$aa
	.byte $5a,$5c,$a4,$44,$fa
	.byte $aa,$aa,$aa,$aa,$af

jump6:
	.byte $5,$8
	.byte $aa,$b9,$99,$aa,$aa
	.byte $aa,$ab,$b9,$aa,$aa
	.byte $ab,$ba,$b0,$aa,$aa
	.byte $aa,$aa,$00,$aa,$aa
	.byte $aa,$aa,$40,$aa,$aa
	.byte $aa,$cc,$44,$4a,$fa
	.byte $aa,$cc,$a4,$a4,$ff
	.byte $a5,$a5,$aa,$aa,$aa

jump7:
	.byte $5,$8
	.byte $aa,$b9,$99,$aa,$aa
	.byte $aa,$ab,$b9,$aa,$aa
	.byte $aa,$aa,$b0,$aa,$aa
	.byte $ab,$ab,$00,$aa,$aa
	.byte $aa,$aa,$40,$aa,$aa
	.byte $aa,$cc,$44,$4a,$fa
	.byte $aa,$cc,$a4,$a4,$ff
	.byte $a5,$a5,$aa,$aa,$aa

jump8:
	.byte $5,$8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$b0,$bb,$aa,$aa
	.byte $aa,$aa,$40,$aa,$aa
	.byte $aa,$4a,$44,$aa,$aa
	.byte $aa,$44,$c4,$ca,$aa
	.byte $fa,$f4,$5a,$5c,$aa

