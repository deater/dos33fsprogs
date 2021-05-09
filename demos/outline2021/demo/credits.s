
; Roughly based on "Entropy" by Dave McKellar of Toronto
; A Two-line BASIC program Found on Beagle Brother's Apple Mechanic Disk
;
; It is XORing vector squares across the screen.  Randomly the size
;	is changed while doing this.


; 24001	ROT=0:FOR I=1 TO 15: READ A,B: POKE A,B: NEXT: DATA
;	232,252,233,29,7676,1,7678,4,7679,0,7680,18,7681,63,
;	7682,36,7683,36,7684,45,7685,45,7686,54,7687,54,7688,63,
;	7689,0
; 24002 FOR I=1 TO 99: HGR2: FOR E=.08 TO .15 STEP .01:
;	FOR Y=4 to 189 STEP 6: FOR X=4 to 278 STEP 6:
;	SCALE=(RND(1)<E)*RND(1)*E*20+1: XDRAW 1 AT X,Y:
;	NEXT: NEXT: NEXT: NEXT

; if E=.08	IF RND<20           RND(1)*.08 < .1
;	If (RND(1)<E) THEN SCALE = RND(1)*E*20+1 = 1 .. 2 (2.6)
;	IF (RND(1)>E) THEN SCALE = 1
; if E=.15	IF RND<38
;	If (RND(1)<E) THEN SCALE = RND(1)*E*20+1 = 1 .. 4
;	IF (RND(1)>E) THEN SCALE = 1




credits:

	jsr	HGR		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this call

	jsr	clear_bottom

	sta	LOGO_OFFSET
	sta	FRAME

	lda	#1		; default is 1
	sta	HGR_SCALE

	ldy	#60		; FOR Y=60 to 102 STEP 6
logo_yloop:

	ldx	#34		; FOR X=32 to 248 STEP 6
logo_xloop:

	stx	XREG		; save X
	sty	YREG		; save Y

	; setup X and Y co-ords
	tya			; YPOS into A
	ldy	#0		; XHIGH always 0

	jsr	HPOSN		; X= (y,x) Y=(a)

	ldx	LOGO_OFFSET
	asl	desire_boxes,X
	bcc	skip_xdraw

	ldx	#<shape_table	; point to our shape
	ldy	#>shape_table
	lda	#0		; ROT=0

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit

skip_xdraw:
	jsr	RESTORE		; restore FLAGS/X/Y/A
				; we saved X/Y earlier

logo_nextx:				; NEXT X
	inc	FRAME
	lda	FRAME
	and	#$7
	bne	no_inc_offset

	inc	LOGO_OFFSET

no_inc_offset:
	txa
	clc								; 1
	adc	#6		; x+=6					; 2
	tax

	;cmp	#248
	cmp	#18		; this is 272?
	bne	logo_xloop

logo_nexty:

;	inc	LOGO_OFFSET

	clc
	tya
	adc	#6		; y+=6
	tay
	cpy	#102
	bne	logo_yloop		; if so, loop


	;=======================================
	; delay a few seconds
	;=======================================

	ldx	#150
	jsr	long_wait

	lda	#0
	sta	FRAME
	sta	FRAMEH

	;======================================
	; do the effect
	;======================================

eloop:
	ldy	#0		; Y=0 to 180 STEP 6
yloop:

	ldx	#0
	stx	XHIGH

	ldx	#4		; FOR X=4 to 278 STEP 6
xloop:

	lda	#1		; default is 1
	sta	HGR_SCALE

	cpy	#54
	bcc	random_scale	; blt
	cpy	#108
	bcc	done_scale	; bge


random_scale:
	jsr	random16
	cmp	#20
	bcs	done_scale	; bge

	lda	SEEDL
	bmi	done_scale

	inc	HGR_SCALE

done_scale:

	stx	XREG		; save X
	sty	YREG		; save Y

	; setup X and Y co-ords
	tya			; YPOS into A
	ldy	XHIGH		; Y always 0
				; XPOS already in X

	jsr	HPOSN		; X= (y,x) Y=(a)


	ldx	#<shape_table	; point to our shape
	ldy	#>shape_table
	lda	#0		; ROT=0

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit

	jsr	text_credits

	jsr	RESTORE		; restore FLAGS/X/Y/A
				; we saved X/Y earlier

nextx:				; NEXT X

	; starting at 4 so hit 256, overflow to high bit
	; finally end at 280 which is 24?

	txa
	clc								; 1
	adc	#6		; x+=6					; 2
	tax
	beq	xwrap
	cmp	#24
	bne	xloop
	beq	nexty
xwrap:
	inc	XHIGH
	jmp	xloop

nexty:
	; carry always set if we get here?

	clc
	tya
	adc	#6		; y+=6
	tay
	cpy	#156
	bne	yloop		; if so, loop
	beq	eloop

shape_table:
	.byte 18,63,36,36,45,45,54,54,63,0	; shape data (a square)


; 280/6= 48 roughly	; 36*6 wide = 216, 280-216/2=32 to 248
; 160/6 = 26 roughly	; 42 high, 160-42/2 = 118/2=59, say 60?

;0123456701234567012345670123456701234567
;      #              #
;      #
;      #  ####   #### # # ###  ####
;  ##### #    # #     # ##    #    #
; #    # ######  ###  # #     ######
; #    # #          # # #     #
;  ####   ####  ####  # #      ####
;0123456701234567012345670123456701234567
desire_boxes:
.byte $02,$00,$04,$00,$00
.byte $02,$00,$00,$00,$00
.byte $02,$78,$F5,$73,$C0
.byte $3E,$85,$05,$84,$20
.byte $42,$FC,$E5,$07,$E0
.byte $42,$80,$15,$04,$00
.byte $3C,$79,$E5,$03,$C0


