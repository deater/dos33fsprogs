; more plasma

; by Vince `deater` Weaver (vince@deater.net) / dSr
; with some help from qkumba

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
plasma:

	jsr	SETGR		; set lo-res 40x40 mode
	bit	FULLGR		; make it 40x48

draw_plasma:

	lda	#$0f
	sta	MASK

	ldx	#47		; YY
create_yloop:

	lda	MASK
	eor	#$FF
	sta	MASK

	txa
	lsr
	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

	ldy	#39

create_xloop:

	lda	#128
	sta	SUM

	tya			; XX
	jsr	calcsine

	txa			; YY
	jsr	calcsine

	clc
	sty	SAVEY		; XX
	txa
	adc	SAVEY		; XX + YY
	jsr	calcsine

	clc
	adc	FRAME

	and	#$7
	tax
	lda	colorlookup,X

	jsr	SETCOL

	ldy	SAVEY
	lda	SAVEX

	jsr	PLOT1		; PLOT (GBASL),Y

	ldx	SAVEX

	dey
	bpl	create_xloop

	dex
	bpl	create_yloop

	; X and Y both $FF

create_lookup_done:

forever_loop:
	inc	FRAME

	jmp	draw_plasma
;	jmp	forever_loop

.if 0
cycle_colors:

	; cycle colors
	; instead of advancing entire frame, do slightly slower route
	; instead now and just incrememnting the frame and doing the
	; adjustment at plot time.

	; increment frame

	inc	frame_smc+1

	; set/flip pages
	; we want to flip pages and then draw to the offscreen one

flip_pages:

;	ldy	#0

;	iny			; y is $FF, make it 0

	lda	draw_page_smc+1	; DRAW_PAGE
	bne	done_page
	dey
done_page:
;	ldx	PAGE1,Y		; set display page to PAGE1 or PAGE2

	ldx	$BF56,Y		; PAGE1 - $FF

	eor	#$4		; flip draw page between $400/$800
	sta	draw_page_smc+1 ; DRAW_PAGE


	; plot current frame
	; scan whole 40x48 screen and plot each point based on
	; lookup table colors
plot_frame:

	ldx	#47		; YY=47 (count backwards)
plot_yloop:

	txa			; get YY into A
	pha			; save X for later
	lsr			; call actually wants Ycoord/2

	php			; save C flag for mask handling

	; ugh can't use PLOT trick as it always will draw something
	; to PAGE1 even if we don't want to

	jsr	GBASCALC	; point GBASL/H to address in (A is ycoord/2)
				; after, A is GBASL, C is clear

	lda	GBASH		; adjust to be PAGE1/PAGE2 ($400 or $800)
draw_page_smc:
	adc	#0
	sta	GBASH

	; increment YY in top nibble of lookup for (yy<<16)+xx
	; clc	from above, C always 0
	lda	plot_lookup_smc+1
	adc	#$10		; no need to mask as it will oflo and be ignored
	sta	plot_lookup_smc+1

	;==========

	ldy	#39		; XX = 39 (countdown)

	; sets MASK by calling into middle of PLOT routine
	; by Y being 39 draw in a spot that gets over-written

	plp
	jsr	$f806

plot_xloop:

	tya			; get XX & 0x0f
	and	#$f
	tax

plot_lookup_smc:
	lda	lookup,X	; load lookup, (YY*16)+XX

	clc
frame_smc:
	adc	#$00		; add in frame

	and	#$f
	lsr			; we actually only have 8 colors

	tax

	lda	colorlookup,X	; lookup color


	sta	COLOR		; each nibble should be same

	jsr	PLOT1		; plot at GBASL,Y (x co-ord goes in Y)

	dey
	bpl	plot_xloop

	pla			; restore YY
	tax
	dex
	bpl	plot_yloop
	bmi	forever_loop
.endif


;calcsine_div_8:
;	lsr
;calcsine_div_4:
;	lsr
;calcsine_div_2:
;	lsr
calcsine:
	asl
	stx	SAVEX
	and	#$f
	tax
	lda	sinetable,X
	clc
	adc	SUM
	sta	SUM
	ldx	SAVEX
	rts


colorlookup:

; blue
.byte $55,$22,$66,$77,$ff,$77,$55,$00



sinetable:
; this is actually (32*sin(x))
.byte $00,$06,$0C,$11,$16,$1A,$1D,$1F
.byte $20,$1F,$1D,$1A,$16,$11,$0C,$06
;.byte $00,$FA,$F4,$EF,$EA,$E6,$E3,$E1
;.byte $E0,$E1,$E3,$E6,$EA,$EF,$F4,$FA

;.byte $00,$0C,$16,$1D
;.byte $20,$1D,$16,$0C
;.byte $00,$F4,$EA,$E3
;.byte $E0,$E3,$EA,$F4

