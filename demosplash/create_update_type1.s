
	; Autogenerates code that does interleaved Page0/Page1 lores mode
	; but leaving room for 14 pixels/line of per-scanline color

UPDATE_START = $9000

create_update_type1:
	ldx	#192
	lda	#<UPDATE_START
	sta	OUTL
	lda	#>UPDATE_START
	sta	OUTH
	lda	#<one_scanline
	sta	INL
	lda	#>one_scanline
	sta	INH
create_update_outer_loop:
	ldy	#0
create_update_inner_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	iny
	cpy	#49
	bne	create_update_inner_loop

	; toggl PAGE0/PAGE1
	txa
	and	#$1	; ror?
	clc
	adc	#$54
	ldy	#1
	sta	(OUTL),Y

	clc
	lda	#49
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

	dex
	bne	create_update_outer_loop

	ldy	#0
	lda	#$60
	sta	(OUTL),Y

	rts

one_scanline:
.byte	$2C,$54,$C0	; bit	PAGE0	; 4
.byte	$A9,$0B		; lda	#$0b	; 2
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$A5,$FA		; lda	TEMP    ; 3

