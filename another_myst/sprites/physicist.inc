; note, for some reason these are all facing left
; also note: too lazy to make separate sprites for running w/ gun
;	don't think it would work well at this resolution anyway
;	also technically should have separate sprites for facing left/right
;	rather than cheating and just mirror-flipping it

; TODO:
;	zapped by laser


;=====================
;=====================
; STANDING
;=====================
;=====================

	;====================
	; Going Left

phys_stand:
	.byte 5,8
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
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ab,$bb,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$44,$a4,$cc,$aa
	.byte $af,$af,$7a,$7c,$aa

phys_walk_left2:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$bb,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$44,$a4,$cc,$aa
	.byte $af,$f4,$7a,$7c,$aa

phys_walk_left3:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$44,$a4,$cc,$aa
	.byte $fa,$f4,$7a,$7c,$aa

phys_walk_left4:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$44,$a4,$ca,$aa
	.byte $fa,$f4,$aa,$7c,$a7

phys_walk_left5:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$bb,$00,$aa,$aa
	.byte $7a,$aa,$44,$aa,$aa
	.byte $aa,$cc,$44,$aa,$aa
	.byte $aa,$f7,$f4,$aa,$aa

phys_walk_left6:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $aa,$ca,$44,$aa,$aa
	.byte $7a,$cc,$a4,$4a,$aa
	.byte $aa,$a7,$fa,$f4,$aa

phys_walk_left7:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$ca,$44,$aa,$aa
	.byte $aa,$cc,$a4,$4a,$aa
	.byte $a7,$7c,$fa,$f4,$aa

phys_walk_left8:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $aa,$ca,$44,$aa,$aa
	.byte $aa,$cc,$a4,$44,$aa
	.byte $7a,$7c,$aa,$fa,$af

phys_walk_left9:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$aa,$c4,$a4,$fa
	.byte $aa,$7a,$7c,$af,$aa

phys_walk_left10:
	.byte 5,8
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
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$aa,$44,$ac,$77
	.byte $aa,$fa,$f4,$aa,$aa

phys_run_left2:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $ba,$ab,$00,$aa,$aa
	.byte $aa,$ca,$44,$aa,$aa
	.byte $aa,$ac,$44,$4a,$aa
	.byte $aa,$aa,$fa,$f4,$aa

phys_run_left3:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $ab,$ab,$00,$aa,$aa
	.byte $aa,$ca,$44,$aa,$aa
	.byte $aa,$cc,$a4,$4a,$aa
	.byte $a7,$a7,$fa,$af,$aa

phys_run_left4:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $ba,$ba,$0b,$aa,$aa
	.byte $aa,$ab,$00,$aa,$aa
	.byte $aa,$ca,$44,$aa,$aa
	.byte $aa,$cc,$aa,$44,$aa
	.byte $7a,$a7,$aa,$fa,$af

phys_run_left5:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ab,$0b,$aa,$aa
	.byte $aa,$aa,$44,$4a,$fa
	.byte $aa,$cc,$aa,$aa,$af
	.byte $7a,$7c,$aa,$aa,$aa

phys_run_left6:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ab,$00,$aa,$aa
	.byte $aa,$aa,$44,$4a,$fa
	.byte $aa,$aa,$cc,$aa,$af
	.byte $aa,$7a,$7c,$aa,$aa

phys_run_left7:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ab,$0b,$aa,$aa
	.byte $aa,$4a,$44,$aa,$aa
	.byte $aa,$a4,$c4,$ff,$aa
	.byte $aa,$7a,$7c,$aa,$aa

phys_run_left8:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$ba,$bb,$aa,$aa
	.byte $aa,$aa,$0b,$ba,$aa
	.byte $aa,$4a,$44,$aa,$aa
	.byte $aa,$44,$ac,$ca,$aa
	.byte $af,$af,$7a,$7c,$aa

phys_run_left9:
	.byte 5,8
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
	.byte 5,8
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
; SHOOTING
;=====================
;=====================

