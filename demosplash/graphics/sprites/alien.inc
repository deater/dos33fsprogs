; note, for some reason these are all facing left

;=====================
;=====================
; STANDING
;=====================
;=====================

	;====================
	; Going Left

alien_stand:
	.byte 10,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$99,$aa,$aa,$f9,$aa,$f9,$aa,$aa,$99
	.byte $aa,$99,$aa,$aa,$40,$aa,$40,$aa,$aa,$99
	.byte $aa,$99,$aa,$aa,$44,$aa,$44,$aa,$aa,$99
	.byte $aa,$a9,$ca,$7c,$fc,$7c,$fc,$7c,$ca,$a9
	.byte $aa,$aa,$ac,$cf,$c7,$cf,$c7,$cf,$ac,$aa
	.byte $aa,$aa,$aa,$99,$aa,$aa,$aa,$99,$aa,$aa
	.byte $aa,$aa,$9a,$99,$aa,$aa,$aa,$99,$9a,$aa



;=====================
;=====================
; WALKING
;=====================
;=====================

alien_walk_progression:
	.word	alien_walk_left1
	.word	alien_walk_left2
	.word	alien_walk_left3
	.word	alien_walk_left4
	.word	alien_walk_left5
	.word	alien_walk_left6
	.word	alien_walk_left7
	.word	alien_walk_left8




alien_walk_left1:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$5a,$00,$77,$aa
	.byte $aa,$55,$10,$77,$aa
	.byte $aa,$aa,$00,$07,$aa
	.byte $aa,$aa,$77,$a5,$5a
	.byte $aa,$aa,$07,$aa,$05
	.byte $aa,$a0,$00,$0a,$00
.endif

alien_walk_left2:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$5a,$77,$17,$aa
	.byte $aa,$aa,$07,$00,$aa
	.byte $aa,$aa,$77,$55,$aa
	.byte $aa,$aa,$07,$aa,$05
	.byte $aa,$0a,$00,$00,$a0
.endif
alien_walk_left3:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$aa,$77,$10,$aa
	.byte $aa,$aa,$07,$00,$aa
	.byte $aa,$aa,$77,$55,$aa
	.byte $aa,$aa,$07,$00,$0a
	.byte $aa,$0a,$00,$aa,$a0
.endif
alien_walk_left4:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$aa,$77,$10,$aa
	.byte $aa,$a7,$00,$00,$aa
	.byte $aa,$aa,$77,$55,$aa
	.byte $aa,$aa,$07,$05,$aa
	.byte $aa,$0a,$00,$00,$aa
.endif
alien_walk_left5:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$aa,$77,$10,$aa
	.byte $aa,$a7,$00,$00,$aa
	.byte $aa,$5a,$55,$77,$aa
	.byte $aa,$00,$a7,$07,$aa
	.byte $a0,$a0,$0a,$00,$aa
.endif
alien_walk_left6:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$aa,$77,$17,$5a
	.byte $aa,$aa,$07,$00,$a5
	.byte $aa,$5a,$55,$77,$7a
	.byte $aa,$05,$aa,$aa,$07
	.byte $a0,$a0,$aa,$0a,$00
.endif
alien_walk_left7:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$aa,$10,$77,$aa
	.byte $aa,$aa,$00,$07,$aa
	.byte $aa,$aa,$57,$77,$aa
	.byte $aa,$aa,$05,$a7,$07
	.byte $aa,$0a,$00,$00,$a0
.endif
alien_walk_left8:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$5a,$10,$77,$7a
	.byte $aa,$a5,$00,$00,$a7
	.byte $aa,$aa,$55,$77,$aa
	.byte $aa,$aa,$a5,$07,$aa
	.byte $aa,$aa,$00,$00,$aa
.endif

;=====================
;=====================
; WALKING with gun
;=====================
;=====================

