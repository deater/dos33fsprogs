


.include "hardware.inc"

TEMP0	= $10
TEMP1	= $11
TEMP2	= $12
TEMP3	= $13
TEMP4	= $14
TEMP5	= $15


HGR_BITS = $1C

GBASL	= $26
GBASH	= $27
CURSOR_X	= $62
CURSOR_Y	= $63
HGR_COLOR	= $E4
P0	= $F1
P1	= $F2
P2	= $F3
P3	= $F4
P4	= $F5
P5	= $F6

INL	= $FC
INH	= $FD
OUTL	= $FE
OUTH	= $FF



COUNT = TEMP5

font_test:

	jsr	vgi_make_tables

	jsr	HGR

        VGI_RCOLOR      = P0
        VGI_RX1         = P1
        VGI_RY1         = P2
        VGI_RXRUN       = P3
        VGI_RYRUN       = P4
        VGI_RCOLOR2     = P5    ; only for dither


	; draw rectangle

	lda	#$33
	sta	VGI_RCOLOR

	lda	#53
	sta	VGI_RX1
	lda	#24
	sta	VGI_RY1
	lda	#200
	sta	VGI_RXRUN
	lda	#58
	sta	VGI_RYRUN

	jsr	vgi_simple_rectangle

	; draw lines

	ldx	#2			; purple
	lda     COLORTBL,X
        sta     HGR_COLOR

	ldy	#0
	ldx	#59
	lda	#29
	jsr     HPLOT0          ; plot at (Y,X), (A)

	ldx	#0
	lda	#59
	ldy	#78
	jsr     HGLIN           ; line to (X,A),(Y)

	ldy	#0
	ldx	#247
	lda	#29
	jsr     HPLOT0          ; plot at (Y,X), (A)

	ldx	#0
	lda	#247
	ldy	#78
	jsr     HGLIN           ; line to (X,A),(Y)



	ldy	#0
	ldx	#57
	lda	#29
	jsr     HPLOT0          ; plot at (Y,X), (A)

	ldx	#0
	lda	#249
	ldy	#29
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	#249
	ldy	#78
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	#57
	ldy	#78
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	#57
	ldy	#29
	jsr     HGLIN           ; line to (X,A),(Y)



	ldy	#0
	ldx	#58
	lda	#30
	jsr     HPLOT0          ; plot at (Y,X), (A)

	ldx	#0
	lda	#248
	ldy	#30
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	#248
	ldy	#77
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	#58
	ldy	#77
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	#58
	ldy	#30
	jsr     HGLIN           ; line to (X,A),(Y)








;	ldx	#5
;	ldy	#10
;	lda	#'A'

;	jsr	hgr_put_char


	lda	#<test3
	sta	OUTL
	lda	#>test3
	sta	OUTH

	jsr	hgr_put_string

	jsr	hgr_put_string

	jsr	hgr_put_string

	lda	#<test1
	sta	OUTL
	lda	#>test1
	sta	OUTH

	jsr	hgr_put_string

	lda	#<test2
	sta	OUTL
	lda	#>test2
	sta	OUTH

	jsr	hgr_put_string


end:
	jmp end


test1:
	;           0123456789012345678901234567890123456789
	.byte 0,10,"PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS!",0

test2:
	.byte 0,150,"pack my box with five dozen liquor jugs?",0

test3:
	.byte 9,36,"This is a HGR font test.",0

test4: .byte 0,120,"0123456789)(*&^%$#@!`~<>,./';:[]{}\|_+=",127,0
test5: .byte 0,130,"@/\/\/\/\______                    |",0

.include "hgr_font.s"

.include "hgr_rectangle.s"
