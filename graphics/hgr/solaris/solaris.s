; Solaris scrolling code


; 256 bytes = original
; 240 bytes = don't initialize things unnecessarily
; 239 bytes = optimize branches
; 235 bytes = no lookup table for log2

; zero page
GBASL	= $26
GBASH	= $27

HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6

; soft-switches
FULLGR	= $C052
PAGE1	= $C054

; ROM routines

HGR2	= $F3D8
HPOSN	= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)
			; put in GBASL/GBASH

WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

INL	= $FB
INH	= $FC
YY	= $FD
MASK	= $FE
FRAME	= $FF

surtb3	=	$1000
surtb4	=	$1083

;  0 1  2  3  4  5  6  7
; 01 02 04 08 10 20 40 80
;  5     2       7     4      1        7     4      1    6
; 20(13) 04(13) 80(66) 10(66) 02(66) 80(13) 10(13) 02(13) 40(66)

solaris:

	jsr	HGR2

outer_loop:
	dec	FRAME
	lda	FRAME

	and	#$8
	beq	set_sur3
set_sur4:
	lda	#<surtb4
	bne	done_sur		; bra
set_sur3:
	lda	#<surtb3
done_sur:

	sta	turb3_smc+1


	lda	FRAME
	and	#$7
	tax
;	lda	log2,X

	sec
	lda	#0		; 2
log2_loop:
	rol			; 1
	dex			; 1
	bpl	log2_loop	; 2


	sta	MASK

	ldx	#83
	stx	YY
inner_loop:

	lda	YY

	jsr	HPOSN
	ldx	HGR_X

turb3_smc:
	lda	surtb3,X
	and	MASK
	beq	skip_color
	lda	#$FF
skip_color:
	ldy	#39
inner_inner_loop:
	sta	(GBASL),Y
	dey
	bpl	inner_inner_loop

	inc	YY

	dex
	bne	inner_loop

	beq	outer_loop



offsets:
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00

values1:
	.byte $FE,$FD,$FB,$F7,$EF,$DF,$BF,$7F
	.byte $FE,$FD,$FB,$F7,$EF,$DF,$BF,$7F
	.byte $FE,$FD,$F3,$EF,$DF,$3F
	.byte $FC,$F3,$CF,$3F
	.byte $FC,$f3,$8f,$7f
	.byte $FE,$E1,$1F
values2:
	.byte $FE,$fd,$fb,$f7,$ef,$df,$bf,$7f
	.byte $fe,$fd,$fb,$fe,$fd,$fb,$f7,$ef
	.byte $df,$bf,$7f,$fe,$f9,$f7,$cf,$3f,$fc
	.byte $e3,$9f,$7f,$fc,$c3,$3f,$fe,$e1
	.byte $1f

.if 0
	;64 + 21 = 76 vs 160
surtb3:
       .byte $FF,$FF,$FE,$FF,$FF,$FD,$FF,$FF
       .byte $FB,$FF,$FF,$F7,$FF,$FF,$EF,$FF
       .byte $DF,$FF,$FF,$BF,$FF,$7F,$FF,$FF
       .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
       .byte $FF,$FF,$FF,$FF,$FF,$FE,$FF,$FD
       .byte $FB,$F7,$FF,$EF,$DF,$BF,$7F,$FF
       .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FE
       .byte $FD,$F3,$EF,$DF,$3F,$FF,$FF,$FF
       .byte $FF,$FF,$FC,$F3,$CF,$3F,$FF,$FF
       .byte $FF,$FC,$F3,$8F,$7F,$FF,$FE,$E1
       .byte $1F,$FF,$FF




surtb4:
       .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
       .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
       .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FE
       .byte $FF,$FD,$FF,$FB,$FF,$F7,$FF,$EF
       .byte $DF,$FF,$BF,$FF,$7F,$FF,$FF,$FF
       .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FE
       .byte $FD,$FB,$F7,$EF,$DF,$BF,$7F,$FF
       .byte $FF,$FF,$FF,$FF,$FF,$FE,$F9,$F7
       .byte $CF,$3F,$FF,$FF,$FF,$FF,$FC,$E3
       .byte $9F,$7F,$FF,$FF,$FC,$C3,$3F,$FF
       .byte $FE,$E1,$1F,$FF
.endif
