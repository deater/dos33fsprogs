; Plasma D'ni Numbers

; by Vince `deater` Weaver / Dsr

; originally based on Plasmagoria (GPL3) code by French Touch

.include "../hardware.inc"
.include "../zp.inc"

lores_colors_fine=$8000


	;======================================
	; start of code
	;======================================

plasma_mask:

	bit	LORES			; set lo-res
	bit	FULLGR

	lda	#0
	sta	DRAW_PAGE
	sta	NUMBER_HIGH
	sta	NUMBER_LOW
	sta	WHICH_TRACK
goopy:


	lda	#$4
	clc
	adc	DRAW_PAGE
	tax
	lda	#$0		; black

	jsr	clear_1k

	lda	#$4
	sta	XPOS
	lda	#$5
	sta	YPOS

	jsr	draw_full_dni_number

	jsr	inc_base5

	jsr	flip_page

	lda	#200
	jsr	wait

	lda	NUMBER_HIGH
	cmp	#$02
	beq	next_scene

	jmp	goopy

next_scene:

	lda	#$0
	sta	DRAW_PAGE
	bit	PAGE1

	ldx	#$20		; ???
	lda	#$FF		; white

	jsr	clear_1k


; ============================================================================
; init lores colors (inline)
; ============================================================================

	lda	#<lores_colors_fine
	sta	INL
	lda	#>lores_colors_fine
	sta	INH
multiple_init_lores_colors:


init_lores_colors:
	ldx	#0
	ldy	#0

init_lores_colors_loop:

lcl_smc1:
	lda	lores_colors_lookup,X
	sta	(INL),Y
	iny
	sta	(INL),Y
	iny
	sta	(INL),Y
	iny
	sta	(INL),Y
	iny
	beq	done_init_lores_colors

	inx
	txa
	and	#$f
	tax
	jmp	init_lores_colors_loop

done_init_lores_colors:
	lda	lcl_smc1+1
	clc
	adc	#$10
	sta	lcl_smc1+1

	inc	INH
	lda	INH
	cmp	#$84
	bne	multiple_init_lores_colors

	;====================================
	; do plasma
	;====================================

do_plasma:
	; init



BP3:

	;=============================
	; adjust color palette
;	lda	WHICH_TRACK
;	clc
;	adc	#$80
;	sta	display_lookup_smc+2

; ============================================================================
; Precalculate some values (inlined)
; ============================================================================

precalc:
	lda	PARAM1		; self modify various parts
	sta	pc_off1+1
	lda	PARAM2
	sta	pc_off2+1
	lda	PARAM3
	sta	pc_off3+1
	lda	PARAM4
	sta	pc_off4+1

	; Table1(X) = sin1(PARAM1+X)+sin2(PARAM1+X)
	; Table2(X) = sin3(PARAM3+X)+sin1(PARAM4+X)

	ldx	#$28		; 40
pc_b1:
pc_off1:
	lda	sin1
pc_off2:
	adc	sin2
	sta	Table1,X
pc_off3:
	lda	sin3
pc_off4:
	adc	sin1
	sta	Table2,X

	inc	pc_off1+1
	inc	pc_off2+1
	inc	pc_off3+1
	inc	pc_off4+1

 	dex
	bpl	pc_b1

 	inc	PARAM1
 	inc	PARAM1
	dec	PARAM2
 	inc	PARAM3
	dec	PARAM4

; ============================================================================
; Display Routines
; ============================================================================


display_normal:

	ldx	#23			; lines 0-23	lignes 0-23

display_line_loop:

	txa
	asl
	tay

	lda	gr_offsets,Y
	sta	GBASL
	lda	gr_offsets+1,Y
	sta	GBASH

;	jsr	GBASCALC

	; set up pointer for mask

	ldy	WHICH_TRACK	; CURRENT_EFFECT

	lda	GBASL
        sta     INL
	lda	GBASH

	clc
	adc	#$1c	; load from $2000

;	adc	graphics_loc,Y
        sta     INH

	lda	GBASH
	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	#39			; col 0-39

	lda	Table2,X		; setup base sine value for row
	sta	display_row_sin_smc+1
display_col_loop:
	lda	Table1,Y		; load in column sine value
display_row_sin_smc:
	adc	#00			; add in row value

	; MASKING happens HERE
	and	(INL),Y

	sta	display_lookup_smc+1	; patch in low byte of lookup
display_lookup_smc:
	lda	lores_colors_fine	; attention: must be aligned
	sta	(GBASL),Y
	dey
	bpl	display_col_loop
	dex
	bpl	display_line_loop