shooting1:
	.byte 5,8
	.byte $AA,$AA,$9A,$9A,$AA
	.byte $AA,$AA,$bb,$99,$AA
	.byte $0A,$0A,$AA,$0B,$AA
	.byte $AA,$A0,$AB,$B0,$AA
	.byte $AA,$AA,$AA,$00,$AA
	.byte $AA,$AA,$AA,$44,$AA
	.byte $AA,$AA,$44,$c4,$AA
	.byte $AA,$fA,$f4,$7A,$7C


;=====================
;=====================
; FALLING
;=====================
;=====================

; note: he falls into a crouch

phys_falling:
	.byte 5,8
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
	.byte 3,8
	.byte $aa,$aa,$aa
	.byte $9a,$9a,$aa
	.byte $bb,$99,$aa
	.byte $aa,$0b,$aa
	.byte $aa,$bb,$aa
	.byte $aa,$bb,$aa
	.byte $44,$44,$aa
	.byte $5a,$fc,$f4

crouch2:
	.byte 5,8
	.byte $AA,$aa,$aa,$aa,$AA
	.byte $AA,$aa,$aa,$aa,$AA
	.byte $AA,$9a,$9a,$aa,$AA
	.byte $AA,$bb,$99,$aa,$AA
	.byte $AA,$aa,$0b,$0a,$AA
	.byte $AA,$aa,$bb,$00,$AA
	.byte $AA,$ba,$4b,$aa,$AA
	.byte $AA,$54,$f4,$f4,$AA


;=====================
;=====================
; SWIMMING
;=====================
;=====================

; see physicist_l1_swim.inc

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
	.byte 4,8
	.byte $9a,$9a,$aa,$aa
	.byte $ab,$99,$aa,$aa
	.byte $aa,$0b,$aa,$aa
	.byte $aa,$bb,$aa,$aa
	.byte $aa,$bb,$aa,$aa
	.byte $aa,$44,$aa,$aa
	.byte $aa,$a4,$4a,$aa
	.byte $aa,$fa,$f4,$aa


collapse2:
	.byte 5,8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $b9,$99,$aa,$aa,$aa
	.byte $ab,$b9,$aa,$aa,$aa
	.byte $aa,$b0,$aa,$aa,$aa
	.byte $aa,$bb,$00,$aa,$aa
	.byte $aa,$bb,$44,$4a,$aa
	.byte $aa,$ab,$aa,$a4,$4a
	.byte $aa,$aa,$aa,$fa,$f4



collapse3:
	.byte 6,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa
	.byte $9a,$9a,$aa,$aa,$aa,$aa
	.byte $bb,$99,$aa,$aa,$aa,$aa
	.byte $aa,$0b,$0a,$aa,$aa,$aa
	.byte $aa,$bb,$00,$4a,$aa,$aa
	.byte $aa,$bb,$a0,$44,$44,$fa
	.byte $aa,$ab,$aa,$aa,$a4,$ff

collapse4:
	.byte 7,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $9a,$9a,$aa,$aa,$aa,$aa,$aa
	.byte $99,$bb,$00,$0a,$aa,$aa,$aa
	.byte $aa,$aa,$bb,$00,$44,$4a,$fa
	.byte $aa,$aa,$aa,$bb,$aa,$a4,$ff


collapse5:
	.byte 8,8
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
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$0b,$aa,$aa
	.byte $aa,$aa,$44,$aa,$aa
	.byte $aa,$44,$cc,$aa,$aa
	.byte $fa,$f4,$5c,$aa,$aa

jump2:
	.byte 5,8
	.byte $9a,$9a,$aa,$aa,$aa
	.byte $bb,$99,$aa,$aa,$aa
	.byte $aa,$0b,$00,$aa,$aa
	.byte $aa,$00,$bb,$aa,$aa
	.byte $aa,$a0,$bb,$aa,$aa
	.byte $aa,$44,$cb,$aa,$aa
	.byte $aa,$44,$cc,$aa,$aa
	.byte $fa,$f4,$5c,$aa,$aa

