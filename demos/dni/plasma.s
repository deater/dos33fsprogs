; Plasma D'ni Numbers

; by Vince `deater` Weaver / Dsr

; originally based on Plasmagoria (GPL3) code by French Touch

.include "hardware.inc"
.include "zp.inc"

lores_colors_fine=$8000
;tracker_song = peasant_song

	;======================================
	; start of code
	;======================================

plasma_mask:

	jsr	HGR		; have table gen appear on hgr page1



	;=================
        ; init music

PT3_LOC = song
PT3_ENABLE_APPLE_IIC = 1

	lda	#1
	sta	LOOP


	lda	#0
	sta	DONE_PLAYING

	sta     FRAMEL
	sta     WHICH_TRACK

.ifdef PT3_ENABLE_APPLE_IIC
        jsr     detect_appleii_model
.endif

	;=======================
        ; Detect mockingboard
        ;========================

;        jsr     print_mockingboard_detect       ; print message

        jsr     mockingboard_detect             ; call detection routine

        bcs     mockingboard_found

;        jsr     print_mocking_notfound

        ; possibly can't detect on IIc so just try with slot#4 anyway
        ; even if not detected

        jmp     setup_interrupt

mockingboard_found:
	; print found message


        ; modify message to print slot value

 ;       lda     MB_ADDR_H
  ;      sec
   ;     sbc     #$10
    ;    sta     found_message+11

;        jsr     print_mocking_found

        ;==================================================
        ; patch the playing code with the proper slot value
        ;==================================================

        jsr     mockingboard_patch

setup_interrupt:

;=======================
        ; Set up 50Hz interrupt
        ;========================

        jsr     mockingboard_init
        jsr     mockingboard_setup_interrupt

        ;============================
        ; Init the Mockingboard
        ;============================

        jsr     reset_ay_both
        jsr     clear_ay_both

        ;==================
        ; init song
        ;==================

        jsr     pt3_init_song

	 ;============================
        ; Enable 6502 interrupts
        ;============================
start_interrupts:
        cli             ; clear interrupt mask








;	cli	; start music

	bit	LORES			; set lo-res
	bit	FULLGR

	lda	#0
	sta	DRAW_PAGE


	lda	#$00
	sta	NUMBER_HIGH
	lda	#$00
	sta	NUMBER_LOW
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
	jsr	WAIT

	lda	NUMBER_HIGH
	cmp	#$02
	beq	next_scene

	jmp	goopy

next_scene:

	lda	#$0
	sta	DRAW_PAGE
	bit	PAGE1

	ldx	#$20
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
	jsr	GBASCALC

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


;.include "interrupt_handler.s"

;.include "mockingboard_constants.s"

;graphics_loc:
;	.byte	>dsr_empty-4,>dsr_small-4,>dsr_big-4,>dsr_big2-4

.align 	$100
sin1:
.incbin "tables"
sin2=sin1+$100
sin3=sin1+$200


; graphics
;dsr_empty:
;.incbin		"graphics/dsr_empty.gr"
;dsr_small:
;.incbin		"graphics/dsr_small.gr"
;dsr_big:
;.incbin		"graphics/dsr_big.gr"
;dsr_big2:
;.incbin		"graphics/dsr_big2.gr"

; music
;.include        "mA2E_2.s"


.include "print_dni_numbers.s"
.include "number_sprites.inc"
.include "gr_offsets.s"
.include "inc_base5.s"

.include "page_flip.s"



.ifdef PT3_ENABLE_APPLE_IIC
.include        "pt3_lib_detect_model.s"
.endif

.include        "pt3_lib_core.s"
.include        "pt3_lib_init.s"
.include        "pt3_lib_mockingboard_setup.s"
.include        "interrupt_handler.s"
; if you're self patching, detect has to be after interrupt_handler.s
.include        "pt3_lib_mockingboard_detect.s"







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

.align $100
song:
	.incbin "mA2E_3.pt3"
