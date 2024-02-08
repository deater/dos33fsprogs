; Plasma Mask (compressed)

; for Lovebyte 2024

; by Vince `deater` Weaver / Dsr

; originally based on Plasmagoria (GPL3) code by French Touch

; 1135 -- initial
; 1000 -- compressed
;  997 -- minor optimization
;  984 -- inline zx02 compress
;  988 -- fix fullscreen
; 1020 -- add precalc countdown
; 1015 -- optimize music (track_h always same)
; 1012 -- optimize next track (4 is a nice power of 2)
; 1011 -- overlap constants
; 1023 -- add credits to precalc
; 1018 -- optimize initializations
; 1025 -- add one more credit
; 1024 -- shrink main loop enough to use bne
; 1020 -- re-arrange functions until smaller, remove a few spaces

.include "hardware.inc"
.include "zp.inc"

lores_colors_fine=$8000
tracker_song = peasant_song

	;======================================
	; start of code
	;======================================

plasma_mask:

	jsr	HGR		; have table gen appear on hgr page1



	;=================
        ; init music

	; A and Y=0 from HGR

;	we set these when we init the rest of the ZP vars
;	sta     FRAME
;	sta     WHICH_TRACK

	;===================
        ; music Player Setup


	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "tracker_init.s"

.include "mockingboard_init.s"



	jsr	make_tables

	cli	; start music

	bit	LORES			; set lo-res
	bit	FULLGR

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
	jsr	GBASCALC

	; set up pointer for mask

	ldy	WHICH_TRACK	; CURRENT_EFFECT

	lda	GBASL
        sta     INL
	lda	GBASH

	clc
	adc	graphics_loc,Y
        sta     INH

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

	inc	COMPT1
	bne	BP3

	dec	COMPT2
	bne	BP3

	beq	do_plasma	; bra
;	jmp	do_plasma	; bra



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


.include "make_tables.s"


.include "interrupt_handler.s"

.include "mockingboard_constants.s"

graphics_loc:
	.byte	>dsr_empty-4,>dsr_small-4,>dsr_big-4,>dsr_big2-4

.align 	$100
; graphics
dsr_empty:
.incbin		"graphics/dsr_empty.gr"
dsr_small:
.incbin		"graphics/dsr_small.gr"
dsr_big:
.incbin		"graphics/dsr_big.gr"
dsr_big2:
.incbin		"graphics/dsr_big2.gr"

; music
.include        "mA2E_2.s"



