; Fake BIOS screen
;  for another project

.include "zp.inc"
.include "hardware.inc"


bios_test:
	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	;===================
	; Load graphics
	;===================

	lda	#<graphics_data
	sta	ZX0_src
	lda	#>graphics_data
	sta	ZX0_src+1

	lda	#$20			; temporarily load to $2000

	jsr	full_decomp



end:
	jmp	end


.if 0
	jsr	vgi_make_tables

	jsr	HGR




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
.endif


	.include "zx02_optim.s"

graphics_data:
	.incbin "graphics/a2_energy.hgr.zx02"
