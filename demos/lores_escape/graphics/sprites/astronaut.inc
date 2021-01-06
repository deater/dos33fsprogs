; these are all facing left

;=====================
;=====================
; STANDING
;=====================
;=====================

	;====================
	; Going Left

astro_stand:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$fa,$f2,$aa,$aa


;=====================
;=====================
; WALKING
;=====================
;=====================

astro_walk_progression:
	.word	astro_walk_left1
	.word	astro_walk_left2
	.word	astro_walk_left3
	.word	astro_walk_left4
	.word	astro_walk_left5
	.word	astro_walk_left6
	.word	astro_walk_left7
	.word	astro_walk_left8
	.word	astro_walk_left9
	.word	astro_walk_left10



astro_walk_left1:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$ab,$bb,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$22,$a2,$66,$aa
	.byte $af,$af,$fa,$f6,$aa

astro_walk_left2:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$ba,$bb,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$22,$a2,$66,$aa
	.byte $af,$f2,$fa,$f6,$aa

astro_walk_left3:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$ba,$2b,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$22,$a2,$66,$aa
	.byte $fa,$f2,$fa,$f6,$aa

astro_walk_left4:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$ba,$2b,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$22,$a2,$6a,$aa
	.byte $fa,$f2,$aa,$f6,$af

astro_walk_left5:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$bb,$22,$aa,$aa
	.byte $fa,$aa,$22,$aa,$aa
	.byte $aa,$66,$22,$aa,$aa
	.byte $aa,$ff,$f2,$aa,$aa

astro_walk_left6:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$ba,$2b,$aa,$aa
	.byte $aa,$6a,$22,$aa,$aa
	.byte $fa,$66,$a2,$2a,$aa
	.byte $aa,$af,$fa,$f2,$aa

astro_walk_left7:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$aa,$2b,$aa,$aa
	.byte $aa,$6a,$22,$aa,$aa
	.byte $aa,$66,$a2,$2a,$aa
	.byte $af,$f6,$fa,$f2,$aa

astro_walk_left8:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$ba,$2b,$aa,$aa
	.byte $aa,$6a,$22,$aa,$aa
	.byte $aa,$66,$a2,$22,$aa
	.byte $fa,$f6,$aa,$fa,$af

astro_walk_left9:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$aa,$62,$a2,$fa
	.byte $aa,$fa,$f6,$af,$aa

astro_walk_left10:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$ba,$bb,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$fa,$ff,$f6,$aa


;=====================
;=====================
; RUNNING
;=====================
;=====================

astro_run_progression:
	.word	astro_run_left1
	.word	astro_run_left2
	.word	astro_run_left3
	.word	astro_run_left4
	.word	astro_run_left5
	.word	astro_run_left6
	.word	astro_run_left7
	.word	astro_run_left8
	.word	astro_run_left9
	.word	astro_run_left9

astro_run_left1:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$a8,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$ba,$2b,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$aa,$22,$a6,$ff
	.byte $aa,$fa,$f2,$aa,$aa

astro_run_left2:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$aa,$aa
	.byte $aa,$aa,$2b,$8a,$aa
	.byte $aa,$a2,$bb,$88,$aa
	.byte $ba,$ab,$22,$aa,$aa
	.byte $aa,$6a,$22,$aa,$aa
	.byte $aa,$a6,$22,$2a,$aa
	.byte $aa,$aa,$fa,$f2,$aa

astro_run_left3:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $ab,$ab,$22,$aa,$aa
	.byte $aa,$6a,$22,$aa,$aa
	.byte $aa,$66,$a2,$2a,$aa
	.byte $af,$af,$fa,$af,$aa

astro_run_left4:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$a8,$aa
	.byte $ba,$b2,$2b,$aa,$aa
	.byte $aa,$ab,$22,$aa,$aa
	.byte $aa,$6a,$22,$aa,$aa
	.byte $aa,$66,$aa,$22,$aa
	.byte $fa,$af,$aa,$fa,$af

astro_run_left5:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$a8,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$ab,$2b,$aa,$aa
	.byte $aa,$aa,$22,$2a,$fa
	.byte $aa,$66,$aa,$aa,$af
	.byte $fa,$f6,$aa,$aa,$aa

astro_run_left6:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$aa,$aa
	.byte $aa,$aa,$2b,$aa,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$ab,$22,$aa,$aa
	.byte $aa,$aa,$22,$2a,$fa
	.byte $aa,$aa,$66,$aa,$af
	.byte $aa,$fa,$f6,$aa,$aa

astro_run_left7:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$ab,$2b,$aa,$aa
	.byte $aa,$2a,$22,$aa,$aa
	.byte $aa,$a2,$62,$ff,$aa
	.byte $aa,$fa,$f6,$aa,$aa

