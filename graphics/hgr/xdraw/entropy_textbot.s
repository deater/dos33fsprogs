
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

XREG            = $46
YREG            = $47

SEEDL           = $4E
SEEDH           = $4F

FRAME           = $CC
FRAMEH          = $CD

HGR_SCALE       = $E7

DISP_PAGE       = $ED
DRAW_PAGE       = $EE

XHIGH           = $F1   ; credits
LOGO_OFFSET	= $F2


HGR             = $F3E2
HGR2		= $F3D8
HPOSN           = $F411
XDRAW0          = $F65D
WAIT            = $FCA8         ; delay 1/2(26+27A+5A^2) us
RESTORE         = $FF3F



entropy_text:

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this call

	sta	FRAME
;	sta	XHIGH

;	iny			; default is 1
;	sty	HGR_SCALE


;	ldy	#60		; FOR Y=60 to 102 STEP 6
;logo_yloop:

;	ldx	#34		; FOR X=32 to 248 STEP 6
;logo_xloop:


;logo_offset_smc:
;	asl	desire_boxes
;	bcc	skip_xdraw
;	jsr	do_xdraw
;skip_xdraw:

;logo_nextx:				; NEXT X
;	inc	FRAME
;	lda	FRAME
;	and	#$7
;	asl	FRAME
;	dec	FRAME
;	bne	no_inc_offset

;	inc	logo_offset_smc+1

;no_inc_offset:
;	txa
;	clc								; 1
;	adc	#6		; x+=6					; 2
;	tax

;	;cmp	#248
;	cmp	#18		; this is 272?
;	bne	logo_xloop

;logo_nexty:

;	clc
;	tya
;	adc	#6		; y+=6
;	tay
;	cpy	#102
;	bne	logo_yloop		; if so, loop




	;======================================
	; do the effect
	;======================================

eloop:
	inc	first_smc+1

	ldy	#6		; Y=6 to 180 STEP 6
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
	bcs	random_scale	; bge

first_smc:
	lda	#$ff		; FIRST
	bne	done_scale

logo_nextx:				; NEXT X
	inc	FRAME
	lda	FRAME
	and	#$7
	bne	no_inc_offset
	inc	logo_offset_smc+1
no_inc_offset:

;	asl	FRAME
;	dec	FRAME
;	


logo_offset_smc:
	asl	desire_boxes
	bcc	skip_xdraw
	bcs	done_scale


;	jmp	done_scale


random_scale:
	lda	$F000
	cmp	#20
	bcs	done_scale

	inc	HGR_SCALE

done_scale:

do_xdraw:
	stx	XREG		; save X
	sty	YREG		; save Y


	; setup X and Y co-ords
	tya			; YPOS into A
xhigh_smc:
	ldy	XHIGH		; XHIGH in Y
				; XPOS already in X

	jsr	HPOSN		; X= (y,x) Y=(a)


	ldx	#<shape_table	; point to our shape
	ldy	#>shape_table
	lda	#0		; ROT=0

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit


	jsr	RESTORE		; restore FLAGS/X/Y/A
				; we saved X/Y earlier



;	jsr	do_xdraw

skip_xdraw:

nextx:				; NEXT X

	inc	random_scale+1

	; starting at 4 so hit 256, overflow to high bit
	; finally end at 280 which is 24?

	txa
	clc								; 1
	adc	#6		; x+=6					; 2
	tax
	bne	no_xwrap
	inc	XHIGH
no_xwrap:
	cmp	#24
	bne	xloop

nexty:
	; carry always set if we get here?

;	clc
	tya
	adc	#5		; y+=6
	tay
	cpy	#156
	bne	yloop		; if so, loop

	beq	eloop		; start over


shape_table:
	.byte 18,63,36,36,45,45,54,54,63	; shape data (a square)
;	.byte 0		; we get this from boxes



; 280/6= 48 roughly	; 36*6 wide = 216, 280-216/2=32 to 248
; 160/6 = 26 roughly	; 42 high, 160-42/2 = 118/2=59, say 60?

;0123456701234567012345670123456701234567
;                      #       ### ###
;                      #         # #
;  ##### #####  #####  #  ####   # #
; #    # #    # #    # # #  ##   # #
; #    # #    # #    # # #       # #
;  ### # # ###  # ###  #  #### ### ###
;        #      #
;0123456701234567012345670123456701234567


desire_boxes:
.byte $00,$00,$02,$03,$B8
.byte $00,$00,$02,$00,$A0
.byte $3E,$f9,$F2,$78,$A0
.byte $42,$85,$0A,$98,$A0
.byte $42,$85,$0A,$80,$A0
.byte $3A,$B9,$72,$7B,$B8
.byte $00,$81,$00,$00,$00