alien_walk_gun_progression:
	.word	alien_walk_gun_left1
	.word	alien_walk_gun_left2
	.word	alien_walk_gun_left3
	.word	alien_walk_gun_left4
	.word	alien_walk_gun_left5
	.word	alien_walk_gun_left6
	.word	alien_walk_gun_left7
	.word	alien_walk_gun_left8


alien_walk_gun_left1:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $a0,$5a,$00,$77,$aa
	.byte $aa,$aa,$10,$77,$aa
	.byte $aa,$aa,$00,$07,$aa
	.byte $aa,$aa,$77,$a5,$5a
	.byte $aa,$aa,$07,$aa,$05
	.byte $aa,$a0,$00,$0a,$00
.endif

alien_walk_gun_left2:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $0a,$aa,$00,$77,$aa
	.byte $aa,$5a,$77,$17,$aa
	.byte $aa,$aa,$07,$00,$aa
	.byte $aa,$aa,$77,$55,$aa
	.byte $aa,$aa,$07,$aa,$05
	.byte $aa,$0a,$00,$00,$a0
.endif
alien_walk_gun_left3:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $0a,$aa,$00,$77,$aa
	.byte $aa,$aa,$77,$10,$aa
	.byte $aa,$a5,$07,$00,$aa
	.byte $aa,$aa,$77,$55,$aa
	.byte $aa,$aa,$07,$00,$0a
	.byte $aa,$0a,$00,$aa,$a0
.endif
alien_walk_gun_left4:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $0a,$aa,$00,$77,$aa
	.byte $aa,$a5,$77,$10,$aa
	.byte $aa,$a7,$00,$00,$aa
	.byte $aa,$aa,$77,$55,$aa
	.byte $aa,$aa,$07,$05,$aa
	.byte $aa,$0a,$00,$00,$aa
.endif
alien_walk_gun_left5:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $a0,$5a,$00,$77,$aa
	.byte $aa,$aa,$77,$10,$aa
	.byte $aa,$a7,$00,$00,$aa
	.byte $aa,$5a,$55,$77,$aa
	.byte $aa,$00,$a7,$07,$aa
	.byte $a0,$a0,$0a,$00,$aa
.endif
alien_walk_gun_left6:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $a0,$5a,$00,$77,$aa
	.byte $aa,$aa,$77,$17,$aa
	.byte $aa,$aa,$07,$00,$aa
	.byte $aa,$5a,$55,$77,$7a
	.byte $aa,$05,$aa,$aa,$07
	.byte $a0,$a0,$aa,$0a,$00
.endif
alien_walk_gun_left7:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $0a,$aa,$00,$77,$aa
	.byte $aa,$a5,$10,$77,$aa
	.byte $aa,$aa,$00,$07,$aa
	.byte $aa,$aa,$57,$77,$aa
	.byte $aa,$aa,$05,$a7,$07
	.byte $aa,$0a,$00,$00,$a0
.endif
alien_walk_gun_left8:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $0a,$aa,$00,$77,$aa
	.byte $aa,$a5,$10,$77,$7a
	.byte $aa,$aa,$00,$00,$a7
	.byte $aa,$aa,$55,$77,$aa
	.byte $aa,$aa,$a5,$07,$aa
	.byte $aa,$aa,$00,$00,$aa
.endif

;=====================
;=====================
; RUNNING
;=====================
;=====================

alien_run_progression:
	.word	alien_run_left1
	.word	alien_run_left2
	.word	alien_run_left3
	.word	alien_run_left4
	.word	alien_run_left5
	.word	alien_run_left6
	.word	alien_run_left7
	.word	alien_run_left8

alien_run_left1:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$5a,$00,$77,$aa
	.byte $aa,$55,$10,$77,$aa
	.byte $aa,$aa,$00,$07,$aa
	.byte $aa,$aa,$77,$a5,$5a
	.byte $aa,$aa,$07,$aa,$05
	.byte $aa,$a0,$00,$0a,$00
