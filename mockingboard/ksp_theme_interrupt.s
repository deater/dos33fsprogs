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
	sta	DONE_PLAYING

	lda	#1
	sta	MB_FRAME_DIFF

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

	lda	(INL),Y		; read in frame delay
	sta	MB_FRAME_DIFF
	inc	INL		; FIXME: should check if we oflowed

	;=========================
	; Setup Interrupt Handler
	;=========================
	; Vector address goes to 0x3fe/0x3ff
	; FIXME: should chain any existing handler

	lda	#<interrupt_handler
	sta	$03fe
	lda	#>interrupt_handler
	sta	$03ff

	;============================
	; Enable 50Hz clock on 6522
	;============================

	lda	#$40		; Generate continuous interrupts, don't touch PB7
	sta	$C40B		; ACR register
	lda	#$7F		; clear all interrupt flags
	sta	$C40E		; IER register (interrupt enable)

	lda	#$C0
	sta	$C40D		; IFR: 1100, enable interrupt on timer one oflow
	sta	$C40E		; IER: 1100, enable timer one interrupt

	lda	#$E7
	sta	$C404		; write into low-order latch
	lda	#$4f
	sta	$C405		; write into high-order latch,
				; load both values into counter
				; clear interrupt and start counting

	; 4fe7 / 1e6 = .020s, 50Hz

	;============================
	; Enable 6502 interrupts
	;============================
	;
	cli		; clear interrupt mask


	;============================
	; Loop forever
	;============================
playing_loop:
	lda	DONE_PLAYING
	beq	playing_loop

done_play:

				; FIXME: disable timer on 6522
				; FIXME: unhook interrupt handler

	sei			; disable interrupts

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

	;=============================
	;=============================
	; simple interrupt handler
	;=============================
	;=============================
	; On Apple II/6502 the interrupt handler jumps to address in 0xfffe
	; This is in the ROM, which saves the registers
	;   on older IIe it saved A to $45 (which could mess with DISK II)
	;   newer IIe doesn't do that.
	; It then calculates if it is a BRK or not (which trashes A)
	; Then it sets up the stack like an interrupt and calls 0x3fe

interrupt_handler:
	pha			; save A
				; Should we save X and Y too?

	bit	$C404		; can clear 6522 interrupt by reading T1C-L

	inc	$0401		; DEBUG: increment text char

	dec	MB_FRAME_DIFF
	bne	done_interrupt




	ldy	#0
bottom_regs:
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
new_frame_diff:
	iny
	lda	(INL),Y		; read in frame delay
	cmp	#$ff		; see if end
	bne	not_done	; if so, done
	inc	DONE_PLAYING	; set done playing flag
	jmp	done_interrupt
not_done:
	sta	MB_FRAME_DIFF

	iny
	clc
	tya
	adc	INL
	sta	INL
	lda	#0
	adc	INH
	sta	INH

done_interrupt:
	pla
	rti





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
mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4"
not_message:		.byte   "NOT "
found_message:		.asciiz "FOUND"
done_message:		.asciiz "DONE PLAYING"
