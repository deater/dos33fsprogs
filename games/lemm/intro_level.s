
	;========================
	; print the intro message
	;========================

intro_level:

	; clear text screen

	jsr	clear_all


level_preview_l_smc:
	lda	#$DD
	sta	getsrc_smc+1	; LZSA_SRC_LO
level_preview_h_smc:
	lda	#$DD
	sta	getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

	; print non-inverse

	jsr	set_normal

	; print messages

intro_text_smc_l:
	lda	#$dd
	sta	OUTL
intro_text_smc_h:
	lda	#$dd
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


	;========================
	;========================
	; print the outro message
	;========================
	;========================

outro_level:

	; clear text screen

	jsr	clear_all

	; set text

	bit	SET_TEXT

	; print non-inverse

	jsr	set_normal

	; assume lose at first, may change later
	lda	#LEVEL_FAIL
	sta	LEVEL_OVER

	;======================================
	; update percentages in message
	;======================================

	;=================
	; needed


	ldx	#' '			; default is blank

	lda	PERCENT_NEEDED
	bne	upm_not_100		; zero specical case means 100%

	ldx	#'1'

upm_not_100:
	stx	needed_smc+14


	; needed tens

	lsr
	lsr
	lsr
	lsr
	clc
	adc	#'0'
	sta	needed_smc+15

	; needed ones

	lda	PERCENT_NEEDED
	and	#$f
	clc
	adc	#'0'
	sta	needed_smc+16


	;=================
	; rescued


	ldx	#' '			; default is blank

	lda	PERCENT_RESCUED_H
	beq	upr_not_100		;

	ldx	#'1'

upr_not_100:
	stx	rescued_smc+14

	cmp	#1		; if 100% then print 0
	beq	always_tens

	; rescued tens
	lda	#' '
	ldx	PERCENT_RESCUED_L
	cpx	#$10
	bcc	upr_out_tens

always_tens:
	txa
	lsr
	lsr
	lsr
	lsr
	clc
	adc	#'0'
upr_out_tens:
	sta	rescued_smc+15

	; needed ones

	lda	PERCENT_RESCUED_L
	and	#$f
	clc
	adc	#'0'
	sta	rescued_smc+16


	;======================
	; print common message

	lda	#<level_common_text
	sta	OUTL
	lda	#>level_common_text
	sta	OUTH
	jsr	move_and_print_list


	;======================
	; figure out message
	;======================

	ldx	#0			; first message

	lda	PERCENT_RESCUED_H
	bne	print_the_message	; 100%, was a win

blip:
	inx				; (1) NEEDED+20% < T < 100%
	lda	PERCENT_NEEDED
	clc
	adc	#$20			; FIXME: only if < 80%
	cmp	PERCENT_RESCUED_L
	bcs	print_the_message

	inx				; (2) NEEDED < T < NEEDED+20%
	lda	PERCENT_RESCUED_L
	cmp	PERCENT_NEEDED
	bcc	print_the_message

	inx				; (3) NEEDED == T
	cmp	PERCENT_NEEDED
	beq	print_the_message

	inx				; (4) T = NEEDED - 1
	lda	PERCENT_RESCUED_L
	sec
	sbc	#1
	cmp	PERCENT_NEEDED
	beq	print_the_message

	inx				; (5) NEEDED-5 < T < NEEDED - 1
	lda	PERCENT_RESCUED_L
	sec
	sbc	#5
	cmp	PERCENT_NEEDED
	bcs	print_the_message

	inx				; (6) NEEDED/2 < T < NEEDED-5
	lda	PERCENT_RESCUED_L
	lsr
	cmp	PERCENT_NEEDED
	bcs	print_the_message


	inx				; (7) T < NEEDED/2


print_the_message:
	lda	level_end_messages_l,X
	sta	OUTL
	lda	level_end_messages_h,X
	sta	OUTH
	jsr	move_and_print_list

	cpx	#4
	bcc	was_a_win

was_a_loss:
	jmp	done_print_message

	;=================================
	; print win message if applicable
	;=================================
was_a_win:
	lda	#LEVEL_WIN
	sta	LEVEL_OVER

	; update level in message

	ldx	WHICH_LEVEL
	inx
	txa
	clc
	adc	#'0'
	sta	level_win_text+29


	lda	#<level_win_text
	sta	OUTL
	lda	#>level_win_text
	sta	OUTH
	jsr	move_and_print_list

done_print_message:


	bit	KEYRESET

	; wait until keypress

	jmp	wait_until_keypress

level_common_text:
.byte  6, 1,"ALL LEMMINGS ACCOUNTED FOR.",0
rescued_smc:
.byte 12, 3,"YOU RESCUED    %",0
needed_smc:
.byte 12, 4,"YOU NEEDED     %",0
.byte  6,20,"PRESS RETURN FOR NEXT LEVEL",0
.byte  9,21,"PRESS ESCAPE FOR MENU",0
.byte  $FF

level_win_text:
.byte  6,15,"YOUR ACCESS CODE FOR LEVEL X",0
.byte 14,16,"IS B002ATARI",0
.byte  $FF

; T = 100%
level_message0_text:
.byte  2, 6,"SUPERB! YOU RESCUED EVERY LEMMING ON",0
.byte  3, 7,"THAT LEVEL. CAN YOU DO IT AGAIN...",0
.byte  $FF

; NEEDED+20% < T < 100%
level_message1_text:
.byte  2, 6,"YOU TOTALLY STORMED THAT LEVEL!",0
.byte  3, 7,"LET'S SEE IF YOU CAN STORM THE NEXT...",0
.byte  $FF

; NEEDED < T < NEEDED+20%
level_message2_text:
.byte  2, 6,"THAT LEVEL SEEMED NO PROBLEM TO YOU ON",0
.byte  3, 7,"THAT ATTEMPT. ONTO THE NEXT...",0
.byte  $FF

; NEEDED == T
level_message3_text:
.byte  2, 6,"RIGHT ON. YOU CAN'T GET MUCH CLOSER THAN",0
.byte  3, 7,"THAT. LET'S TRY THE NEXT...",0
.byte  $FF

; T = NEEDED - 1
level_message4_text:
.byte  2, 6,"OH NO, SO NEAR AND YET SO FAR.",0
.byte  3, 7,"MAYBE THIS TIME...",0
.byte  $FF

; NEEDED-5 < T < NEEDED - 1
level_message5_text:
.byte  2, 6,"YOU GOT PRETTY CLOSE THAT TIME.",0
.byte  3, 7,"NOW TRY AGAIN FOR THAT FEW % EXTRA.",0
.byte  $FF

; NEEDED/2 < T < NEEDED-5
level_message6_text:
.byte  2, 6,"BETTER RETHINK YOUR STRATEGY BEFORE",0
.byte  3, 7,"YOU TRY THIS LEVEL AGAIN!.",0
.byte  $FF

; T < NEEDED/2
level_message7_text:
.byte  3, 6,"ROCK BOTTOM! I HOPE FOR YOUR SAKE",0
.byte  8, 7,"THAT YOU NUKED THAT LEVEL.",0
.byte  $FF


level_end_messages_l:
.byte <level_message0_text,<level_message1_text,<level_message2_text
.byte <level_message3_text,<level_message4_text,<level_message5_text
.byte <level_message6_text,<level_message7_text

level_end_messages_h:
.byte >level_message0_text,>level_message1_text,>level_message2_text
.byte >level_message3_text,>level_message4_text,>level_message5_text
.byte >level_message6_text,>level_message7_text



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


