; Interference Pattern

.include "hardware.inc"

; zero page
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

	lda	#4
	sta	DRAW_PAGE

draw_oval_loop:
	inc	FRAME		; increment frame

	ldx	#47		; YY from 47 downto zero

create_yloop:

	txa
	jsr	plot_setup

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

	sta	color_smc+1

	tya
	pha


	;================================
	; plot1
	;================================

plot1:
mask_invert_smc1:
	lda	#$ff		; load mask				; 2
gbasl_smc1:
	and	$400,Y		; mask to preserve on-screen color	; 4+
	sta	COLOR_MASK	; save temporarily			; 3
color_smc:
	lda	#$FF		; load color				; 2
mask_smc2:
	and	#$FF		; mask so only hi/lo we want		; 2
	ora	COLOR_MASK	; combine with on-screen color		; 3
gbasl_smc2:
	sta	$400,Y		; save back out				; 5

	;=================================

	pla
	tay

	ldx	SAVEX

	dey
	bpl	create_xloop

	dex
	bpl	create_yloop


	lda	DRAW_PAGE
	beq	flip_to_2

	bit	PAGE2

	lda	#0
	beq	done_flip

flip_to_2:
	bit	PAGE1
	lda	#4
done_flip:
	sta	DRAW_PAGE


	; X and Y both $FF

	jmp	draw_oval_loop		; bra



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







	;================================
	; plot_setup
	;================================
	; sets up GBASL/GBASH and MASK
	; Ycoord in A
	; trashes Y/A

plot_setup:

	lsr			; shift bottom bit into carry		; 2
	tay

	bcc	plot_even						; 2nt/3
plot_odd:
	lda	#$f0							; 2
	bcs	plot_c_done						; 2nt/3
plot_even:
	lda	#$0f							; 2
plot_c_done:
	sta	mask_smc2+1						;
	eor	#$FF							; 2
	sta	mask_invert_smc1+1					;


	lda	gr_offsets_l,Y	; lookup low-res memory address		; 4
	sta	gbasl_smc1+1
	sta	gbasl_smc2+1


        lda	gr_offsets_h,Y					; 4
	clc
        adc	DRAW_PAGE	; add in draw page offset		; 3
	sta	gbasl_smc1+2
	sta	gbasl_smc2+2


	rts


gr_offsets_l:
	.byte	<$400,<$480,<$500,<$580,<$600,<$680,<$700,<$780
	.byte	<$428,<$4a8,<$528,<$5a8,<$628,<$6a8,<$728,<$7a8
	.byte	<$450,<$4d0,<$550,<$5d0,<$650,<$6d0,<$750,<$7d0

gr_offsets_h:
	.byte	>$400,>$480,>$500,>$580,>$600,>$680,>$700,>$780
	.byte	>$428,>$4a8,>$528,>$5a8,>$628,>$6a8,>$728,>$7a8
	.byte	>$450,>$4d0,>$550,>$5d0,>$650,>$6d0,>$750,>$7d0





