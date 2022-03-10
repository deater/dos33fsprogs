
	;=====================================
	; print the intro message for level1
	;=====================================

intro_level1:

	lda	#<level1_preview_lzsa
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>level1_preview_lzsa
	sta	getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast


	; clear text screen

	jsr	clear_all

	; print non-inverse

	jsr	set_normal

	; print messages

	lda	#<level1_intro_text
	sta	OUTL
	lda	#>level1_intro_text
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

level1_intro_text:
.byte  0, 8,"LEVEL 1",0
.byte 15, 8,"JUST DIG!",0
.byte  9,12,"NUMBER OF LEMMINGS 10",0
.byte 12,14,"10%  TO BE SAVED",0
.byte 12,16,"RELEASE RATE 50",0
.byte 13,18,"TIME 5 MINUTES",0
.byte 15,20,"RATING FUN",0
.byte  8,23,"PRESS RETURN TO CONINUE",0

.byte  0, 8,"LEVEL 5",0
.byte 15, 8,"YOU NEED BASHERS THIS TIME",0
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

	bit	HIRES		; 4
	bit	SET_GR		; 4

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

	; (128*65)+4550-15 = 8320+4550-15 = 12855

	bit	LORES		; 4
	bit	SET_TEXT	; 4

	; Try X=150 Y=17 cycles=12853

	nop		; 2

	ldy	#17							; 2
loop3:	ldx	#150							; 2
loop4:	dex								; 2
	bne	loop4							; 2nt/3
	dey								; 2
	bne	loop3							; 2nt/3

	lda	KEYPRESS	; 4
	bpl	split_loop	; 2nt/3t


	rts


