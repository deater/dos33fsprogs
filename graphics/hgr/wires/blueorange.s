; wires -- Apple II Hires


; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

D		= $F9
XX		= $FA
YY		= $FB
R		= $FC
CX		= $FD
CY		= $FE
FRAME		= $FF

; soft-switches

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
BKGND0         = $F3F4
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

wires:

	jsr	HGR2

	lda	#$D5
	jsr	BKGND0

.if 0
ol:
	ldx	#0
line_loop:
	lda	#$D5
ll_smc1:
	sta	$4000,X
	inx
	lda	#$AA
ll_smc2:
	sta	$4000,X
	inx

;	cpx	#40
	bne	line_loop

	inc	ll_smc1+2
	inc	ll_smc2+2

	lda	ll_smc2+2
	cmp	#$60
	bne	ol

.endif

reset_loop:
	ldy	#0
outer_loop:
	ldx	#0
move_line_loop:

ml_smc1:
	lda	$4000,X
	eor	pulse_even,Y
ml_smc2:
	sta	$4000,X
	inx

ml_smc3:
	lda	$4000,X
	eor	pulse_odd,Y
ml_smc4:
	sta	$4000,X
	inx

;	cpx	#40
	bne	move_line_loop

;	lda	#100
;	jsr	WAIT

	inc	ml_smc1+2
	inc	ml_smc2+2
	inc	ml_smc3+2
	inc	ml_smc4+2

	lda	ml_smc2+2
	cmp	#$60
	bne	move_line_loop

	lda	#$40
	sta	ml_smc1+2
	sta	ml_smc2+2
	sta	ml_smc3+2
	sta	ml_smc4+2


	iny
	cpy	#28
	bne	outer_loop
	beq	reset_loop





; all
pulse_even:
	.byte	$03,$0C,$30,$40,$00,$00,$00
	.byte	$01,$04,$10,$00,$00,$00,$00
	.byte	$02,$08,$20,$00,$00,$00,$00
	.byte	$83,$8C,$B0,$C0,$80,$80,$80
pulse_odd:
	.byte	$00,$00,$00,$01,$06,$18,$60
	.byte	$00,$00,$00,$00,$02,$08,$20
	.byte	$00,$00,$00,$01,$04,$10,$40
	.byte	$80,$80,$80,$81,$86,$98,$E0

; blue/orange
;pulse_even:
;	.byte	$03,$0C,$30,$40,$00,$00,$00
;pulse_odd:
;	.byte	$00,$00,$00,$01,$06,$18,$60


; blue/black
;pulse_even:
;	.byte	$01,$04,$10,$00,$00,$00,$00
;pulse_odd:
;	.byte	$00,$00,$00,$00,$02,$08,$20

; blue/white
;pulse_even:
;	.byte	$02,$08,$20,$00,$00,$00,$00
;pulse_odd:
;	.byte	$00,$00,$00,$01,$04,$10,$40


	; want this to be at 3f5
        ; Length is 133 so start at
	;		$3F5 - 130 = $373


game_over:
	jmp	wires