.endif
alien_run_left2:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$5a,$77,$17,$aa
	.byte $aa,$aa,$07,$00,$aa
	.byte $aa,$aa,$77,$55,$aa
	.byte $aa,$aa,$07,$aa,$05
	.byte $aa,$0a,$00,$00,$a0
.endif
alien_run_left3:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$aa,$77,$10,$aa
	.byte $aa,$aa,$07,$00,$aa
	.byte $aa,$aa,$77,$55,$aa
	.byte $aa,$aa,$07,$00,$0a
	.byte $aa,$0a,$00,$aa,$a0
.endif

alien_run_left4:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$aa,$77,$10,$aa
	.byte $aa,$a7,$00,$00,$aa
	.byte $aa,$aa,$77,$55,$aa
	.byte $aa,$aa,$07,$05,$aa
	.byte $aa,$0a,$00,$00,$aa
.endif

alien_run_left5:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$aa,$77,$10,$aa
	.byte $aa,$a7,$00,$00,$aa
	.byte $aa,$5a,$55,$77,$aa
	.byte $aa,$00,$a7,$07,$aa
	.byte $a0,$a0,$0a,$00,$aa
.endif

alien_run_left6:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$aa,$77,$17,$5a
	.byte $aa,$aa,$07,$00,$a5
	.byte $aa,$5a,$55,$77,$7a
	.byte $aa,$05,$aa,$aa,$07
	.byte $a0,$a0,$aa,$0a,$00
.endif

alien_run_left7:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$aa,$10,$77,$aa
	.byte $aa,$aa,$00,$07,$aa
	.byte $aa,$aa,$57,$77,$aa
	.byte $aa,$aa,$05,$a7,$07
	.byte $aa,$0a,$00,$00,$a0
.endif

alien_run_left8:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $aa,$77,$07,$00,$aa
	.byte $aa,$aa,$00,$77,$aa
	.byte $aa,$5a,$10,$77,$7a
	.byte $aa,$a5,$00,$00,$a7
	.byte $aa,$aa,$55,$77,$aa
	.byte $aa,$aa,$a5,$07,$aa
	.byte $aa,$aa,$00,$00,$aa
.endif

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

alien_crouch_progression:
	.word	alien_crouch1
	.word	alien_crouch2

alien_crouch1:
.if 0
	.byte $5,$8
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$7A,$f7,$7f,$aa
	.byte $AA,$77,$07,$00,$aa
	.byte $AA,$AA,$00,$77,$aa
	.byte $AA,$A7,$17,$07,$aa
	.byte $AA,$AA,$70,$70,$aa
	.byte $AA,$AA,$07,$05,$0a
	.byte $AA,$0A,$00,$AA,$00
.endif

alien_crouch2:
.if 0
	.byte $5,$8
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$7A,$fA,$aa
	.byte $AA,$77,$7f,$07,$aa
	.byte $AA,$A7,$00,$70,$aa
	.byte $AA,$7A,$70,$07,$aa
	.byte $AA,$AA,$70,$70,$aa
	.byte $AA,$AA,$07,$55,$0a
	.byte $AA,$0A,$00,$0A,$00
.endif

;=====================
;=====================
; TURNING
;=====================
;=====================
alien_turning_sprite:
.if 0
	.byte $5,$8
	.byte $aa,$57,$77,$aa,$aa
	.byte $0a,$05,$00,$0a,$aa
	.byte $77,$00,$00,$55,$aa
	.byte $77,$00,$00,$55,$aa
	.byte $aa,$00,$00,$a5,$aa
	.byte $aa,$77,$55,$aa,$aa
	.byte $07,$aa,$05,$aa,$aa
	.byte $00,$aa,$00,$aa,$aa
.endif

;=====================
;=====================
; YELLING
;=====================
;=====================

alien_yell_progression:
	.word	alien_yelling_1
	.word	alien_yelling_2

