; Ootw for Apple II

; by Vince "Deater" Weaver

.include "zp.inc"
.include "hardware.inc"



ootw:
	; Initialize some variables

	lda	#0
	sta	GAME_OVER
	sta	EQUAKE_PROGRESS
	sta	EARTH_OFFSET

	lda     #22
	sta     PHYSICIST_Y
	lda     #20
	sta     PHYSICIST_X

	lda     #1
	sta     DIRECTION

	lda	#40
	sta	BOULDER_Y

	jsr	ootw_pool

;===========================
; quit_level
;===========================

quit_level:
	jsr	TEXT
	jsr	HOME
	lda	KEYRESET		; clear strobe

	lda	#0
	sta	DRAW_PAGE

	lda	#<end_message
	sta	OUTL
	lda	#>end_message
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print

wait_loop:
	lda	KEYPRESS
	bpl	wait_loop

	lda	KEYRESET		; clear strobe

	jmp	ootw


end_message:
.byte	8,10,"PRESS RETURN TO CONTINUE",0
.byte	11,20,"ACCESS CODE: IH8S",0

.include "ootw_pool.s"
.include "ootw_cavern.s"
.include "physicist.s"
.include "text_print.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "gr_putsprite.s"
.include "gr_offsets.s"
.include "random16.s"
.include "ootw_pool.inc"
.include "ootw_cavern.inc"
.include "ootw_quake.inc"
.include "ootw_sprites.inc"
