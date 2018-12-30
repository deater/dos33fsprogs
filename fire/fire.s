; Lo-res fire animation

; by deater (Vince Weaver) <vince@deater.net>

; based on code described here http://fabiensanglard.net/doom_fire_psx/

; Zero Page
COLOR		= $30
SEEDL		= $4E
DRAW_PAGE	= $EE
TEMP		= $FA
TEMPY		= $FB



; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
PAGE0	= $C054 ; Page0
PAGE1	= $C055 ; Page1
LORES	= $C056	; Enable LORES graphics
PADDLE_BUTTON0 = $C061
PADDL0	= $C064
PTRIG	= $C070

; ROM routines

TEXT	= $FB36				;; Set text mode
HOME	= $FC58				;; Clear the text screen
WAIT	= $FCA8				;; delay 1/2(26+27A+5A^2) us


fire_demo:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	PAGE0

	;===================
	; init vars
	lda	#0

	;==============================
	; setup graphics for vapor lock
	;==============================

;	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

;	jsr	gr_copy_to_current		; 6+ 9292

	; now we have 322 left

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	; 322 - 12 = 310
	; -3 for jmp
	; 307

	; Try X=9 Y=6 cycles=307

;	ldy	#6							; 2
;wfloopA:ldx	#9							; 2
;wfloopB:dex								; 2
;	bne	wfloopB							; 2nt/3
;	dey								; 2
;	bne	wfloopA							; 2nt/3


	jsr	clear_screens_notext

	; Setup white line on bottom

	lda	#$ff
	ldx	#39
white_loop:
	sta	$7d0,X			; hline 24 (46+47)
	dex
	bpl	white_loop


fire_loop:

	ldy	#44			; 22 * 2

yloop:

	lda	gr_offsets,Y
	sta	smc2+1
	lda	gr_offsets+1,Y
	sta	smc2+2
	lda	gr_offsets+2,Y
	sta	smc1+1
	lda	gr_offsets+3,Y
	sta	smc1+2

	sty	TEMPY

	ldx	#39
xloop:
smc1:
	lda	$7d0,X
	sta	TEMP
	and	#$f		; mask off
	tay

	jsr	random16
	lda	SEEDL
	and	#$1
	beq	no_change

decrement:
	lda	color_progression,Y
	jmp	done_change
no_change:
	lda	TEMP
done_change:

smc2:
	sta	$750,X
	dex
	bpl	xloop

	ldy	TEMPY

	dey
	dey
	bpl	yloop



	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be         4550
	;			=============
	;			      15 cycles


	;====================
	; Handle keypresses
	; if no keypress, 9
	; if keypress, 6+43 = 49

	lda	KEYPRESS				; 4
	bmi	keypress
							; 2
no_keypress:
	jmp	fire_loop

keypress:
	jmp	keypress


color_progression:
	.byte	0	; 0->0
	.byte	$88	; 1->8
	.byte	0	; 2->0
	.byte	0	; 3->0
	.byte	0	; 4->0
	.byte	0	; 5->0
	.byte	0	; 6->0
	.byte	0	; 7->0
	.byte	$55	; 8->5
	.byte	$11	; 9->1
	.byte	0	; 10->0
	.byte	0	; 11->0
	.byte	0	; 12->0
	.byte	$99	; 13->9
	.byte	0	; 14->0
	.byte	$dd	; 15->13

.include "gr_hline.s"
.include "gr_fast_clear.s"
.include "vapor_lock.s"
.include "delay_a.s"
.include "random16.s"