astro_run_left8:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$b2,$bb,$aa,$aa
	.byte $aa,$aa,$2b,$ba,$aa
	.byte $aa,$2a,$22,$aa,$aa
	.byte $aa,$22,$a6,$6a,$aa
	.byte $af,$af,$fa,$f6,$aa

astro_run_left9:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$a8,$aa
	.byte $aa,$b2,$2b,$bb,$aa
	.byte $aa,$aa,$22,$bb,$aa
	.byte $aa,$aa,$22,$6a,$aa
	.byte $aa,$22,$aa,$66,$aa
	.byte $fa,$f2,$aa,$fa,$f6


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

; note: she needs to be facing left by default
kick1:
.if 0
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$ba,$2b,$aa,$aa
	.byte $bb,$ab,$22,$ba,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$22,$a2,$6a,$aa
	.byte $af,$f2,$5a,$56,$aa
.endif

;=====================
;=====================
; SHOOTING
;=====================
;=====================

shooting1:
	.byte 5,8
	.byte $AA,$AA,$8A,$8A,$AA
	.byte $AA,$AA,$bb,$88,$8A
	.byte $0A,$0A,$AA,$2B,$88
	.byte $AA,$A0,$AB,$B2,$AA
	.byte $AA,$AA,$AA,$22,$AA
	.byte $AA,$AA,$AA,$22,$AA
	.byte $AA,$AA,$22,$62,$AA
	.byte $AA,$fA,$f2,$fA,$f6


;=====================
;=====================
; FALLING
;=====================
;=====================

; note: she falls into a crouch

astro_falling:
.if 0
	.byte 5,8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$8a,$8a,$aa
	.byte $aa,$aa,$bb,$88,$aa
	.byte $ab,$ba,$ba,$b2,$2b
	.byte $aa,$aa,$aa,$22,$22
	.byte $aa,$aa,$aa,$22,$22
	.byte $6a,$26,$22,$a2,$aa
	.byte $f5,$f2,$aa,$aa,$aa
.endif


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
	.byte $8a,$8a,$aa
	.byte $bb,$88,$8a
	.byte $aa,$2b,$88
	.byte $aa,$bb,$aa
	.byte $aa,$bb,$aa
	.byte $22,$22,$aa
	.byte $5a,$f6,$f2

crouch2:
	.byte 5,8
	.byte $AA,$aa,$aa,$aa,$AA
	.byte $AA,$aa,$aa,$aa,$AA
	.byte $AA,$8a,$8a,$aa,$AA
	.byte $AA,$bb,$88,$8a,$AA
	.byte $AA,$aa,$2b,$28,$AA
	.byte $AA,$aa,$bb,$22,$AA
	.byte $AA,$ba,$2b,$aa,$AA
	.byte $AA,$52,$f2,$f2,$AA


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
.if 0
	.byte 4,8
	.byte $8a,$8a,$aa,$aa
	.byte $ab,$88,$aa,$aa
	.byte $aa,$0b,$aa,$aa
	.byte $aa,$bb,$aa,$aa
	.byte $aa,$bb,$aa,$aa
	.byte $aa,$22,$aa,$aa
	.byte $aa,$a2,$2a,$aa
	.byte $aa,$fa,$f2,$aa
.endif

collapse2:
.if 0
	.byte 5,8
	.byte $aa,$aa,$aa,$aa,$aa
	.byte $b8,$88,$aa,$aa,$aa
	.byte $ab,$b8,$aa,$aa,$aa
	.byte $aa,$b2,$aa,$aa,$aa
	.byte $aa,$bb,$22,$aa,$aa
	.byte $aa,$bb,$22,$2a,$aa
	.byte $aa,$ab,$aa,$a2,$2a
	.byte $aa,$aa,$aa,$fa,$f2
.endif


collapse3:
.if 0
	.byte 6,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa
	.byte $8a,$8a,$aa,$aa,$aa,$aa
	.byte $bb,$88,$aa,$aa,$aa,$aa
	.byte $aa,$2b,$2a,$aa,$aa,$aa
	.byte $aa,$bb,$22,$2a,$aa,$aa
	.byte $aa,$bb,$a2,$22,$22,$fa
	.byte $aa,$ab,$aa,$aa,$a2,$ff
.endif

collapse4:
.if 0
	.byte 7,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $8a,$8a,$aa,$aa,$aa,$aa,$aa
	.byte $88,$bb,$22,$2a,$aa,$aa,$aa
	.byte $aa,$aa,$bb,$22,$22,$2a,$fa
	.byte $aa,$aa,$aa,$bb,$aa,$a2,$ff
.endif

collapse5:
.if 0
	.byte 8,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $88,$b8,$22,$b2,$22,$bb,$2a,$aa
	.byte $a8,$ab,$aa,$aa,$bb,$b2,$22,$ff