jump3:
	.byte 5,8
	.byte $9a,$9a,$aa,$aa,$aa
	.byte $bb,$99,$aa,$aa,$aa
	.byte $aa,$0b,$00,$aa,$aa
	.byte $aa,$00,$bb,$aa,$aa
	.byte $aa,$a0,$bb,$aa,$aa
	.byte $44,$c4,$cb,$aa,$aa
	.byte $a4,$4c,$cc,$cc,$aa
	.byte $fa,$f4,$5a,$a5,$aa

jump4:
	.byte 5,8
	.byte $9a,$9a,$aa,$aa,$aa
	.byte $bb,$99,$aa,$aa,$aa
	.byte $aa,$0b,$00,$aa,$aa
	.byte $aa,$00,$bb,$aa,$aa
	.byte $aa,$a0,$bb,$aa,$aa
	.byte $aa,$4b,$c4,$ca,$5a
	.byte $aa,$44,$4c,$ac,$55
	.byte $aa,$aa,$f4,$f4,$aa

jump5:
	.byte 5,8
	.byte $b9,$99,$aa,$aa,$aa
	.byte $ab,$b9,$aa,$aa,$aa
	.byte $ba,$b0,$0b,$aa,$aa
	.byte $aa,$aa,$00,$aa,$aa
	.byte $aa,$aa,$00,$aa,$aa
	.byte $aa,$cc,$44,$4a,$aa
	.byte $5a,$5c,$a4,$44,$fa
	.byte $aa,$aa,$aa,$aa,$af

jump6:
	.byte 5,8
	.byte $aa,$b9,$99,$aa,$aa
	.byte $aa,$ab,$b9,$aa,$aa
	.byte $ab,$ba,$b0,$aa,$aa
	.byte $aa,$aa,$00,$aa,$aa
	.byte $aa,$aa,$40,$aa,$aa
	.byte $aa,$cc,$44,$4a,$fa
	.byte $aa,$cc,$a4,$a4,$ff
	.byte $a5,$a5,$aa,$aa,$aa

jump7:
	.byte 5,8
	.byte $aa,$b9,$99,$aa,$aa
	.byte $aa,$ab,$b9,$aa,$aa
	.byte $aa,$aa,$b0,$aa,$aa
	.byte $ab,$ab,$00,$aa,$aa
	.byte $aa,$aa,$40,$aa,$aa
	.byte $aa,$cc,$44,$4a,$fa
	.byte $aa,$cc,$a4,$a4,$ff
	.byte $a5,$a5,$aa,$aa,$aa

jump8:
	.byte 5,8
	.byte $aa,$9a,$9a,$aa,$aa
	.byte $aa,$bb,$99,$aa,$aa
	.byte $aa,$aa,$0b,$aa,$aa
	.byte $aa,$b0,$bb,$aa,$aa
	.byte $aa,$aa,$40,$aa,$aa
	.byte $aa,$4a,$44,$aa,$aa
	.byte $aa,$44,$c4,$ca,$aa
	.byte $fa,$f4,$5a,$5c,$aa


;====================
;====================
; On Spike
;====================
;====================

; 9x40
physicist_spike_sprite:
        .byte 3,4
        .byte $AA,$11,$AA
        .byte $0A,$90,$0A
        .byte $BB,$A9,$BB
        .byte $BB,$AA,$BB



;=====================
;=====================
; CROUCH SHOOTING
;=====================
;=====================

crouch_shooting:
	.byte 5,8
	.byte $AA,$AA,$aa,$aa,$aa
	.byte $AA,$AA,$aa,$aa,$aa
	.byte $AA,$AA,$9a,$9a,$aa
	.byte $AA,$AA,$bb,$99,$aa
	.byte $0A,$0A,$aa,$0b,$0a
	.byte $AA,$A0,$ba,$bb,$00
	.byte $AA,$AA,$4a,$4b,$aa
	.byte $AA,$AA,$54,$f4,$f4

;=====================
;=====================
; CROUCH KICKING
;=====================
;=====================

