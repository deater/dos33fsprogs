; PLASMAGORIA, Tiny version

; original code by French Touch

; trying to see how small I can get it


; note can use $F000 (or similar) for color lookup to get passable
;	effect on fewer bytes

.include "hardware.inc"


Table1	=	$8000
Table2	=	$8000+64

; Page Zero

GBASL			= $26
GBASH			= $27

COMPT1			= $30
COMPT2			= $31

PARAM1			= $60
PARAM2			= $61
PARAM3			= $62
PARAM4			= $63

; =============================================================================
; ROUTINE MAIN
; =============================================================================

plasma_debut:
	jsr	HGR
	bit	FULLGR

	jsr	make_tables

;	bit	PAGE1		; set page 1
;	bit	SET_GR		; set graphics
	bit	LORES		; set lo-res

	jsr	init_lores_colors

do_plasma:
	; init

	lda	#02
	sta	COMPT2
	sta	PARAM1
	sta	PARAM2
	sta	PARAM3
	sta	PARAM4

BP3:
	jsr	precalc			; pre-calc
	jsr	display_normal		; display normal

	inc	COMPT1
	bne	BP3

	dec	COMPT2
	bne	BP3

	jmp	do_plasma


; ============================================================================
; Precalculate some values
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

 	rts

; ============================================================================
; Display Routines
; ROUTINES AFFICHAGES
; ============================================================================

; Display "Normal"
; AFFICHAGE "NORMAL"

display_normal:

	ldx	#23			; lines 0-23	lignes 0-23

display_line_loop:

	txa
	jsr	GBASCALC

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
	sta	(GBASL),Y
	dey
	bpl	display_col_loop
	dex
	bpl	display_line_loop

	rts



lores_colors_fine=$8100
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
	rts

lores_colors_lookup:
.byte $00,$88,$55,$99,$ff,$bb,$33,$22,$66,$77,$44,$cc,$ee,$dd,$99,$11


.include "make_tables.s"


