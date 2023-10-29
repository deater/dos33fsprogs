; Interference Pattern

.include "hardware.inc"

; zero page
GBASL	= $26
GBASH	= $27
MASK	= $2E
COLOR	= $30
;CTEMP	= $68
YY	= $69

COLOR_MASK=$F8
XPOS = $F9
YPOS = $FA

DRAW_PAGE=$FB
FRAME	= $FC
SUM	= $FD
SAVEX	= $FE
SAVEY	= $FF


	;================================
	; Clear screen and setup graphics
	;================================
oval:
	bit	SET_GR
	bit	LORES
	bit	FULLGR		; make it 40x48
	bit	PAGE1

	lda	#0
	sta	DRAW_PAGE

draw_oval_loop:
	inc	FRAME				; increment frame

	ldx	#47		; YY from 47 downto zero

create_yloop:

	txa
	jsr	plot_setup

;	stx	YPOS

;	txa
;	jsr	PLOT	; (Y,A) sets GBASL/GBASH, Y

;	txa
;	lsr
;	tay

;	lda	gr_offsets_l,Y
;	sta	GBASL
;	lda	gr_offsets_h,Y
;	sta	GBASH

	ldy	#39

create_xloop:

;	lda	#128
	lda	FRAME
	sta	SUM

	tya			; XX
	jsr	calcsine_div2

	txa			; YY
	jsr	calcsine

	; X (YY) is in SAVEX

	clc
;	sty	SAVEY		; XX
	tya
	adc	SAVEX		; XX + YY
	jsr	calcsine_div2

;	clc
;	adc	FRAME

	lsr				; double colors
	and	#$7			; mask
	tax
	lda	colorlookup,X

;	jsr	SETCOL

	sta	COLOR

	txa
	pha
	tya
	pha

	jsr	plot1

	pla
	tay
	pla
	tax

;	jsr	PLOT1		; PLOT (GBASL),Y

	ldx	SAVEX

	dey
	bpl	create_xloop

	dex
	bpl	create_yloop

	; X and Y both $FF

	bmi	draw_oval_loop



calcsine_div2:
	lsr
calcsine:
	stx	SAVEX

	and	#$3f

	tax
	rol
	rol
	rol
	bcc	sinadd

sinsub:
	lda	#0
	lda	SUM
	sec
	sbc	sinetable-32,X
	jmp	sindone

sinadd:
	lda	SUM
	clc
	adc	sinetable,X

sindone:
	sta	SUM

	ldx	SAVEX
	rts


colorlookup:

; pink
.byte $55,$11,$33,$bb,$ff,$bb,$55
.byte $00


sinetable:
; this is actually (32*sin(x))

.byte $00,$03,$06,$09,$0C,$0F,$11,$14
.byte $16,$18,$1A,$1C,$1D,$1E,$1F,$1F
.byte $20,$1F,$1F,$1E,$1D,$1C,$1A,$18
.byte $16,$14,$11,$0F,$0C,$09,$06,$03
;.byte $00,$FD,$FA,$F7,$F4,$F1,$EF,$EC
;.byte $EA,$E8,$E6,$E4,$E3,$E2,$E1,$E1
;.byte $E0,$E1,$E1,$E2,$E3,$E4,$E6,$E8
;.byte $EA,$EC,$EF,$F1,$F4,$F7,$FA,$FD







.if 0
gr_offsets_l:
        .byte   <$400,<$480,<$500,<$580,<$600,<$680,<$700,<$780
        .byte   <$428,<$4a8,<$528,<$5a8,<$628,<$6a8,<$728,<$7a8
        .byte   <$450,<$4d0,<$550,<$5d0,<$650,<$6d0,<$750,<$7d0

gr_offsets_h:
        .byte   >$400,>$480,>$500,>$580,>$600,>$680,>$700,>$780
        .byte   >$428,>$4a8,>$528,>$5a8,>$628,>$6a8,>$728,>$7a8
        .byte   >$450,>$4d0,>$550,>$5d0,>$650,>$6d0,>$750,>$7d0
.endif



.include "gr_plot.s"
.include "/home/vince/research/dos33fsprogs.git/demos/second/gr_offsets.s"
