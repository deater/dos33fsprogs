
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

;BARS_START = 46

.if 0
	;===========================
	; from 40 to 168?
setup_rasterbars:

	lda	#4		; which page
	sta	RASTER_PAGE

	ldx	#BARS_START
	lda	#<(UPDATE_START+(BARS_START*49))
	sta	OUTL
	lda	#>(UPDATE_START+(BARS_START*49))
	sta	OUTH
setup_rasterbars_outer_loop:
	ldy	#6
	lda	#13
	sta	RASTER_X
setup_rasterbars_inner_loop:
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
	pla
	tax

	cpy	#48
	bne	setup_rasterbars_inner_loop

	clc
	lda	#49
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH


	lda	RASTER_PAGE
	eor	#$04
	sta	RASTER_PAGE

	inx
	cpx	#184
	bne	setup_rasterbars_outer_loop

	rts
.endif

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
.byte	$A5,$85			; lda	ZERO    ; 3
.byte	$9D,$00,$02		; sta	$c00,X  ; 5
	;==========				;===
	; 47???					; 65

