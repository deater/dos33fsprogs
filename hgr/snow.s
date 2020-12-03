GBASL = $26
GBASH = $27
HGRPAGE = $E6

HGR = $F3E2
HGR2 = $F3D8
HPOSN = $F411

snow:
	jsr	HGR

snow_loop:
	ldy	xhi
	ldx	xlo
	lda	ylo
	jsr	HPOSN

	ldx	#0
line_loop:
ll_smc:
	lda	flake,X
	sta	(GBASL),Y

	inx
	iny
	cpx	#6
	bne	line_loop

	lda	ll_smc+1
c_smc:
	clc
dir_smc:
	adc	#6
	sta	ll_smc+1

	inc	ylo
	dec	line
	beq	forever

	lda	line
	cmp	#12
	bne	snow_loop

	lda	#$E9		; sbc imm
	sta	dir_smc

	lda	#$38		; sec
	sta	c_smc

	jmp	snow_loop

forever:
	jmp	forever

xhi:	.byte	$00
xlo:	.byte	77
ylo:	.byte	100
line:	.byte	23


flake:
	.byte	$00,$00,$40,$01,$00,$00
	.byte	$00,$00,$0C,$18,$00,$00
	.byte	$00,$00,$70,$07,$00,$00
	.byte	$00,$00,$43,$61,$00,$00
	.byte	$00,$00,$4C,$19,$00,$00
	.byte	$33,$00,$70,$07,$00,$66
	.byte	$30,$06,$40,$01,$30,$06
	.byte	$3f,$06,$40,$01,$30,$7e
	.byte	$40,$07,$30,$06,$70,$01
	.byte	$7c,$07,$30,$06,$70,$1f
	.byte	$00,$18,$0F,$78,$0C,$00
	.byte	$00,$60,$40,$01,$03,$00

