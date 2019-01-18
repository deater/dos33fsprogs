; Ootw for Apple II Lores

; by Vince "Deater" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"



ootw:
	; Initialize some variables

	lda	#0
	sta	GAME_OVER
	sta	EQUAKE_PROGRESS
	sta	EARTH_OFFSET
	sta	KICKING
	sta	CROUCHING

	lda     #22
	sta     PHYSICIST_Y
	lda     #20
	sta     PHYSICIST_X

	lda     #1
	sta     DIRECTION

	lda	#40
	sta	BOULDER_Y

	;=======================
	; Initialize the slugs
	;=======================

	lda	#1
	sta	slugg0_out
	sta	slugg1_out
	sta	slugg2_out

	lda	#0
	sta	slugg0_attack
	sta	slugg0_dieing
	sta	slugg1_attack
	sta	slugg1_dieing
	sta	slugg2_attack
	sta	slugg2_dieing

	lda	#$ff
	sta	slugg0_dir
	sta	slugg1_dir
	sta	slugg2_dir

	jsr	random16
	and	#$f
	clc
	adc	#16
	sta	slugg0_x

	jsr	random16
	and	#$7
	clc
	adc	#16
	sta	slugg1_x

	clc
	adc	#10
	sta	slugg2_x


	jsr	random16
;	and	#$3
	sta	slugg0_gait

	jsr	random16
;	and	#$3
	sta	slugg1_gait

	jsr	random16
;	and	#$3
	sta	slugg2_gait


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
.include "slug_cutscene.s"