;setup_text_credits:
;
;	; clear bottom of page2 and set split
;	bit	TEXTGR
;
;	ldx	#39
;	lda	#' '|$80
;clear_bottom_loop:
;	sta	$A50,X
;	sta	$AD0,X
;	sta	$B50,X
;	sta	$BD0,X
;	dex
;	bpl	clear_bottom_loop

	; set "done"

;	lda	#DONE
;	sta	command

	; clear time

;	lda	#0
;	sta	seconds
;	sta	ticks

;	rts




	;======================================
	;======================================
	; display credits
	;======================================
	;======================================

text_credits:

	; display music bars

	; a bar

	lda	A_VOLUME
	lsr
	lsr
	sta	draw_a_bar_left_loop+1
	lda	#3
	sec
	sbc	draw_a_bar_left_loop+1
	sta	draw_a_bar_right_loop+1

	ldx	#4
	lda	#' '|$80
draw_a_bar_left_loop:
	cpx	#$4
	bne	skip_al_bar
	eor	#$80
skip_al_bar:
	sta	$650,X				; A50
	dex
	bpl	draw_a_bar_left_loop

	ldx	#4
	lda	#' '
draw_a_bar_right_loop:
	cpx	#$4
	bne	skip_ar_bar
	eor	#$80
skip_ar_bar:
	sta	$650+35,X			; A50
	dex
	bpl	draw_a_bar_right_loop

	; b bar

	lda	B_VOLUME
	lsr
	lsr
	sta	draw_b_bar_left_loop+1
	lda	#3
	sec
	sbc	draw_b_bar_left_loop+1
	sta	draw_b_bar_right_loop+1

	ldx	#4
	lda	#' '|$80
draw_b_bar_left_loop:
	cpx	#$4
	bne	skip_bl_bar
	eor	#$80
skip_bl_bar:
	sta	$6D0,X				; $AD0
	dex
	bpl	draw_b_bar_left_loop

	ldx	#4
	lda	#' '
draw_b_bar_right_loop:
	cpx	#$4
	bne	skip_br_bar
	eor	#$80
skip_br_bar:
	sta	$6D0+35,X			; $AD0
	dex
	bpl	draw_b_bar_right_loop

	; c

	lda	C_VOLUME
	lsr
	lsr
	sta	draw_c_bar_left_loop+1
	lda	#3
	sec
	sbc	draw_c_bar_left_loop+1
	sta	draw_c_bar_right_loop+1
	ldx	#4
	lda	#' '|$80
draw_c_bar_left_loop:
	cpx	#$4
	bne	skip_cl_bar
	eor	#$80
skip_cl_bar:
	sta	$750,X			; $B50
	dex
	bpl	draw_c_bar_left_loop

	ldx	#4
	lda	#' '
draw_c_bar_right_loop:
	cpx	#$4
	bne	skip_cr_bar
	eor	#$80
skip_cr_bar:
	sta	$750+35,X		; $B50
	dex
	bpl	draw_c_bar_right_loop

	;================
	; update frames
	;================

	inc	FRAME
	lda	FRAME
	cmp	#100
	bne	not_fifty

	lda	#0
	sta	FRAME
	inc	FRAMEH
not_fifty:

	;================
	; write credits
	;================

actual_credits:
	lda	FRAME
	cmp	#25
	bne	done_credits

	lda	FRAMEH

	; increment on multiples of 4 seconds

	and	#$7
	beq	next_credit
	bne	done_credits

next_credit:

	;========================
	; write the credits

write_credits:
	lda	which_credit
	cmp	#7
	beq	done_credits

	ldx	#4
outer_credit_loop:

	; X is proper line
	; point to start of proper output line

	lda	credits_address,X
	sta	credits_address_smc+1
	lda	credits_address+1,X
	sta	credits_address_smc+2

	; load proper input location

	lda	which_credit
	asl
	tay

	txa
	asl
	asl
	asl	; *16 (already *2)
	clc
	adc	credits_table,Y
	sta	write_credit_1_loop+1
	lda	credits_table+1,Y
	adc	#0
	sta	write_credit_1_loop+2

	ldy	#0
write_credit_1_loop:
	lda	$dede,Y
	ora	#$80
credits_address_smc:
	sta	$dede,Y
	iny
	cpy	#16
	bne	write_credit_1_loop

done_credit1_loop:
	dex
	dex
	bpl	outer_credit_loop


	inc	which_credit

done_credits:
	rts

credits_address:
	.word	$650+12
	.word	$6d0+12
	.word	$750+12

credits_table:
	.word credits1
	.word credits2
	.word credits3
	.word credits4
	.word credits5
	.word credits6
	.word credits7


credits1:
	.byte "     CODE:      "
	.byte "                "
	.byte "     DEATER     "

credits2:
	.byte "     MUSIC:     "
	.byte "                "
	.byte "      MAZE      "

credits3:
	.byte "   EFFECTS:     "
	.byte "   J. WARWICK   "
	.byte "   D. MCKELLAR  "

credits4:
	.byte "  MAGIC:        "
	.byte "   QKUMBA       "
	.byte "   4 A.M.       "

credits5:
	.byte "  GREETS:       "
	.byte "   FRENCH TOUCH "
	.byte "   IMPHOBIA     "

credits6:
	.byte "    GROUIK      "
	.byte "    FENARINARSA "
	.byte "    WIZ21       "

credits7:
	.byte "  APPLE ][      "
	.byte "                "
	.byte "       FOREVER  "

which_credit:
	.byte	$0