alien_yelling_1:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $0a,$a7,$07,$00,$aa
	.byte $00,$aa,$00,$77,$aa
	.byte $aa,$55,$10,$77,$7a
	.byte $aa,$aa,$00,$00,$a7
	.byte $aa,$aa,$55,$77,$aa
	.byte $aa,$aa,$a5,$07,$aa
	.byte $aa,$0a,$00,$00,$aa
.endif

alien_yelling_2:
.if 0
	.byte $5,$8
	.byte $aa,$7a,$f7,$7f,$aa
	.byte $00,$77,$07,$00,$aa
	.byte $0a,$5a,$00,$77,$aa
	.byte $aa,$a5,$10,$77,$7a
	.byte $aa,$aa,$00,$00,$a7
	.byte $aa,$aa,$55,$77,$aa
	.byte $aa,$aa,$a5,$07,$aa
	.byte $aa,$0a,$00,$00,$aa
.endif

;=====================
;=====================
; SHOOTING UPWARD
;=====================
;=====================

alien_shoot_up_progression:
	.word alien_shooting_up_sprite
	.word alien_shooting_up_sprite
	.word alien_yelling_1
	.word alien_yelling_2

alien_shooting_up_sprite:
.if 0
	.byte $5,$8
	.byte $00,$7a,$f7,$7f,$aa
	.byte $00,$77,$07,$00,$aa
	.byte $55,$aa,$00,$77,$aa
	.byte $aa,$55,$10,$77,$7a
	.byte $aa,$aa,$00,$00,$a7
	.byte $aa,$aa,$55,$77,$aa
	.byte $aa,$aa,$a5,$07,$aa
	.byte $aa,$0a,$00,$00,$aa
.endif



;=====================
;=====================
; DISINTEGRATING
;=====================
;=====================

alien_disintegrating_progression:
	.word	alien_disintegrating_2	; 0
	.word	alien_disintegrating_3	; 1
	.word	alien_disintegrating_4	; 2
	.word	alien_disintegrating_4	; 3
	.word	alien_disintegrating_4	; 4
	.word	alien_disintegrating_4	; 5
	.word	alien_disintegrating_3	; 6
	.word	alien_disintegrating_9	; 7
	.word	alien_disintegrating_10	; 8
	.word	alien_disintegrating_11	; 9
	.word	alien_disintegrating_12	; 10
	.word	alien_disintegrating_13	; 11
	.word	alien_disintegrating_14	; 12
	.word	alien_disintegrating_14	; 13


alien_disintegrating_2:	; 0
	.byte 10,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$fe,$aa,$aa,$fe,$aa,$fe,$aa,$aa,$fe
	.byte $aa,$ff,$aa,$aa,$ff,$aa,$ff,$aa,$aa,$ff
	.byte $aa,$ff,$aa,$ea,$ff,$ea,$ff,$ea,$aa,$ff
	.byte $aa,$ef,$fe,$ff,$ff,$ff,$ff,$ff,$fe,$ef
	.byte $aa,$aa,$ef,$ff,$ff,$ff,$ff,$ff,$ef,$aa
	.byte $aa,$aa,$aa,$ff,$ae,$ae,$ae,$ff,$aa,$aa
	.byte $aa,$aa,$fe,$ff,$aa,$aa,$aa,$ff,$fe,$aa


alien_disintegrating_3:	; 1
	.byte 10,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$fa,$aa,$aa,$fa,$aa,$fa,$aa,$aa,$fa
	.byte $aa,$ff,$aa,$aa,$ff,$aa,$ff,$aa,$aa,$ff
	.byte $aa,$ff,$aa,$aa,$ff,$aa,$ff,$aa,$aa,$ff
	.byte $aa,$af,$fa,$af,$af,$af,$af,$af,$fa,$af
	.byte $aa,$aa,$af,$fa,$fa,$fa,$fa,$fa,$af,$aa
	.byte $aa,$aa,$aa,$ff,$aa,$aa,$aa,$ff,$aa,$aa
	.byte $aa,$aa,$fa,$ff,$aa,$aa,$aa,$ff,$fa,$aa

