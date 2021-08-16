	;===========================
	; hgr text box
	;===========================
	; point OUTL:OUTH at it
	; x1h,x1l,y1 x2h,x2l,y2
	; then X,Y of text
	; CR moves to next line
	; 0 ends

hgr_text_box:
	ldy	#0

	;====================
	; draw text box

	lda	(OUTL),Y
	sta	BOX_X1H
	iny
	lda	(OUTL),Y
	sta	BOX_X1L
	iny
	lda	(OUTL),Y
	sta	BOX_Y1
	iny

	lda	(OUTL),Y
	sta	BOX_X2H
	iny
	lda	(OUTL),Y
	sta	BOX_X2L
	iny
	lda	(OUTL),Y
	sta	BOX_Y2

	jsr	hgr_partial_save

	jsr	draw_box

	clc
	lda	OUTL
	adc	#6
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

;
;
;

        ldy     #0
        lda     (OUTL),Y
        sta     CURSOR_X
	sta	SAVED_X

        jsr     inc_outl
        lda     (OUTL),Y
        sta     CURSOR_Y
        jsr     inc_outl
disp_put_string_loop:
        ldy     #0
        lda     (OUTL),Y
        beq     disp_put_string_done
	cmp	#13
	beq	disp_end_of_line

        jsr     hgr_put_char_cursor

        inc     CURSOR_X
        jsr     inc_outl
        jmp     disp_put_string_loop

disp_end_of_line:
	clc
	lda	CURSOR_Y
	adc	#8
	sta	CURSOR_Y

	lda	SAVED_X
	sta	CURSOR_X

	jsr	inc_outl

	jmp	disp_put_string_loop

disp_put_string_done:

	rts


