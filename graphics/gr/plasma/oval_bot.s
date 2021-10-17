; Ovals

; zero page
GBASL	= $26
GBASH	= $27
MASK	= $2E
COLOR	= $30
;CTEMP	= $68
YY	= $69

FRAME	= $FC
SUM	= $FD
SAVEX	= $FE
SAVEY	= $FF

; soft-switches
FULLGR	= $C052
PAGE1	= $C054

; ROM routines
PLOT    = $F800                 ;; PLOT AT Y,A
PLOT1	= $F80E		;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
GBASCALC= $F847		;; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)
SETCOL  = $F864		;; COLOR=A*17
SETGR	= $FB40



	;================================
	; Clear screen and setup graphics
	;================================
oval:

	jsr	SETGR		; set lo-res 40x40 mode
	bit	FULLGR		; make it 40x48

draw_oval:
	inc	FRAME

	ldx	#47		; YY
create_yloop:

	ldy	#39
	txa
	jsr	PLOT	; (Y,A) sets GBASL/GBASH, Y

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

	jsr	SETCOL

	jsr	PLOT1		; PLOT (GBASL),Y

	ldx	SAVEX

	dey
	bpl	create_xloop

	dex
	bpl	create_yloop

	; X and Y both $FF

	bmi	draw_oval



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
;	sec
	sbc	sinetable-32,X
	jmp	sindone

sinadd:
	lda	SUM
;	clc
	adc	sinetable,X

sindone:
	sta	SUM

	ldx	SAVEX
	rts


colorlookup:

; blue
;.byte $55,$77,$ff,$77,$66,$22,$55	; use 00 from sinetable
;.byte $00

; pink
.byte $55,$11,$33,$bb,$ff,$bb,$55
;.byte $00

; green
;.byte $55,$44,$cc,$ff,$cc,$44,$55	; use 00 from sinetable
;.byte $00

; orange
;.byte $99,$88,$ff,$44,$cc,$ff,$55	; use 00 from sinetable
;.byte $00

;.byte $00,$00,$55,$55,$77,$77,$ff,$ff
;.byte $77,$77,$66,$66,$22,$22,$55,$55


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


;.byte $00,$06,$0C,$11,$16,$1A,$1D,$1F
;.byte $20,$1F,$1D,$1A,$16,$11,$0C,$06
;.byte $00,$FA,$F4,$EF,$EA,$E6,$E3,$E1
;.byte $E0,$E1,$E3,$E6,$EA,$EF,$F4,$FA

;.byte $00,$0C,$16,$1D
;.byte $20,$1D,$16,$0C
;.byte $00,$F4,$EA,$E3
;.byte $E0,$E3,$EA,$F4

	jmp	oval


	; 131 bytes
	; 3f5 - 128 = 375
