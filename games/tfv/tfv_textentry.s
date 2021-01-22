enter_name:

	jsr	TEXT

	; zero out name

	ldx	#0
	lda	#0
zero_name_loop:
	sta	HERO_NAME,X
	inx
	cpx	#8
	bne	zero_name_loop


	lda	#0
	sta	NAMEX
	sta	XX
	sta	YY

name_loop:
	; clear screen
	lda	#$A0
	jsr	clear_top_a
	jsr	clear_bottom

	; print entry string at top

	lda     #>(enter_name_string)
        sta     OUTH
	lda     #<(enter_name_string)
        sta     OUTL
	jsr	move_and_print



	;=============================
	; print current name + cursor
	; on screen at 11,2?

	; get pointer to line 2
	lda	gr_offsets+(2*2)
	clc
	adc	#11
	sta	OUTL
	lda	gr_offsets+(2*2)+1
	clc
	adc	DRAW_PAGE
	sta	OUTH

	ldx	#0
	ldy	#0
print_name_loop:

	cpx	NAMEX
	bne	print_name_name
print_name_cursor:
	lda	#'+'
	bne	print_name_put_char	; bra

print_name_name:
	lda	HERO_NAME,X
	bne	print_name_char
print_name_zero:
	lda	#'_'+$80
	bne	print_name_put_char	; bra

print_name_char:
	ora	#$80

print_name_put_char:
	sta	(OUTL),Y

done_print_name_loop:

	inx

	iny
	iny

	cpy	#16
	bne	print_name_loop


	;=====================
	; print char selector

	ldx	#0
print_char_selector_loop:

	txa
	asl
	asl
	clc
	adc	#10
	tay

	; set up y pointer

	lda	gr_offsets,Y
	clc
	adc	#11
	sta	GBASL
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	#0
inner_matrix_loop:

	txa			; want Ycoord*8
	asl
	asl
	asl
	sta	TEMPY

	tya
	adc	TEMPY

	; adjust to numbers if ycoord>4

	cpx	#4
	bcs	textentry_numbers

textentry_alpha:
	clc
	adc	#$40
textentry_numbers:

	sta	TEMPY		; save char for later

	; check if Y equal
	cpx	YY
	bne	textentry_normal
	cpy	XX
	beq	textentry_inverse

textentry_normal:
	ora	#$80		; convert to NORMAL uppercase
	sta	(GBASL),Y
	lda	#' '|$80
	jmp	textentry_putc

textentry_inverse:
	and	#$3f		; convert to INVERSE
	sta	(GBASL),Y
	lda	#' '

textentry_putc:
	inc	GBASL
	sta	(GBASL),Y



	iny
	cpy	#8
	bne	inner_matrix_loop


	inx

	cpx	#8
	bne	print_char_selector_loop


.if 0
		for(yy=0;yy<8;yy++) {
                        basic_htab(12);
                        basic_vtab(yy*2+6);
                        for(xx=0;xx<8;xx++) {
                                if (yy<4) sprintf(tempst,"%c ",(yy*8)+xx+64);
                                else  sprintf(tempst,"%c ",(yy*8)+xx);

                                if ((xx==cursor_x) && (yy==cursor_y)) basic_inverse();
                                else basic_normal();

                                basic_print(tempst);
                        }
                }

                basic_htab(12);
                basic_vtab(22);
                basic_normal();

		if ((cursor_y==8) && (cursor_x<4)) basic_inverse();
                basic_print(" DONE ");
                basic_normal();
                basic_print("   ");
                if ((cursor_y==8) && (cursor_x>=4)) basic_inverse();
                basic_print(" BACK ");
.endif

	;=================
	; handle keypress

	jsr	get_keypress

check_textentry_up:
	cmp	#'W'
	bne	check_textentry_down
textentry_up:
	dec	YY
	jmp	done_textentry

check_textentry_down:
	cmp	#'S'
	bne	check_textentry_left
textentry_down:
	inc	YY
	jmp	done_textentry


check_textentry_left:
	cmp	#'A'
	bne	check_textentry_right
textentry_left:
	dec	XX
	lda	YY
	cmp	#8
	bne	textentry_left_not_bottom
	dec	XX
	dec	XX
	dec	XX
textentry_left_not_bottom:
	jmp	done_textentry



check_textentry_right:
	cmp	#'D'
	bne	check_textentry_escape
textentry_right:
	inc	XX
	lda	YY
	cmp	#8
	bne	textentry_right_not_bottom
	inc	XX
	inc	XX
	inc	XX
textentry_right_not_bottom:
	jmp	done_textentry


check_textentry_escape:
	cmp	#27
	bne	done_textentry_keypress
textentry_escape:
	jmp	done_enter_name


done_textentry_keypress:

.if 0
			else if (ch==13) {
                                if (cursor_y==8) {
                                        if (cursor_x<4) {
                                                ch=27;
                                                break;
                                        }
                                        else {
                                                nameo[name_x]=0;
                                                name_x--;
                                                if (name_x<0) name_x=0;
                                                break;
                                        }
                                }

                                if (cursor_y<4) nameo[name_x]=(cursor_y*8)+
                                                        cursor_x+64;
                                else nameo[name_x]=(cursor_y*8)+cursor_x;
                                name_x++;
                        }
			else if ((ch>32) && (ch<128)) {
                                nameo[name_x]=ch;
                                name_x++;

                        }
	; if (ch==27) break;

.endif
	;=======================
	; keep things in bounds

	; if (name_x>7) name_x=7;
	lda	NAMEX
	cmp	#7
	bcc	namex_good
	lda	#7
	sta	NAMEX
namex_good:

check_xx_bounds:

	; if (cursor_x<0) { cursor_x=7; cursor_y--; }
	; if (cursor_x>7) { cursor_x=0; cursor_y++; }

check_xx_too_small:
	lda	XX
	bpl	check_xx_too_big
	lda	#7
	sta	XX
	dec	YY
	jmp	check_yy_bounds

check_xx_too_big:
	cmp	#8
	bcc	check_yy_bounds	; blt
	lda	#0
	sta	XX
	inc	YY

check_yy_bounds:

	; if (cursor_y<0) cursor_y=8;
	; if (cursor_y>8) cursor_y=0;

check_yy_too_small:
	lda	YY
	bpl	check_yy_too_big
	lda	#8
	sta	YY
	bne	done_check_bounds	; bra

check_yy_too_big:
	cmp	#8
	beq	check_yy_buttons
	bcc	done_check_bounds

	lda	#0
	sta	YY
	beq	done_check_bounds	; bra

	; if ((cursor_y==8) && (cursor_x<4)) cursor_x=0;
	; else if ((cursor_y==8) && (cursor_x>=4)) cursor_x=4;
check_yy_buttons:
	lda	XX
	cmp	#4
	bcc	button_make_0
	lda	#4
	sta	XX
	bne	done_check_bounds	; bra

button_make_0:
	lda	#0
	sta	XX


done_check_bounds:




done_textentry:


	jsr	page_flip

	jmp	name_loop

done_enter_name:

	; FIXME: if empty, set to default

	rts


enter_name_string:
        .byte 0,0,"PLEASE ENTER A NAME:",0

default_hero:
	.byte "DEATER",0

default_heroine:
	.byte "FROGGY",0
