
	;==========================================================
	; Wait until keypressed
	;==========================================================
	;

wait_until_keypressed:
	inc	RANDOM_PTR			; randomize things a bit
	lda	KEYPRESS			; check if keypressed
	bpl	wait_until_keypressed		; if not, loop
	jmp     figure_out_key


	;==========================================================
	; Get Key
	;==========================================================
	;

get_key:

check_paddle_button:

	; check for paddle button

	bit	PADDLE_BUTTON0						; 4
	bpl	no_button						; 2nt/3
	lda	#' '+128						; 2
	jmp	save_key						; 3

no_button:
	lda	KEYPRESS						; 3
	bpl	no_key							; 2nt/3

figure_out_key:
	cmp	#' '+128		; the mask destroys space	; 2
	beq	save_key		; so handle it specially	; 2nt/3

	and	#$5f			; mask, to make upper-case	; 2
check_right_arrow:
	cmp	#$15							; 2
	bne	check_left_arrow					; 2nt/3
	lda	#'D'							; 2
check_left_arrow:
	cmp	#$08							; 2
	bne	check_up_arrow						; 2nt/3
	lda	#'A'							; 2
check_up_arrow:
	cmp	#$0B							; 2
	bne	check_down_arrow					; 2nt/3
	lda	#'W'							; 2
check_down_arrow:
	cmp	#$0A							; 2
	bne	check_escape						; 2nt/3
	lda	#'S'							; 2
check_escape:
        cmp	#$1B							; 2
	bne	save_key						; 2nt/3
	lda	#'Q'							; 2
	jmp	save_key						; 3

no_key:
	bit	PADDLE_STATUS						; 3
	bpl	no_key_store						; 2nt/3

	; check for paddle action
	; code from http://web.pdx.edu/~heiss/technotes/aiie/tn.aiie.06.html

	inc	PADDLE_STATUS						; 5
	lda	PADDLE_STATUS						; 3
	and	#$03							; 2
	beq	check_paddles						; 2nt/3
	jmp	no_key_store						; 3

check_paddles:
	lda	PADDLE_STATUS						; 3
	and	#$80							; 2
	sta	PADDLE_STATUS						; 3

	ldx	#$0							; 2
	LDA	PTRIG		;TRIGGER PADDLES			; 4
	LDY	#0		;INIT COUNTER				; 2
	NOP			;COMPENSATE FOR 1ST COUNT		; 2
	NOP								; 2
PREAD2:	LDA	PADDL0,X	;COUNT EVERY 11 uSEC.			; 4
	BPL	RTS2D		;BRANCH WHEN TIMED OUT			; 2nt/3
	INY			;INCREMENT COUNTER			; 2
	BNE	PREAD2		;CONTINUE COUNTING			; 2nt/3
	DEY			;COUNTER OVERFLOWED			; 2
RTS2D:				;RETURN W/VALUE 0-255

        cpy	#96							; 2
        bmi	paddle_left						; 2nt/3
	cpy	#160							; 2
	bmi	no_key_store						; 2nt/3
	lda	#'D'							; 2
	jmp	save_key						; 3
paddle_left:
	lda	#'A'							; 2
	jmp	save_key						; 3

no_key_store:
	lda	#0			; no key, so save a zero	; 2

save_key:
	sta	LASTKEY			; save the key to our buffer	; 2
	bit	KEYRESET		; clear the keyboard buffer	; 4
	rts								; 6
								;============
								; 33=nokey
								; 48=worstkey