.endif


;=====================
;=====================
; JUMPING
;=====================
;=====================


astro_jump_progression:
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
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$aa,$bb,$aa,$aa
	.byte $aa,$ba,$2b,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$22,$66,$aa,$aa
	.byte $fa,$f2,$56,$aa,$aa

jump2:
	.byte 5,8
	.byte $8a,$8a,$aa,$aa,$aa
	.byte $bb,$88,$8a,$8a,$aa
	.byte $aa,$2b,$22,$aa,$aa
	.byte $aa,$22,$bb,$aa,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$22,$6b,$aa,$aa
	.byte $aa,$22,$66,$aa,$aa
	.byte $fa,$f2,$56,$aa,$aa

jump3:
	.byte 5,8
	.byte $8a,$8a,$aa,$aa,$aa
	.byte $bb,$88,$8a,$8a,$aa
	.byte $aa,$2b,$22,$aa,$aa
	.byte $aa,$22,$bb,$aa,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $22,$62,$6b,$aa,$aa
	.byte $a2,$26,$66,$66,$aa
	.byte $fa,$f2,$5a,$a5,$aa

jump4:
	.byte 5,8
	.byte $8a,$8a,$aa,$aa,$aa
	.byte $bb,$88,$8a,$8a,$aa
	.byte $aa,$2b,$22,$aa,$aa
	.byte $aa,$22,$bb,$aa,$aa
	.byte $aa,$a2,$bb,$aa,$aa
	.byte $aa,$2b,$62,$6a,$5a
	.byte $aa,$22,$26,$a6,$55
	.byte $aa,$aa,$f2,$f2,$aa

jump5:
	.byte 5,8
	.byte $b8,$88,$aa,$aa,$aa
	.byte $ab,$b8,$8a,$8a,$aa
	.byte $ba,$b2,$2b,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$66,$22,$2a,$aa
	.byte $5a,$56,$a2,$22,$fa
	.byte $aa,$aa,$aa,$aa,$af

jump6:
	.byte 5,8
	.byte $aa,$b8,$88,$aa,$aa
	.byte $aa,$ab,$b8,$8a,$aa
	.byte $ab,$ba,$b2,$aa,$a8
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$66,$22,$2a,$fa
	.byte $aa,$66,$a2,$a2,$ff
	.byte $a5,$a5,$aa,$aa,$aa

jump7:
	.byte 5,8
	.byte $aa,$b8,$88,$aa,$aa
	.byte $aa,$ab,$b8,$8a,$aa
	.byte $aa,$aa,$b2,$a8,$aa
	.byte $ab,$ab,$22,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$66,$22,$2a,$fa
	.byte $aa,$66,$a2,$a2,$ff
	.byte $a5,$a5,$aa,$aa,$aa

jump8:
	.byte 5,8
	.byte $aa,$8a,$8a,$aa,$aa
	.byte $aa,$bb,$88,$8a,$aa
	.byte $aa,$aa,$2b,$88,$aa
	.byte $aa,$b2,$bb,$aa,$aa
	.byte $aa,$aa,$22,$aa,$aa
	.byte $aa,$2a,$22,$aa,$aa
	.byte $aa,$22,$62,$6a,$aa
	.byte $fa,$f2,$5a,$56,$aa


;====================
;====================
; On Spike
;====================
;====================

; 9x40
astronaut_spike_sprite:
.if 0
        .byte 3,4
        .byte $AA,$11,$AA
        .byte $2A,$82,$2A
        .byte $BB,$A8,$BB
        .byte $BB,$AA,$BB
.endif


;=====================
;=====================
; CROUCH SHOOTING
;=====================
;=====================

crouch_shooting:
	.byte 5,8
	.byte $AA,$AA,$aa,$aa,$aa
	.byte $AA,$AA,$aa,$aa,$aa
	.byte $AA,$AA,$8a,$8a,$aa
	.byte $AA,$AA,$bb,$88,$8a
	.byte $0A,$0A,$aa,$2b,$28
	.byte $AA,$A0,$ba,$bb,$22
	.byte $AA,$AA,$2a,$2b,$aa
	.byte $AA,$AA,$52,$f2,$f2

;=====================
;=====================
; CROUCH KICKING
;=====================
;=====================

crouch_kicking:
.if 0
	.byte 5,8
	.byte $AA,$AA,$aa,$aa,$aa
	.byte $AA,$AA,$aa,$aa,$aa
	.byte $AA,$AA,$8a,$8a,$aa
	.byte $AA,$AA,$bb,$88,$8a
	.byte $AA,$AA,$aa,$2b,$28
	.byte $AA,$AA,$aa,$bb,$22
	.byte $AA,$AA,$2a,$bb,$a2
	.byte $5A,$56,$A2,$f2,$f2
.endif



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



