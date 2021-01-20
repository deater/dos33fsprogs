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
	sta	OUTL
	lda	gr_offsets+(2*2)+1
	clc
	adc	DRAW_PAGE
	sta	OUTH

	ldx	#0
	ldy	#11
print_name_loop:

	cpy	NAMEX
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
	cpy	#25
	bne	print_name_loop

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

	jsr	get_keypress
	bne	done_enter_name

.if 0
		while(1) {
                        ch=grsim_input();

                        if (ch==APPLE_UP) { // up
                                cursor_y--;
                        }

                        else if (ch==APPLE_DOWN) { // down
                                cursor_y++;
                        }

                        else if (ch==APPLE_LEFT) { // left
                                if (cursor_y==8) cursor_x-=4;
                                else cursor_x--;
                        }

                        else if (ch==APPLE_RIGHT) { // right
                                if (cursor_y==8) cursor_x+=4;
                                cursor_x++;
                        }

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

                        if (name_x>7) name_x=7;

                        if (cursor_x<0) {
                                cursor_x=7;
                                cursor_y--;
                        }
                        if (cursor_x>7) {
                                cursor_x=0;
                                cursor_y++;
                        }

                        if (cursor_y<0) cursor_y=8;
                        if (cursor_y>8) cursor_y=0;

                        if ((cursor_y==8) && (cursor_x<4)) cursor_x=0;
                        else if ((cursor_y==8) && (cursor_x>=4)) cursor_x=4;


			if (ch!=0) break;

                        grsim_update();

                        usleep(10000);
                }

                if (ch==27) break;

.endif

	jsr	page_flip

	jmp	name_loop

done_enter_name:

	rts


enter_name_string:
        .byte 0,0,"PLEASE ENTER A NAME:",0

