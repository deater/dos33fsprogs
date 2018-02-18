; VMW Chiptune Player

.include	"zp.inc"

CHUNK_BUFFER	EQU	$6000

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
	sta	XPOS

	lda	#0
	sta	MB_FRAME_DIFF

	lda	#<mocking_message		; load loading message
	sta	OUTL
	lda	#>mocking_message
	sta	OUTH
	jsr	move_and_print			; print it

	jsr	mockingboard_detect_slot4	; call detection routine
	cpx	#$1
	beq	mockingboard_found

	lda	#<not_message			; if not found, print that
	sta	OUTL
	lda	#>not_message
	sta	OUTH
	inc	CV
	jsr	move_and_print

	jmp	forever_loop			; and wait forever

mockingboard_found:
	lda     #<found_message			; print found message
	sta     OUTL
	lda     #>found_message
	sta     OUTH
	inc     CV
	jsr     move_and_print

	;============================
	; Init the Mockingboard
	;============================

	jsr	mockingboard_init
	jsr	reset_ay_both
	jsr	clear_ay_both


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
	; Setup Graphics
	;============================

	jsr	set_gr_page0

	lda	#$4
	sta	DRAW_PAGE

	jsr	clear_screens

	lda	#<chip_title
	sta	GBASL
	lda	#>chip_title
	sta	GBASH

	; Load image
	lda	#<$400
	sta	BASL
	lda	#>$400
	sta	BASH

	jsr	load_rle_gr

	;===========================
	; init pointer to the music
	;===========================

	jsr	read_file

	lda	#>CHUNK_BUFFER
	sta	INH
	lda	#<CHUNK_BUFFER
	sta	INL
	lda	#$0
	sta	MB_CHUNK


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

	jsr	clear_ay_both

	lda	#0
	sta	CH
	lda	#21
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

	inc	$0404		; debug

	bit	$C404		; can clear 6522 interrupt by reading T1C-L

	ldy	MB_FRAME_DIFF

	ldx	#0

mb_write_loop:
	lda	(INL),y
	cpx	#13
	bne	mb_not_13
	cmp	#$ff
	beq	skip_r13

mb_not_13:
	sta	MB_VALUE
					; INLINE?
	jsr	write_ay_both		; assume 3 channel (not six)
					; so write same to both left/write
	clc
	lda	INH
	adc	#$4
	sta	INH

	inx
	cpx	#14
	bmi	mb_write_loop

skip_r13:
	lda	MB_CHUNK
	clc
	adc	#>CHUNK_BUFFER
	sta	INH

	inc	MB_FRAME_DIFF
	bne	done_interrupt
wraparound:

	inc	MB_CHUNK
	lda	MB_CHUNK
	cmp	#$4
	bne	chunk_good
	lda	#0
	sta	MB_CHUNK
chunk_good:

done_interrupt:
	pla
	rti





;=========
;routines
;=========
.include	"../asm_routines/gr_offsets.s"
.include	"../asm_routines/text_print.s"
.include	"../asm_routines/mockingboard_a.s"
;.include	"../asm_routines/lzss_decompress.s"
.include	"../asm_routines/gr_fast_clear.s"
.include	"../asm_routines/pageflip.s"
.include	"../asm_routines/gr_unrle.s"
.include	"../asm_routines/gr_setpage.s"
.include	"../asm_routines/dos33_routines.s"

;=======
; music
;=======
;.include	"ksp_theme_compressed.inc"


;=========
; strings
;=========
mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4"
not_message:		.byte   "NOT "
found_message:		.asciiz "FOUND"
done_message:		.asciiz "DONE PLAYING"

;============
; graphics
;============
.include "chip_title.inc"
