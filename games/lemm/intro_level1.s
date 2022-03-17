
	;=====================================
	; print the intro message for level1
	;=====================================

intro_level:

	; clear text screen

	jsr	clear_all


level_preview_l_smc:
	lda	#$DD
	sta	getsrc_smc+1	    ; LZSA_SRC_LO
level_preview_h_smc:
	lda	#$DD
	sta	getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast


;	bit	SET_TEXT

	; print non-inverse

	jsr	set_normal

	; print messages

	lda	WHICH_LEVEL
	cmp	#1
	bne	its_level_5_text

its_level_1_text:
	lda	#<level1_intro_text
	sta	OUTL
	lda	#>level1_intro_text
	jmp	its_level_1_text_done

its_level_5_text:
	lda	#<level5_intro_text
	sta	OUTL
	lda	#>level5_intro_text

its_level_1_text_done:
	sta	OUTH

	; print the text

	ldx	#8
text_loop:

	jsr	move_and_print

	dex
	bne	text_loop

	bit	KEYRESET

	lda	APPLEII_MODEL
	cmp	#'E'
	bne	intro_not_iie

	jmp	split_screen_iie

intro_not_iie:
	; wait until keypress

	jsr	wait_until_keypress

	rts


	;=====================================
	; print the outro message for level1
	;=====================================

outro_level1:

	; clear text screen

	jsr	clear_all

	; set text

	bit	SET_TEXT

	; print non-inverse

	jsr	set_normal


	lda	LEVEL_OVER
	cmp	#LEVEL_WIN
	bne	print_l1_lose_message

	; print messages

	lda	#<level1_win_text
	sta	OUTL
	lda	#>level1_win_text
	jmp	print_l1_common
print_l1_lose_message:
	lda	#<level1_lose_text
	sta	OUTL
	lda	#>level1_lose_text

print_l1_common:
	sta	OUTH

	; print the text

	ldx	#9
l1_outro_loop:

	jsr	move_and_print

	dex
	bne	l1_outro_loop

	bit	KEYRESET

	; wait until keypress

	jmp	wait_until_keypress



level1_intro_text:
.byte  0, 8,"LEVEL 1",0
.byte 15, 8,"JUST DIG!",0
.byte  9,12,"NUMBER OF LEMMINGS 10",0
.byte 12,14,"10%  TO BE SAVED",0
.byte 12,16,"RELEASE RATE 50",0
.byte 13,18,"TIME 5 MINUTES",0
.byte 15,20,"RATING FUN",0
.byte  8,23,"PRESS RETURN TO CONINUE",0

level1_win_text:
.byte  6, 1,"ALL LEMMINGS ACCOUNTED FOR.",0
.byte 12, 3,"YOU RESCUED 100%",0
.byte 12, 4,"YOU NEEDED   10%",0
.byte  2, 6,"SUPERB! YOU RESCUED EVERY LEMMING ON",0
.byte  3, 7,"THAT LEVEL. CAN YOU DO IT AGAIN...",0
.byte  6,15,"YOUR ACCESS CODE FOR LEVEL 2",0
.byte 14,16,"IS B002ATARI",0
.byte  6,20,"PRESS RETURN FOR NEXT LEVEL",0
.byte  9,21,"PRESS ESCAPE FOR MENU",0

level1_lose_text:
.byte  6, 1,"ALL LEMMINGS ACCOUNTED FOR.",0
.byte 12, 3,"YOU RESCUED   0%",0
.byte 12, 4,"YOU NEEDED  100%",0
.byte  3, 6,"ROCK BOTTOM! I HOPE FOR YOUR SAKE",0
.byte  8, 7,"THAT YOU NUKED THAT LEVEL.",0
.byte  6,20,"PRESS RETURN FOR NEXT LEVEL",0
.byte  9,21,"PRESS ESCAPE FOR MENU",0
.byte 10,10," ",0	; lazy hack
.byte 10,10," ",0

level5_intro_text:
.byte  0, 8,"LEVEL 5",0
.byte 14, 8,"YOU NEED BASHERS THIS TIME",0
.byte  9,12,"NUMBER OF LEMMINGS 50",0
.byte 12,14,"10%  TO BE SAVED",0
.byte 12,16,"RELEASE RATE 50",0
.byte 13,18,"TIME 5 MINUTES",0
.byte 15,20,"RATING FUN",0
.byte  8,23,"PRESS RETURN TO CONINUE",0


.align $100

; split screen?

split_screen_iie:

	; wait for vblank on IIe
	; positive? during vblank

;	bit	SET_GR		; 4
;	bit	HIRES		; 4
;	bit	FULLGR

wait_vblank_iie:
	lda	VBLANK
	bmi	wait_vblank_iie		; wait for positive (in vblank)
wait_vblank_done_iie:
	lda	VBLANK			; wait for negative (vlank done)
	bpl	wait_vblank_done_iie

	;
split_loop:
	;===========================
	; hires for 64 lines
	;	each line 65 cycles (25 hblank+40 bytes)


	; (64*65)-8 = 4160-8 = 4152

	; Try X=91 Y=9 cycles=4150

	nop	; delay two more

	ldy	#9							; 2
loop1:	ldx	#91							; 2
loop2:	dex								; 2
	bne	loop2							; 2nt/3
	dey								; 2
	bne	loop1							; 2nt/3


	; text for 128 lines + horizontal blank
	; vblank = 4550 cycles


	bit	LORES		; 4
	bit	SET_TEXT	; 4

	; (128*65)+4550-15 = 8320+4550-15 = 12855

	; ZZZZ 8305

	; Try X=68 Y=24 cycles=8305

	ldy	#24							; 2
loop13:	ldx	#68							; 2
loop14:	dex								; 2
	bne	loop14							; 2nt/3
	dey								; 2
	bne	loop13							; 2nt/3


	bit	SET_GR		; 4
	bit	HIRES		; 4

	; don't really need to split this up?  Was trying
	; to get retrotink to display properly instead of black/white

	; Try X=150 Y=17 cycles=12853

	; ZZZZ 4550

	; Try X=13 Y=64 cycles=4545

	nop		; 2
	lda	$0	; 3

	ldy	#64							; 2
loop3:	ldx	#13							; 2
loop4:	dex								; 2
	bne	loop4							; 2nt/3
	dey								; 2
	bne	loop3							; 2nt/3


	lda	KEYPRESS	; 4
	bpl	split_loop	; 2nt/3t


	rts