; ============================================================================

	lda	#4
	sta	XPOS
	lda	#5
	sta	YPOS

	lda	NUMBER_HIGH
	and	#$3

	clc
	adc	#$80
	sta	display_lookup_smc+2

	lda	NUMBER_HIGH
	and	#$f

	cmp	#0
	beq	effect3

	cmp	#1
	beq	effect4

	cmp	#2
	beq	effect0

	cmp	#3
	beq	effect1

	cmp	#4
	beq	effect2

effect2:

	ldx	#$20
	lda	#$00		; black
	sta	SIN_COUNT
	jsr	clear_1k

	lda	DRAW_PAGE
	pha

	lda	#$1c
	sta	DRAW_PAGE
	jsr	draw_full_dni_number

	pla
	sta	DRAW_PAGE

	ldx	#$20
	jsr	invert_1k

	inc	FRAMEL
	lda	FRAMEL
	and	#$3
	bne	no_inc_effect2

	jsr	inc_base5
no_inc_effect2:
	jmp	done_effect


effect0:

	; full mask, so full plasma

	ldx	#$20
	lda	#$FF		; white
	jsr	clear_1k

	; overlay with number

	jsr	draw_full_dni_number

	; increment each 8th frame

	inc	FRAMEL
	lda	FRAMEL
	and	#$3
	bne	no_inc_effect0

	jsr	inc_base5

no_inc_effect0:
	jmp	done_effect

effect3:
	ldx	SIN_COUNT
	lda	sine_table,X
	sta	YPOS

effect4:
effect1:
	ldx	#$20
	lda	#$0		; black
	jsr	clear_1k

	lda	DRAW_PAGE
	pha

	lda	#$1c
	sta	DRAW_PAGE
	jsr	draw_full_dni_number

	pla
	sta	DRAW_PAGE

	inc	SIN_COUNT
	lda	SIN_COUNT
	cmp	#25
	bne	sin_ok
	lda	#0
	sta	SIN_COUNT
sin_ok:

	inc	FRAMEL
	lda	FRAMEL
	and	#$3
	bne	no_inc_effect1

	jsr	inc_base5
no_inc_effect1:


done_effect:


	jsr	flip_page

	inc	COMPT1
	beq	zoop
;	bne	BP3
	jmp	BP3
zoop:

	dec	COMPT2
	beq	zoop2
;	bne	BP3
	jmp	BP3
zoop2:



;	beq	do_plasma	; bra
	jmp	do_plasma	; bra



.align $100

lores_colors_lookup:

; dark
.byte $00,$88,$55,$99,$ff,$bb,$33,$22,$66,$77,$44,$cc,$ee,$dd,$99,$11
; pink
.byte $00,$11,$33,$BB,$FF,$BB,$33,$11,$00,$11,$33,$BB,$FF,$BB,$33,$11
; blue
.byte $00,$22,$66,$77,$FF,$77,$66,$22,$00,$22,$66,$77,$FF,$77,$66,$22
; green
.byte $00,$44,$CC,$DD,$FF,$DD,$CC,$44,$00,$44,$CC,$DD,$FF,$DD,$CC,$44


;.include "make_tables.s"


.align 	$100
sin1:
.incbin "tables"
sin2=sin1+$100
sin3=sin1+$200

.include "print_dni_numbers.s"
.include "number_sprites.inc"
.include "../gr_offsets.s"
.include "inc_base5.s"
.include "../wait.s"

.include "page_flip.s"


	;======================
	;
	;======================
	; X = page
	; A = value
clear_1k:
	stx	OUTH
	ldx	#0
	stx	OUTL

	ldx	#4

;	lda	#0
	ldy	#0
inner_loop:
	sta	(OUTL),Y
	iny
	bne	inner_loop

	inc	OUTH
	dex
	bne	inner_loop

	rts

	;======================
	;
	;======================
	; X = page
invert_1k:
	stx	OUTH
	ldx	#0
	stx	OUTL

	ldx	#4

	ldy	#0
invert_inner_loop:
	lda	(OUTL),Y
	eor	#$FF
	sta	(OUTL),Y
	iny
	bne	invert_inner_loop

	inc	OUTH
	dex
	bne	invert_inner_loop

	rts

sine_table:
	.byte 5,6,7,8,9
	.byte 10,10,10,10,9
	.byte 8,7,6,5,4
	.byte 3,2,1,0,0
	.byte 0,1,2,3,4

