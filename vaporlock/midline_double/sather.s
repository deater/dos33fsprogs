; **********************************************
; *                                            *
; *             LITTLE TEXT WINDOW             *
; *                                            *
; *     DEMONSTRATES PRECISE VBL DETECTION     *
; *                                            *
; *           Jim Sather --- 8/15/84           *
; *                                            *
; **********************************************
; From "Understanding the Apple IIe" page 3-26
; Converted to ca65 syntax

H2	= $2C		; HLINE RIGHT TERMINUS
COLOR	= $30		; LORES COLOR BYTE
COL40	= $C00C		; 80COL RESET ADDRESS
VBLOFF	= $C019		; MINUS => VBL', PLUS => VBL
GRAFIX	= $C050
TEXT	= $C051
LORES	= $C056
HLINE	= $F819		; LORES HLINE SUBROUTINE

ltw:
	;==================================
	; draw lo-res green screen
	;==================================

	sta	COL40		; Single-Res Display
	lda	LORES
	lda	#39		; Fill screen using HLINE
	sta	H2		; Right coordinate = 39
	lda	#$CC
	sta	COLOR		; Color = HIRES40 Green
	ldx	#47		; Clear lines 47-0
fill:
	ldy	#0		; Left coordinate = 0
	txa
	jsr	HLINE
	dex
	bpl	fill

	;==================================
	; insert text message
	;==================================

	ldx	#21		; Insert message
msglp:
	lda	MSG,X
	eor	#$80
	sta	$5b1,X		; Message at line 11, position 10
	dex
	bpl	msglp


	;==================================
	; get exact vblank region
	;==================================

poll1:
	lda	VBLOFF		; Find end of VBL
	bmi	poll1		; Fall through at VBL
poll2:
	lda	VBLOFF
	bpl	poll2		; Fall through at VBL'			; 2

	lda	$00		; Now slew back in 17029 cycle loops	; 3
lp17029:
	ldx	#17		;					; 2
	jsr	waitx1k		;					; 17000
	jsr	rts1		;					; 12
	lda	$00		; nop3					; 3
	lda	$00		; nop3					; 3
	lda	VBLOFF		; Back to VBL yet?			; 4
	nop			;					; 2
	bmi	lp17029		; no, slew back				; 2/3

	;==================================
	; maintain window
	;==================================

	ldx	#5		; yes, end VBL is precisely located	; 2
	jsr	waitx1k		; now wait 5755 cycles for text window	; 5000
	ldy	#73		;					; 2
	jsr	waitx10		; 					; 730
	pha			; 					; 3
	pla			;					; 4
	lda	$FFFF		;					; 4
	ldx	#8		;					; 2
txt_time:
	lda	TEXT		;					; 4
	jsr	rts1		; window right = window left + 21	; 12
	lda	$00		;					; 3
	nop			;					; 2
	lda	GRAFIX		;					; 4
	ldy	#3		; window left = window right + 4	; 2
	jsr	waitx10		;					; 30
	lda	$00		;					; 3
	dex			;					; 2
	bne	txt_time	; switching time = 8*65 -1 = 519	; 2/3
	ldx	#16		; wait 17030 - 519 = 16511		; 2
	jsr	waitx1k		; before window left			; 16000
	ldy	#50		;					; 22
	jsr	waitx10		;					; 500
	ldx	#8		;					; 2
	nop			;					; 2
	bne	txt_time	;					; 3

	;===================================
	; wait y-reg times 10
	;===================================

loop10:
	bne	skip
waitx10:
	dey			; wait y-reg times 10			; 2
skip:
	dey								; 2
	nop								; 2
	bne	loop10							; 2/3
	rts								; 6


	;===================================
	; wait x-reg times 1000
	;===================================

loop1k:
	pha								; 3
	pla								; 4
	nop								; 2
	nop								; 2
waitx1k:
	ldy	#98			; wait x-reg times 1000		; 2
	jsr	waitx10							; 980
	nop								; 2
	dex								; 2
	bne	loop1k							; 2/3
rts1:
	rts								; 6

MSG:
	.byte $80			; switch in the black
	.byte "*Little Text Window* "

