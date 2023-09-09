; PLASMAGORIA, hi-res version

; original code by French Touch


.include "hardware.inc"

hposn_high=$6000
hposn_low =$6100
hposn_high_div8=$6200
hposn_low_div8 =$6300

;Table1	=	$8000
;Table2	=	$8000+64

HGR     =       $F3E2

; Page Zero

GBASL	= $26
GBASH	= $27

COMPT1	= $30
COMPT2	= $31

PARAM1	= $60
PARAM2	= $61
PARAM3	= $62
PARAM4	= $63

Table1	= $A0	; 40 bytes
Table2	= $D0	; 40 bytes

PAGE	= $FC
COUNT	= $FD
GBASH_SAVE = $FE

; =============================================================================
; ROUTINE MAIN
; =============================================================================

plasma_debut:
	jsr	HGR		; have table gen appear on hgr page1
	bit	FULLGR

	jsr	build_tables

	ldx	#23
	ldy	#184
div8_loop:
	lda	hposn_low,Y
	sta	hposn_low_div8,X
	lda	hposn_high,Y
	sta	hposn_high_div8,X
	dey
	dey
	dey
	dey
	dey
	dey
	dey
	dey
	dex
	bpl	div8_loop

	lda	#0
	sta	PAGE

lores_colors_fine=$8100

; ============================================================================
; init lores colors (inline)
; ============================================================================

init_lores_colors:
	ldx	#0
	ldy	#0
; 347

init_lores_colors_loop:
	lda	lores_colors_lookup,X
	sta	lores_colors_fine,Y
	iny
	sta	lores_colors_fine,Y
	iny
	sta	lores_colors_fine,Y
	iny
	sta	lores_colors_fine,Y
	iny
	beq	done_init_lores_colors

	inx
	txa
	and	#$f
	tax
	jmp	init_lores_colors_loop

done_init_lores_colors:

; ============================================================================

do_plasma:
	; init

;	lda	#02
;	ldx	#5
;init_loop:
;	sta	COMPT1,X
;	dex
;	bne	init_loop

BP3:

; ============================================================================
; Precalculate some values (inlined)
; ROUTINES PRE CALCUL
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
; ROUTINES AFFICHAGES
; ============================================================================

; Display "Normal"
; AFFICHAGE "NORMAL"

display_normal:

	ldx	#23			; lines 0-23	lignes 0-23

display_line_loop:

	lda	hposn_low_div8,X
	sta	GBASL

	ldy	#39			; col 0-39

	lda	Table2,X		; setup base sine value for row
	sta	display_row_sin_smc+1
display_col_loop:
	lda	Table1,Y		; load in column sine value
display_row_sin_smc:
	adc	#00			; add in row value
	sta	display_lookup_smc+1	; patch in low byte of lookup
display_lookup_smc:
	lda	lores_colors_fine	; attention: must be aligned
	sta	color_smc+1

	lda	hposn_high_div8,X
	clc
	adc	PAGE
	sta	GBASH

	lda	#7
	sta	COUNT
store_loop:
color_smc:
	lda	#$fe
	sta	(GBASL),Y
	clc
	lda	#$4
	adc	GBASH
	sta	GBASH
	dec	COUNT
	bpl	store_loop

	dey
	bpl	display_col_loop
	dex
	bpl	display_line_loop

; ============================================================================

	lda	PAGE
	beq	was_page1
was_page2:
	bit	PAGE2
	lda	#0
	beq	done_pageflip
was_page1:
	bit	PAGE1
	lda	#$20
done_pageflip:
	sta	PAGE

	inc	COMPT1
	beq	display_done2
;	bne	BP3
	jmp	BP3

display_done2:

	dec	COMPT2
	beq	display_done
;	bne	BP3
	jmp	BP3
display_done:

	jmp	do_plasma
;	beq	do_plasma	; bra





lores_colors_lookup:
.byte $00,$88,$55,$99,$ff,$bb,$33,$22,$66,$77,$44,$cc,$ee,$dd,$99,$11

.include "hgr_table.s"

.align 256
sin1:
.incbin "tables"
sin2=sin1+256
sin3=sin2+256
