
	; Autogenerates code for Type2 (escape)

	; First 9 (?) lines = text mode
	; 

UPDATE2_START = $9000

;DEFAULT_COLOR	= $0

create_update_type2:
	ldx	#192
	lda	#<UPDATE2_START
	sta	OUTL
	lda	#>UPDATE2_START
	sta	OUTH
	lda	#<another_scanline
	sta	INL
	lda	#>another_scanline
	sta	INH
create_update2_outer_loop:
	ldy	#0
create_update2_inner_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	iny
	cpy	#47
	bne	create_update2_inner_loop

	; toggle PAGE0/PAGE1
	txa
	and	#$1	; ror?
	clc
	adc	#$54
	ldy	#1
	sta	(OUTL),Y

	clc
	lda	#47
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

	dex
	bne	create_update2_outer_loop

	ldy	#0
	lda	#$60				; rts
	sta	(OUTL),Y

	rts

ESCAPE_START = 30


	;===========================

setup_update_type2:

	; add call to TEXT

	lda	#$2c		; bit C051	; 4
	sta	$9003
	lda	#$51
	sta	$9004
	lda	#$c0
	sta	$9005

	lda	#$A5		; lda ZERO	; 3
	sta	$9006
	lda	#$FA
	sta	$9007

	lda	#$A2		; ldx, 1	; 3
	sta	$9008
	lda	#$01
	sta	$9009

	; set first 9 lines to PAGE0

	lda	#$54
	sta	$9030
	sta	$908E
	sta	$90EC
	sta	$914A


	; add call to GRAPHICS
	; line 9 (91a7)

	lda	#$2c		; bit C051	; 4
	sta	$91aa
	lda	#$50
	sta	$91ab
	lda	#$c0
	sta	$91ac

	lda	#$A5		; lda ZERO	; 3
	sta	$91ad
	lda	#$FA
	sta	$91ae

	lda	#$A2		; ldx, 1	; 3
	sta	$91af
	lda	#$01
	sta	$91b0

	;====================
	;====================

	lda	#4		; which page
	sta	RASTER_PAGE

	ldx	#ESCAPE_START
	lda	#<(UPDATE_START+(ESCAPE_START*47))
	sta	OUTL
	lda	#>(UPDATE_START+(ESCAPE_START*47))
	sta	OUTH
setup_escape_outer_loop:
	ldy	#8
	lda	#0
	sta	RASTER_X
setup_escape_inner_loop:
	txa
	pha
	inx
	txa				; start one earlier
	lsr
	lsr
	and	#$fe
	tax
	clc
	lda	gr_offsets,X
	adc	RASTER_X
	inc	RASTER_X
	sta	(OUTL),Y
	iny
	clc
	lda	gr_offsets+1,X
	adc	RASTER_PAGE
	sta	(OUTL),Y
	iny

	iny
	iny
	iny

	pla
	tax

	cpy	#43
	bne	no_fixup

	iny			; special case last one
	iny

no_fixup:
	cpy	#50
	bne	setup_escape_inner_loop

	; fix the one at the end
	dey
	dey
	dey
	dey
	dey
	lda	(OUTL),Y
	and	#$f8
	sta	(OUTL),Y

	clc
	lda	#47
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH


	lda	RASTER_PAGE
	eor	#$04
	sta	RASTER_PAGE

	inx
	cpx	#(128+ESCAPE_START)
	bne	setup_escape_outer_loop

	rts


another_scanline:
.byte	$2C,$54,$C0		; bit	PAGE0   ; 4
.byte	$A2,$01		;smc018:  ldx	#$01    ; 2
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A9,$00			; lda	#$00    ; 2
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
.byte	$A2,$00			; ldx	#$00    ; 2
.byte	$A5,$C5			; lda	ZERO    ; 3
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
	;==========				;===
	; 47???					; 65

