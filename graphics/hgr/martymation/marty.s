; Martymation implementation

; based on the animation routines by
; Martin Kahn found on side B of the Broderbund Color Printshop Disk, Side 2

; by Vince `deater` Weaver

; zero page locations

NIBCOUNT	= $00
HGR_BITS	= $1C

; 1C-40 has some things used by hires

; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

; soft-switches
KEYPRESS	= $C000
KEYRESET	= $C010
SET_GR		= $C050
FULLGR		= $C052
PAGE1		= $C054
HIRES		= $C057

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
HPLOT0		= $F457		; plot at (Y,X), (A)
HCOLOR1		= $F6F0		; set HGR_COLOR to value in X
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

martymation:

	jsr	HGR2

	; decompress images
	lda	#<(asteroid0_lzsa)
	sta	getsrc_smc+1
	lda	#>(asteroid0_lzsa)
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast

	lda	#<(asteroid1_lzsa)
	sta	getsrc_smc+1
	lda	#>(asteroid1_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jmp	start_animation	; at $8503

label_8506:
	.byte $00
label_8507:
	.byte $80
label_8508:
	.byte $00
;label_8509:
;	.byte $20


start_animation:
label_853c:
	ldy	#$40
	sty	label_858b

	ldx	#$00
	stx	label_8506
	inx
	lda	SET_GR			; set graphics $C050
	lda	FULLGR			; set fullscreen $C052
	lda	HIRES			; enable hires $C057
label_8550:
	lda	PAGE1,X			; set page

	txa				; flip low bit (switch page?)
	eor	#$01
	tax

	lda	label_858b		; switch draw page
	eor	#$60			; 0100 -> 0010, 0010 -> 0100
	sta	label_858b

	stx	label_8508

	lda	#$11
	jsr	WAIT			; pause

	jsr	label_8597

	lda	KEYPRESS		; check keypress
	bpl	label_857a
keypressed:
	sta	KEYRESET		; clear keypress
	cmp	#$81			; check for ^A
	beq	label_8583		; exit
	cmp	#$9B			; check for ESC
	beq	label_8583		; exit
label_857a:
	ldx	label_8508
	dec	label_8507
	bne	label_8550
	rts
label_8583:
	lda	PAGE1
	inc	label_8506
	rts
label_858a:
	.byte	$00
label_858b:
	.byte	$20
label_858c:
	.byte	$01
label_858d:
	.byte	$00
label_858e:
	.byte	$00
label_858f:
	.byte	$28
label_8590:
	.byte	$C0,$80,$55,$2A,$80,$2A,$55

label_8597:
	lda	label_858e
	ora	label_858c
	tay
label_859e:
	sty	$82
	lda	label_9100,Y
	and	#$1f
	ora	label_858b
	sta	$81
	lda	label_91c0,Y
	sta	$80
	ldy	label_858d
label_85b2:
	lda	($80),Y
	tax
	lda	label_85d9,X
	sta	($80),Y
	iny
	asl
	asl
	lda	($80),Y
	bcs	label_85c3
	eor	#$01
label_85c3:
	tax
	lda	label_86d9,X
	sta	($80),Y
	iny
	cpy	label_858f
	bne	label_85b2

	ldy	$82
	iny
	iny
	cpy	label_8590
	bcc	label_859e

	rts