crouch_kicking:
	.byte 5,8
	.byte $AA,$AA,$aa,$aa,$aa
	.byte $AA,$AA,$aa,$aa,$aa
	.byte $AA,$AA,$9a,$9a,$aa
	.byte $AA,$AA,$bb,$99,$aa
	.byte $AA,$AA,$aa,$0b,$0a
	.byte $AA,$AA,$aa,$bb,$00
	.byte $AA,$AA,$4a,$bb,$a0
	.byte $5A,$5C,$A4,$f4,$f4




;=====================
;=====================
; DISINTEGRATING
;=====================
;=====================

disintegrate_progression:
        .word   disintegrating_2  ; 0
        .word   disintegrating_3  ; 1
        .word   disintegrating_4  ; 2
        .word   disintegrating_4  ; 3
        .word   disintegrating_4  ; 4
        .word   disintegrating_4  ; 5
        .word   disintegrating_3  ; 6
        .word   disintegrating_9  ; 7
        .word   disintegrating_10 ; 8
        .word   disintegrating_11 ; 9
        .word   disintegrating_12 ; 10
        .word   disintegrating_13 ; 11
        .word   disintegrating_14 ; 12
        .word   disintegrating_14 ; 13

disintegrating_2:
	.byte 5,8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $ee,$fe,$fe,$ee,$aa
	.byte $ee,$ff,$ff,$ee,$aa
	.byte $aa,$ee,$ff,$ee,$aa
	.byte $ae,$ef,$ff,$ee,$aa
	.byte $aa,$ee,$ff,$ee,$aa
	.byte $aa,$ee,$ff,$ee,$aa
	.byte $ff,$fe,$ff,$ee,$aa

disintegrating_3:
	.byte 5,8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$fa,$fa,$aa,$aa
	.byte $aa,$ff,$ff,$aa,$aa
	.byte $aa,$aa,$fa,$aa,$aa
	.byte $aa,$af,$fa,$aa,$aa
	.byte $aa,$aa,$fa,$aa,$aa
	.byte $aa,$aa,$ff,$aa,$aa
	.byte $aa,$fa,$ff,$aa,$aa

disintegrating_4:
	.byte 5,8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$0a,$0a,$aa,$aa
	.byte $aa,$00,$00,$aa,$aa
	.byte $aa,$aa,$0a,$aa,$aa
	.byte $aa,$a0,$0a,$aa,$aa
	.byte $aa,$aa,$0a,$aa,$aa
	.byte $aa,$aa,$00,$aa,$aa
	.byte $aa,$0a,$00,$aa,$aa

disintegrating_9:
	.byte 5,8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $fa,$aa,$af,$aa,$aa
	.byte $aa,$5a,$aa,$af,$aa
	.byte $aa,$aa,$aa,$0a,$aa
	.byte $af,$aa,$0a,$aa,$aa
	.byte $aa,$aa,$aa,$fa,$aa
	.byte $af,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$fa,$aa,$aa

disintegrating_10:
	.byte 5,8
	.byte $fa,$aa,$af,$aa,$aa
	.byte $aa,$5a,$aa,$aa,$fa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $fa,$aa,$aa,$aa,$a0
	.byte $aa,$aa,$aa,$0a,$aa
	.byte $aa,$aa,$aa,$aa,$5a
	.byte $fa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$fa,$aa,$aa

disintegrating_11:
	.byte 5,8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$fa,$aa,$aa
	.byte $af,$aa,$aa,$aa,$af
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $fa,$aa,$aa,$aa,$a0
	.byte $aa,$aa,$aa,$0a,$fa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $af,$aa,$fa,$aa,$aa

disintegrating_12:
	.byte 5,8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$fa,$aa,$aa
	.byte $aa,$af,$aa,$aa,$fa
	.byte $fa,$a5,$aa,$0a,$aa
	.byte $aa,$aa,$aa,$aa,$a0
	.byte $fa,$aa,$fa,$aa,$aa

disintegrating_13:
	.byte 5,8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$af,$aa,$aa
	.byte $aa,$4a,$aa,$0a,$a0
	.byte $fa,$aa,$5a,$aa,$af

disintegrating_14:
	.byte 5,8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $fa,$5a,$5a,$0a,$fa



