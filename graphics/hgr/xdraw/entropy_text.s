
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
LOGO_OFFSET     = $F2   ; credits


HGR             = $F3E2
HGR2		= $F3D8
HPOSN           = $F411
XDRAW0          = $F65D
WAIT            = $FCA8         ; delay 1/2(26+27A+5A^2) us
RESTORE         = $FF3F



entropy_text:

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this call


	sta	LOGO_OFFSET
	sta	FRAME


	iny			; default is 1
	sty	HGR_SCALE

	ldy	#60		; FOR Y=60 to 102 STEP 6
logo_yloop:

	ldx	#34		; FOR X=32 to 248 STEP 6
logo_xloop:

	stx	XREG		; save X
	sty	YREG		; save Y

	; setup X and Y co-ords
	tya			; YPOS into A
	ldy	#0		; XHIGH always #0

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




	;======================================
	; do the effect
	;======================================

eloop:
	ldy	#6		; Y=0 to 180 STEP 6
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








; 16-bit 6502 Random Number Generator

; Linear feedback shift register PRNG by White Flame
; http://codebase64.org/doku.php?id=base:small_fast_16-bit_prng

; The Apple II KEYIN routine increments this field
; while waiting for keypress

;SEEDL = $4E
;SEEDH = $4F

XOR_MAGIC = $7657	; "vW"

	;=============================
	; random16
	;=============================
	; takes:
	;	not 0, cc = 5+  = 27
	;	not 0, cs = 5+12+19 = 36
	;	$0000	  = 5+7+19 = 31
	;	$8000     = 5+6+14 = 25
	;	$XX00	  = 5+6+7+19 = 37
random16:

	lda	SEEDL							; 3
	beq	lowZero		; $0000 and $8000 are special values	; 2

	asl	SEEDL		; Do a normal shift			; 5
	lda	SEEDH							; 3
	rol								; 2
	bcc	noEor							; 2

doEor:
				; high byte is in A


	eor	#>XOR_MAGIC						; 2
	sta	SEEDH							; 3
	lda	SEEDL							; 3
	eor	#<XOR_MAGIC						; 2
	sta	SEEDL							; 3
	rts								; 6

lowZero:
									; 1
	lda	SEEDH							; 3
	beq	doEor		; High byte is also zero		; 3
				; so apply the EOR
									; -1
				; wasn't zero, check for $8000
	asl								; 2
	beq	noEor		; if $00 is left after the shift	; 2
				; then it was $80
	bcs	doEor		; else, do the EOR based on the carry	; 3

noEor:
									; 1
	sta	SEEDH							; 3

	rts								; 6


