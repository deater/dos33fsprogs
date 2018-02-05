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
	lda     #<found_message
	sta     OUTL
	lda     #>found_message
	sta     OUTH
	inc     CV
	jsr     move_and_print

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

new_frame:
	ldy	#0
	lda	(INL),Y		; read in frame delay
	cmp	#$ff		; see if end
	beq	done_play	; if so, done

	tax
old_frame:
	dex			; decrement the frame diff
	beq	bottom_regs	; if not there yet, delay
	jsr	delay_50Hz
	jmp	old_frame

bottom_regs:
	iny
	lda	(INL),Y			; load low reg bitmask
	sta	MASK
	ldx	#$ff			; init to -1
bottom_regs_loop:
	inx				; increment X
	cpx	#$8			; if we reach 8, done
	beq	top_regs		; move on to top

	ror	MASK
	bcc	bottom_regs_loop	; if bit not set in mask, skip reg

	stx	XX			; save X

	iny				; get next output value
	lda	(INL),Y			; read in value

	sty	YY			; save Y

	tax				; value in X
	ldy	XX			; register# in Y

	; reg in Y, value in X
	jsr	write_ay_left		; assume 3 channel (not six)
	jsr	write_ay_right		; so write same to both left/write

	ldx	XX			; restore X
	ldy	YY			; restore Y

	jmp	bottom_regs_loop	; loop

top_regs:
	iny				; point to next value
	lda	(INL),Y			; load top reg bitmask
	sta	MASK
	ldx	#$7			; load X as 7 (we increment first)
top_regs_loop:
	inx				; increment
	cpx	#$16
	beq	done_with_masks		; exit if done

	ror	MASK
	bcc	top_regs_loop		; loop if not set

	stx	XX			; save X value

	iny				; point to value
	lda	(INL),Y			; read in output value

	sty	YY			; save Y value

	tax				; value in X
	ldy	XX			; register in Y

	; reg in Y, value in X
	jsr	write_ay_left		; assume 3 channel (not six)
	jsr	write_ay_right		; so write same to both left/write

	ldx	XX
	ldy	YY

	jmp	top_regs_loop

done_with_masks:
	iny
	clc
	tya
	adc	INL
	sta	INL
	lda	#0
	adc	INH
	sta	INH

	jsr	delay_50Hz

	jmp	new_frame

done_play:

	jsr	clear_ay_left
	jsr	clear_ay_right

	lda	#0
	sta	CH
	lda	#3
	sta	CV
	lda	#<done_message
	sta	OUTL
	lda	#>done_message
	sta	OUTH
	jsr	move_and_print


forever_loop:
	jmp	forever_loop



delay_50Hz:

	lda	#86
	jsr	WAIT			; delay 1/2(26+27A+5A^2) us
					; 50Hz = 20ms = 20000us
					; 40000 = 26+27A+5A^2
					; 5a^2+27a-39974 = 0
					; A = 86.75
	rts


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
mocking_message:	.asciiz "ASSUMING MOCKINGBOARD IN SLOT #4"
not_message:		.byte   "NOT "
found_message:		.asciiz "FOUND"
done_message:		.asciiz "DONE PLAYING"
