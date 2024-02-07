; Plasma Mask

; for Lovebyte 2024

; by Vince `deater` Weaver / Dsr

; originally based on Plasmagoria (GPL3) code by French Touch


.include "hardware.inc"
.include "zp.inc"

lores_colors_fine=$8100

	;======================================
	; start of code
	;======================================

plasma_mask:

	jsr	HGR		; have table gen appear on hgr page1
	bit	FULLGR


	ldx	#0
load_graphics_loop:
	lda	graphics_src_l,X
	sta	zx_src_l+1
	lda	graphics_src_h,X
	sta	zx_src_h+1
	lda	graphics_loc,X
	stx	XSAVE
	jsr	zx02_full_decomp
	ldx	XSAVE
	inx
	cpx	#4
	bne	load_graphics_loop

	;=================
        ; init music

        lda     #0
        sta     FRAME
        sta     WHICH_TRACK

	;===================
        ; music Player Setup

tracker_song = peasant_song

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"

	cli	; start music

;	jsr	make_tables

	bit	LORES			; set lo-res

; ============================================================================
; init lores colors (inline)
; ============================================================================

init_lores_colors:
	ldx	#0
	ldy	#0

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

	;====================================
	; do plasma
	;====================================

do_plasma:
	; init


BP3:

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
	sec				; blurgh
	sbc	#4			;
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





;lores_colors_lookup = $F000

lores_colors_lookup:
.byte $00,$88,$55,$99,$ff,$bb,$33,$22,$66,$77,$44,$cc,$ee,$dd,$99,$11


;.include "make_tables.s"


.include "interrupt_handler.s"
.include "mockingboard_constants.s"

.include "zx02_optim.s"


graphics_src_l:
	.byte	<dsr_empty,<dsr_small,<dsr_big,<dsr_big2
graphics_src_h:
	.byte	>dsr_empty,>dsr_small,>dsr_big,>dsr_big2

graphics_loc:
	.byte	$A0,$A4,$A8,$AC

; graphics
dsr_big:
.incbin		"graphics/dsr_big.gr.zx02"
dsr_big2:
.incbin		"graphics/dsr_big2.gr.zx02"
dsr_small:
.incbin		"graphics/dsr_small.gr.zx02"
dsr_empty:
.incbin		"graphics/dsr_empty.gr.zx02"

; music
.include        "mA2E_2.s"



;sin1    =       $2000
;sin2    =       $2100
;sin3    =       $2200
save    =       $2300

.align $100
sin1:
	.incbin	"precalc/tables"
sin2=sin1+$100
sin3=sin1+$200