table1:		; $85d9 ... $86d8
label_85d9:
.byte $55,$56,$57,$54,$59,$5a,$5b,$58, $5d,$5e,$5f,$5c,$51,$52,$53,$50	; 85d9...85e8
.byte $65,$66,$67,$64,$69,$6a,$6b,$68, $6d,$6e,$6f,$6c,$61,$62,$63,$60	;
.byte $75,$76,$77,$74,$79,$7a,$7b,$78, $7d,$7e,$7f,$7c,$71,$72,$73,$70	;
.byte $45,$46,$47,$44,$49,$4a,$4b,$48, $4d,$4e,$4f,$4c,$41,$42,$43,$40	; ...8618
.byte $15,$16,$17,$14,$19,$1a,$1b,$18, $1d,$1e,$1f,$1c,$11,$12,$13,$10	;
.byte $25,$26,$27,$24,$29,$2a,$2b,$28, $2d,$2e,$2f,$2c,$21,$22,$23,$20	;
.byte $35,$35,$37,$34,$39,$3a,$3b,$38, $3d,$3e,$3f,$3c,$31,$32,$33,$30	; ...8648
.byte $05,$06,$07,$04,$09,$0a,$0b,$08, $0d,$0e,$0f,$0c,$01,$02,$03,$00	;
.byte $d5,$d6,$d7,$d4,$d9,$da,$db,$d8, $dd,$de,$df,$dc,$d1,$d2,$d3,$d0	;
.byte $e5,$e6,$e7,$e4,$e9,$ea,$eb,$e8, $ed,$ee,$ef,$ec,$e1,$e2,$e3,$e0	; ...8678
.byte $f5,$f6,$f7,$f4,$f9,$fa,$fb,$f8, $fd,$fe,$ff,$fc,$f1,$f2,$f3,$f0	;
.byte $c5,$c6,$c7,$c4,$c9,$ca,$cb,$c8, $cd,$ce,$cf,$cc,$c1,$c2,$c3,$c0	;
.byte $95,$96,$97,$94,$99,$9a,$9b,$98, $9d,$9e,$9f,$9c,$91,$92,$93,$90	;
.byte $a5,$a6,$a7,$a4,$a9,$aa,$ab,$a8, $ad,$ae,$af,$ac,$a1,$a2,$a3,$a0	; ...86b8
.byte $b5,$b6,$b7,$b4,$b9,$ba,$bb,$b8, $bd,$be,$bf,$bc,$b1,$b2,$b3,$b0	;
.byte $85,$86,$87,$84,$89,$8a,$8b,$88, $8d,$8e,$8f,$8c,$81,$82,$83,$80	;


table2:		; $86d9 ... $87d8
label_86d9:
.byte $2a,$2b,$2c,$2d,$2e,$2f,$28,$29, $32,$33,$34,$35,$36,$37,$30,$31	; 86d9...86e8
.byte $3a,$3b,$3c,$3d,$3e,$3f,$38,$39, $22,$23,$24,$25,$26,$27,$20,$21	;
.byte $4a,$4b,$4c,$4d,$4e,$4f,$48,$49, $52,$53,$54,$55,$56,$57,$50,$51	;
.byte $5a,$5b,$5c,$5d,$5e,$5f,$58,$59, $42,$43,$44,$45,$46,$47,$40,$41	;
.byte $6a,$6b,$6c,$6d,$6e,$6f,$68,$69, $72,$73,$74,$75,$76,$77,$70,$71	;
.byte $7a,$7b,$7c,$7d,$7e,$7f,$78,$79, $62,$63,$64,$65,$66,$67,$60,$61	;
.byte $0a,$0b,$0c,$0d,$0e,$0f,$08,$09, $12,$13,$14,$15,$16,$17,$10,$11	;
.byte $1a,$1b,$1c,$1d,$1e,$1f,$18,$19, $02,$03,$04,$05,$06,$07,$00,$01	;
.byte $aa,$ab,$ac,$ad,$ae,$af,$a8,$a9, $b2,$b3,$b4,$b5,$b6,$b7,$b0,$b1	;
.byte $ba,$bb,$bc,$bd,$be,$bf,$b8,$b9, $a2,$a3,$a4,$a5,$a6,$a7,$a0,$a1	;
.byte $ca,$cb,$cc,$cd,$ce,$cf,$c8,$c9, $d2,$d3,$d4,$d5,$d6,$d7,$d0,$d1	;
.byte $da,$db,$dc,$dd,$de,$df,$d8,$d9, $c2,$c3,$c4,$c5,$c6,$c7,$c0,$c1	;
.byte $ea,$eb,$ec,$ed,$ee,$ef,$e8,$e9, $f2,$f3,$f4,$f5,$f6,$f7,$f0,$f1	;
.byte $fa,$fb,$fc,$fd,$fe,$ff,$f8,$f9, $e2,$e3,$e4,$e5,$e6,$e7,$e0,$e1	;
.byte $8a,$8b,$8c,$8d,$8e,$8f,$88,$89, $92,$93,$94,$95,$96,$97,$90,$91	;
.byte $9a,$9b,$9c,$9d,$9e,$9f,$98,$99, $82,$83,$84,$85,$86,$87,$80,$81	;


