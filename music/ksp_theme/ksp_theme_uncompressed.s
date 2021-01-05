; Play the KSP theme, but uncompressed (so pretty huge and slow to load)

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

	ldx	#0
frame_loop:
	ldy	#0
play_loop:
	lda	(INL),Y
	tax
	jsr	write_ay_left	; assume 3 channel (not six)
	jsr	write_ay_right	; so write same to both left/write

	iny
	cpy	#13
	bne	play_loop

	; special case, if reg 13 = ff don't write it

	lda	(INL),Y
	cmp	#$ff
	beq	was_ff

	jsr	write_ay_left	; assume 3 channel (not six)
	jsr	write_ay_right	; so write same to both left/write

was_ff:
	; see if at end
	iny
	iny
	lda	(INL),Y
	cmp	#$ff
	beq	done_play

	; increment INL:INH by 13

	clc
	lda	INL
	adc	#14
	sta	INL

	lda	INH
	adc	#0
	sta	INH


delay_a_bit:

	lda	#86
	jsr	WAIT			; delay 1/2(26+27A+5A^2) us
					; 50Hz = 20ms = 20000us
					; 40000 = 26+27A+5A^2
					; 5a^2+27a-39974 = 0
					; A = 86.75

	jmp	frame_loop
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
.include	"../../asm_routines/gr_offsets.s"
.include	"../../asm_routines/text_print.s"
.include	"../../asm_routines/mockingboard.s"

;=======
; music
;=======
.include	"ksptheme_uncompressed.inc"

;=========
; strings
;=========
mocking_message:	.asciiz "ASSUMING MOCKINGBOARD IN SLOT #4"
done_message:		.asciiz "DONE PLAYING"