alien_disintegrating_4:	; 2
	.byte 10,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$0a,$aa,$aa,$0a,$aa,$0a,$aa,$aa,$0a
	.byte $aa,$00,$aa,$aa,$00,$aa,$00,$aa,$aa,$00
	.byte $aa,$00,$aa,$aa,$00,$aa,$00,$aa,$aa,$00
	.byte $aa,$a0,$0a,$a0,$a0,$a0,$a0,$a0,$0a,$a0
	.byte $aa,$aa,$a0,$0a,$0a,$0a,$0a,$0a,$a0,$aa
	.byte $aa,$aa,$aa,$00,$aa,$aa,$aa,$00,$aa,$aa
	.byte $aa,$aa,$0a,$00,$aa,$aa,$aa,$00,$0a,$aa

alien_disintegrating_9:	; 3
	.byte 10,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$0a,$aa,$aa,$0a
	.byte $aa,$af,$aa,$aa,$5a,$aa,$aa,$aa,$aa,$0a
	.byte $aa,$0a,$aa,$aa,$aa,$aa,$af,$aa,$aa,$a5
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$a5,$aa,$aa,$aa,$fa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$5a,$aa,$aa
	.byte $aa,$aa,$fa,$aa,$aa,$aa,$aa,$aa,$aa,$aa

alien_disintegrating_10:	; 4
	.byte 10,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$a5,$aa,$aa,$a0,$aa,$aa,$0a
	.byte $fa,$aa,$aa,$aa,$aa,$aa,$aa,$fa,$aa,$a0
	.byte $aa,$a0,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$a5
	.byte $aa,$aa,$a5,$aa,$aa,$aa,$aa,$af,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$a5,$aa
	.byte $aa,$af,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa

alien_disintegrating_11:	; 5
	.byte 10,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$0a,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$5a,$aa,$aa,$aa,$aa,$aa,$a0
	.byte $af,$0a,$aa,$aa,$aa,$aa,$aa,$af,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$5a
	.byte $aa,$aa,$5a,$aa,$aa,$aa,$aa,$fa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$5a,$aa
	.byte $aa,$fa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa

alien_disintegrating_12:	; 6
	.byte 10,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$a0,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$a5,$aa,$aa,$aa,$fa,$aa,$a0
	.byte $af,$0a,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$5a,$aa,$aa,$aa,$aa,$fa,$aa,$a5
	.byte $aa,$fa,$aa,$aa,$aa,$aa,$aa,$aa,$a5,$aa

alien_disintegrating_13:	; 7
	.byte 10,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$a0,$aa,$aa,$0a
	.byte $fa,$aa,$5a,$a5,$aa,$aa,$aa,$af,$aa,$aa
	.byte $aa,$f0,$5a,$aa,$aa,$aa,$aa,$af,$5a,$a5

alien_disintegrating_14:	; 8
	.byte 10,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $fa,$0a,$5a,$5a,$aa,$aa,$0a,$fa,$5a,$0a

;=====================
;=====================
; SHOOTING
;=====================
;=====================

alien_shoot_sprite:
	.byte 10,8
	.byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	.byte $aa,$9a,$aa,$aa,$f9,$aa,$f9,$aa,$a9,$9a
	.byte $00,$99,$00,$aa,$40,$aa,$40,$aa,$aa,$99
	.byte $aa,$99,$aa,$aa,$44,$aa,$44,$aa,$aa,$99
	.byte $aa,$a9,$ca,$7c,$fc,$7c,$fc,$7c,$ca,$a9
	.byte $aa,$aa,$ac,$cf,$c7,$cf,$c7,$cf,$ac,$aa
	.byte $aa,$aa,$aa,$99,$aa,$aa,$aa,$99,$aa,$aa
	.byte $aa,$aa,$9a,$99,$aa,$aa,$aa,$99,$9a,$aa
