; Play the KSP theme, but compressed a bit (only write registers that change)
; Still 3-channel
; The KSP theme is fairly small, will need to compress more

.include	"zp.inc"

	;=============================
	; Print message
	;=============================
	jsr     HOME
	jsr     TEXT

	lda	#0
	sta	DRAW_PAGE
	sta	CH
	sta	CV
	lda	#<mocking_message
	sta	OUTL
	lda	#>mocking_message
	sta	OUTH
	jsr	move_and_print

	jsr	mockingboard_detect_slot4
	cpx	#$1
	beq	mockingboard_found

	lda	#<not_message
	sta	OUTL
	lda	#>not_message
	sta	OUTH
	inc	CV
	jsr	move_and_print

	jmp	forever_loop

mockingboard_found:

	lda	#<found_message
	sta	OUTL
	lda	#>found_message
	sta	OUTH
	inc	CV
	jsr	move_and_print


	;============================
	; Init the Mockingboard
	;============================

	jsr	mockingboard_init
	jsr	reset_ay_left
	jsr	reset_ay_right
	jsr	clear_ay_left
	jsr	clear_ay_right


	;===========================
	; load pointer to the music
	;===========================

	lda	#<ksptheme
	sta	INL
	lda	#>ksptheme
	sta	INH

	ldy	#0
new_frame:
	lda	(INL),Y		; read in frame delay
	cmp	#$ff		; see if end
	beq	done_play	; if so, done

	tax
old_frame:
	dex			; decrement the frame diff
	bpl	delay_a_bit	; if not there yet, delay

top_regs:
	iny
	lda	(INL),Y		; load low reg bitmask
	ldx	#$ff
top_regs_loop:
	inx
	cmp	#$8
	beq	bottom_regs
	ror
	bcc	top_regs_loop

	stx	XX
	sty	YY

	iny
	lda	(INL),Y		; read in value
	tax

	ldy	XX

	; reg in Y, value in X
	jsr	write_ay_left	; assume 3 channel (not six)
	jsr	write_ay_right	; so write same to both left/write

	ldx	XX
	ldy	YY

	jmp	top_regs_loop

bottom_regs:
	iny
	lda	(INL),Y		; load low reg bitmask
	ldx	#$ff
bottom_regs_loop:
	inx
	cmp	#$8
	beq	delay_a_bit
	ror
	bcc	bottom_regs_loop


	stx	XX
	sty	YY

	iny
	lda	(INL),Y		; read in value
	tax

	ldy	XX

	; reg in Y, value in X
	jsr	write_ay_left	; assume 3 channel (not six)
	jsr	write_ay_right	; so write same to both left/write

	ldx	XX
	ldy	YY

	jmp	bottom_regs_loop

	; reg in Y, value in X
	jsr	write_ay_left	; assume 3 channel (not six)
	jsr	write_ay_right	; so write same to both left/write

delay_a_bit:

	lda	#86
	jsr	WAIT			; delay 1/2(26+27A+5A^2) us
					; 50Hz = 20ms = 20000us
					; 40000 = 26+27A+5A^2
					; 5a^2+27a-39974 = 0
					; A = 86.75

	jmp	old_frame
done_play:

	jsr	clear_ay_left
	jsr	clear_ay_right


	lda	#0
	sta	CH
	lda	#2
	sta	CV
	lda	#<done_message
	sta	OUTL
	lda	#>done_message
	sta	OUTH
	jsr	move_and_print


forever_loop:
	jmp	forever_loop

;=========
;routines
;=========
.include	"../asm_routines/gr_offsets.s"
.include	"../asm_routines/text_print.s"
.include	"../asm_routines/mockingboard.s"

;=======
; music
;=======
.include	"ksp_theme_compressed.inc"

;=========
; strings
;=========
mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4: "
not_message:		.byte	"NOT "
found_message:		.asciiz "FOUND"
done_message:		.asciiz "DONE PLAYING"