hires_lookup_low:
label_9100:
	.byte $20,$24,$28,$2c, $30,$34,$38,$3c
	.byte $20,$24,$28,$2c, $30,$34,$38,$3c

	.byte $21,$25,$29,$2d, $31,$35,$39,$3d
	.byte $21,$25,$29,$2d, $31,$35,$39,$3d

	.byte $22,$26,$2a,$2e, $32,$36,$3a,$3e
	.byte $22,$26,$2a,$2e, $32,$36,$3a,$3e

	.byte $23,$27,$2b,$2f, $33,$37,$3b,$3f
	.byte $23,$27,$2b,$2f, $33,$37,$3b,$3f

	.byte $20,$24,$28,$2c, $30,$34,$38,$3c
	.byte $20,$24,$28,$2c, $30,$34,$38,$3c

	.byte $21,$25,$29,$2d, $31,$35,$39,$3d
	.byte $21,$25,$29,$2d, $31,$35,$39,$3d

	.byte $22,$26,$2a,$2e, $32,$36,$3a,$3e
	.byte $22,$26,$2a,$2e, $32,$36,$3a,$3e

	.byte $23,$27,$2b,$2f, $33,$37,$3b,$3f
	.byte $23,$27,$2b,$2f, $33,$37,$3b,$3f

	.byte $20,$24,$28,$2c, $30,$34,$38,$3c
	.byte $20,$24,$28,$2c, $30,$34,$38,$3c

	.byte $21,$25,$29,$2d, $31,$35,$39,$3d
	.byte $21,$25,$29,$2d, $31,$35,$39,$3d

	.byte $22,$26,$2a,$2e, $32,$36,$3a,$3e
	.byte $22,$26,$2a,$2e, $32,$36,$3a,$3e

	.byte $23,$27,$2b,$2f, $33,$37,$3b,$3f
	.byte $23,$27,$2b,$2f, $33,$37,$3b,$3f

hires_lookup_high:
label_91c0:
	.byte $00,$00,$00,$00, $00,$00,$00,$00
	.byte $80,$80,$80,$80, $80,$80,$80,$80
	.byte $00,$00,$00,$00, $00,$00,$00,$00
	.byte $80,$80,$80,$80, $80,$80,$80,$80
	.byte $00,$00,$00,$00, $00,$00,$00,$00
	.byte $80,$80,$80,$80, $80,$80,$80,$80
	.byte $00,$00,$00,$00, $00,$00,$00,$00
	.byte $80,$80,$80,$80, $80,$80,$80,$80

	.byte $28,$28,$28,$28, $28,$28,$28,$28
	.byte $A8,$A8,$A8,$A8, $A8,$A8,$A8,$A8
	.byte $28,$28,$28,$28, $28,$28,$28,$28
	.byte $A8,$A8,$A8,$A8, $A8,$A8,$A8,$A8
	.byte $28,$28,$28,$28, $28,$28,$28,$28
	.byte $A8,$A8,$A8,$A8, $A8,$A8,$A8,$A8
	.byte $28,$28,$28,$28, $28,$28,$28,$28
	.byte $A8,$A8,$A8,$A8, $A8,$A8,$A8,$A8

	.byte $50,$50,$50,$50, $50,$50,$50,$50
	.byte $D0,$D0,$D0,$D0, $D0,$D0,$D0,$D0
	.byte $50,$50,$50,$50, $50,$50,$50,$50
	.byte $D0,$D0,$D0,$D0, $D0,$D0,$D0,$D0
	.byte $50,$50,$50,$50, $50,$50,$50,$50
	.byte $D0,$D0,$D0,$D0, $D0,$D0,$D0,$D0
	.byte $50,$50,$50,$50, $50,$50,$50,$50
	.byte $D0,$D0,$D0,$D0, $D0,$D0,$D0,$D0

.include "decompress_fast_v2.s"
.include "graphics/graphics.inc"
