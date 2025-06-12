	;===========================
	; hgr text box
	;===========================
	; loads from OUTL:OUTH
	;	first bytes are X1L/7,Y1,X2L/7,Y2 for rectangle
	;	then X,Y of text
	;	CR moves to next line
	;	0 ends

hgr_text_box:
	ldy	#0

	;====================
	; draw text box

;	lda	(OUTL),Y
;	sta	BOX_X1H
;	iny
	lda	(OUTL),Y
	sta	BOX_X1L
	iny
	lda	(OUTL),Y
	sta	BOX_Y1
	iny

;	lda	(OUTL),Y
;	sta	BOX_X2H
;	iny
	lda	(OUTL),Y
	sta	BOX_X2L
	iny
	lda	(OUTL),Y
	sta	BOX_Y2

;skip_box_save_smc:
;	lda	#1
;	beq	skip_box_save

;	lda     BOX_Y1
 ;       sta     SAVED_Y1

  ;      ldx     BOX_Y2
   ;     stx     SAVED_Y2

;	jsr	hgr_partial_save

;skip_box_save:

	jsr	draw_box

	clc			; skip rectangle co-ordinates
	lda	OUTL
	adc	#4
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

	; fallthrough

	;=======================
	; disp_put_string
	;	OUTL:OUTH has co-ords followed by string
	;	CR (13) goes to next line
disp_put_string:
        ldy     #0
        lda     (OUTL),Y
        sta     CURSOR_X

	jsr     inc_outl
	lda     (OUTL),Y
	sta     CURSOR_Y
	jsr     inc_outl

disp_put_string_cursor:
	lda	CURSOR_X
	sta	SAVED_X

disp_one_line:

disp_put_string_loop:
	ldy     #0
	lda     (OUTL),Y
	beq     disp_put_string_done
	bmi	disp_use_lookup

	cmp	#13
	beq	disp_end_of_line

        jsr     hgr_put_char_cursor

        inc     CURSOR_X
        jsr     inc_outl
        jmp     disp_put_string_loop

disp_end_of_line:
	clc
	lda	CURSOR_Y
	adc	#9		; skip 9 so descenders don't interfere
	sta	CURSOR_Y

	lda	SAVED_X
	sta	CURSOR_X

disp_inc_done:

	jsr	inc_outl

	jmp	disp_put_string_loop

disp_put_string_done:

	jsr	inc_outl		; put to next

	rts

	;====================
	; use text lookup

disp_use_lookup:
	and	#$7f
	tax
	lda	text_offset_table,X

	tax
disp_word_loop:
	txa
	stx	disp_loop_smc+1
	lda	word_table,X
	php

	jsr	hgr_put_char_cursor
        inc     CURSOR_X
	plp
	bmi	disp_inc_done

disp_loop_smc:
	ldx	#$dd
	inx
	bne	disp_word_loop		; bra


	;============================
	; like above, but don't save
	;============================
;hgr_text_box_nosave:
;	lda	#0
;	sta	skip_box_save_smc+1
;	jsr	hgr_text_box
;	lda	#1
;	sta	skip_box_save_smc+1
;	rts

.include "text/word_list.s"
