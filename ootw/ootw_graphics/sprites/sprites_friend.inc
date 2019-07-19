; note, for some reason these are all facing left

;=====================
;=====================
; STANDING
;=====================
;=====================

	;====================
	; Going Left

friend_stand:
        .byte $5,$8
        .byte $aa,$fa,$7f,$f7,$aa
        .byte $aa,$ff,$0f,$0f,$aa
        .byte $aa,$aa,$00,$ff,$aa
        .byte $aa,$aa,$00,$ff,$aa
        .byte $aa,$aa,$0f,$00,$aa
        .byte $aa,$aa,$ff,$a7,$7a
        .byte $aa,$aa,$0f,$aa,$07
        .byte $aa,$0a,$00,$0a,$00

;=====================
;=====================
; WALKING
;=====================
;=====================

friend_walk_progression:
	.word	friend_walk_left1
	.word	friend_walk_left2
	.word	friend_walk_left3
	.word	friend_walk_left4
	.word	friend_walk_left5
	.word	friend_walk_left6
	.word	friend_walk_left7
	.word	friend_walk_left8




friend_walk_left1:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$7a,$00,$ff,$aa
	.byte $aa,$77,$00,$ff,$aa
	.byte $aa,$aa,$00,$0f,$aa
	.byte $aa,$aa,$ff,$a7,$7a
	.byte $aa,$aa,$0f,$aa,$07
	.byte $aa,$a0,$00,$0a,$00

friend_walk_left2:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$7a,$ff,$0f,$aa
	.byte $aa,$aa,$0f,$00,$aa
	.byte $aa,$aa,$ff,$77,$aa
	.byte $aa,$aa,$0f,$aa,$07
	.byte $aa,$0a,$00,$00,$a0

friend_walk_left3:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$aa,$ff,$00,$aa
	.byte $aa,$aa,$0f,$00,$aa
	.byte $aa,$aa,$ff,$77,$aa
	.byte $aa,$aa,$0f,$00,$0a
	.byte $aa,$0a,$00,$aa,$a0

friend_walk_left4:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$aa,$ff,$00,$aa
	.byte $aa,$af,$00,$00,$aa
	.byte $aa,$aa,$ff,$77,$aa
	.byte $aa,$aa,$0f,$07,$aa
	.byte $aa,$0a,$00,$00,$aa

friend_walk_left5:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$aa,$ff,$00,$aa
	.byte $aa,$af,$00,$00,$aa
	.byte $aa,$7a,$77,$ff,$aa
	.byte $aa,$00,$af,$0f,$aa
	.byte $a0,$a0,$0a,$00,$aa

friend_walk_left6:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$aa,$ff,$0f,$7a
	.byte $aa,$aa,$0f,$00,$a7
	.byte $aa,$7a,$77,$ff,$fa
	.byte $aa,$07,$aa,$aa,$0f
	.byte $a0,$a0,$aa,$0a,$00

friend_walk_left7:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$aa,$00,$0f,$aa
	.byte $aa,$aa,$7f,$ff,$aa
	.byte $aa,$aa,$07,$af,$0f
	.byte $aa,$0a,$00,$00,$a0

friend_walk_left8:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$7a,$00,$ff,$fa
	.byte $aa,$a7,$00,$00,$af
	.byte $aa,$aa,$77,$ff,$aa
	.byte $aa,$aa,$a7,$0f,$aa
	.byte $aa,$aa,$00,$00,$aa



;=====================
;=====================
; RUNNING
;=====================
;=====================

friend_run_progression:
	.word	friend_run_left1
	.word	friend_run_left2
	.word	friend_run_left3
	.word	friend_run_left4
	.word	friend_run_left5
	.word	friend_run_left6
	.word	friend_run_left7
	.word	friend_run_left8

friend_run_left1:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$7a,$00,$ff,$aa
	.byte $aa,$77,$00,$ff,$aa
	.byte $aa,$aa,$00,$0f,$aa
	.byte $aa,$aa,$ff,$a7,$7a
	.byte $aa,$aa,$0f,$aa,$07
	.byte $aa,$a0,$00,$0a,$00

friend_run_left2:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$7a,$ff,$0f,$aa
	.byte $aa,$aa,$0f,$00,$aa
	.byte $aa,$aa,$ff,$77,$aa
	.byte $aa,$aa,$0f,$aa,$07
	.byte $aa,$0a,$00,$00,$a0

friend_run_left3:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$aa,$ff,$00,$aa
	.byte $aa,$aa,$0f,$00,$aa
	.byte $aa,$aa,$ff,$77,$aa
	.byte $aa,$aa,$0f,$00,$0a
	.byte $aa,$0a,$00,$aa,$a0

friend_run_left4:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$aa,$ff,$00,$aa
	.byte $aa,$af,$00,$00,$aa
	.byte $aa,$aa,$ff,$77,$aa
	.byte $aa,$aa,$0f,$07,$aa
	.byte $aa,$0a,$00,$00,$aa

friend_run_left5:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$aa,$ff,$00,$aa
	.byte $aa,$af,$00,$00,$aa
	.byte $aa,$7a,$77,$ff,$aa
	.byte $aa,$00,$af,$0f,$aa
	.byte $a0,$a0,$0a,$00,$aa

friend_run_left6:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$aa,$ff,$0f,$7a
	.byte $aa,$aa,$0f,$00,$a7
	.byte $aa,$7a,$77,$ff,$fa
	.byte $aa,$07,$aa,$aa,$0f
	.byte $a0,$a0,$aa,$0a,$00

friend_run_left7:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$aa,$00,$0f,$aa
	.byte $aa,$aa,$7f,$ff,$aa
	.byte $aa,$aa,$07,$af,$0f
	.byte $aa,$0a,$00,$00,$a0

friend_run_left8:
	.byte $5,$8
	.byte $aa,$fa,$7f,$f7,$aa
	.byte $aa,$ff,$0f,$0f,$aa
	.byte $aa,$aa,$00,$ff,$aa
	.byte $aa,$7a,$00,$ff,$fa
	.byte $aa,$a7,$00,$00,$af
	.byte $aa,$aa,$77,$ff,$aa
	.byte $aa,$aa,$a7,$0f,$aa
	.byte $aa,$aa,$00,$00,$aa


;=====================
;=====================
; JUMPING
;=====================
;=====================

;=====================
;=====================
; CROUCHING
;=====================
;=====================

friend_crouch_progression:
	.word	friend_crouch1
	.word	friend_crouch2

friend_crouch1:
	.byte $3,$8
	.byte $aa,$aa,$aa
	.byte $9a,$9a,$aa
	.byte $bb,$99,$aa
	.byte $aa,$0b,$aa
	.byte $aa,$bb,$aa
	.byte $aa,$bb,$aa
	.byte $44,$44,$aa
	.byte $5a,$fc,$f4

friend_crouch2:
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
; TURNING
;=====================
;=====================
friend_turning_sprite:
	.byte $5,$8
	.byte $aa,$57,$77,$aa,$aa
	.byte $0a,$05,$00,$0a,$aa
	.byte $77,$00,$00,$55,$aa
	.byte $77,$00,$00,$55,$aa
	.byte $aa,$00,$00,$a5,$aa
	.byte $aa,$77,$55,$aa,$aa
	.byte $07,$aa,$05,$aa,$aa
	.byte $00,$aa,$00,$aa,$aa


