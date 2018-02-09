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
	sta	XPOS

	lda	#1
	sta	MB_FRAME_DIFF
	sta	MB_FRAME_DIFF2

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

	lda	#<ksp_theme2
	sta	INL
	lda	#>ksp_theme2
	sta	INH

	lda	(INL),Y		; read in frame delay
	sta	MB_FRAME_DIFF
	inc	INL		; FIXME: should check if we oflowed


	lda	#<ksp_theme2
	sta	NUM1L
	lda	#>ksp_theme2
	sta	NUM1H

	lda	(NUM1L),Y	; read in frame delay
	sta	MB_FRAME_DIFF2
	inc	NUM1L		; FIXME: should check if we oflowed


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


	bit	SET_GR			; graphics mode
	bit	HIRES			; hires mode
	bit	TEXTGR			; mixed text/graphics
	bit	PAGE0			; first graphics page

	;==========================
	; Graphics
	;==========================
uncompress_graphics:
	jsr	lzss_init		; init R to zero



	;==========================
	;==========================
	; Loading Sequence
	;==========================
	;==========================
	jsr	clear_bottom

	;==========================
	; Squad Logo
	;==========================

	lda	#>squad_logo		; load logo pointer
        sta	BASH
        lda	#<squad_logo
        sta	BASL

	lda	#>squad_logo_end	; load logo end pointer
        sta	LZSS_ENDH
        lda	#<squad_logo_end
        sta	LZSS_ENDL

	; HGR page 2
	lda	#>$2000
	sta	OUTH
	lda	#<$2000
	sta	OUTL

	jsr	lzss_decompress

	lda	#<load_quotes
	sta	NAMEL
	lda	#>load_quotes
	sta	NAMEH

	lda	#$54		; HTAB 4 : VTAB 21
	sta	OUTL
	lda	#$6
	sta	OUTH

	ldy	#31
	lda	#('.'+$80)		; '.'
dot_loop:
	sta	(OUTL),Y
	dey
	bpl	dot_loop

	ldx	#$0
progress_bar_loop:
	ldy	#$0
	lda	#$6
	sta	OUTH
	clc
	txa
	adc	#$54			; HTAB 4 : VTAB 21
	sta	OUTL
	lda	#' '			; inverse space
	sta	(OUTL),Y

	; Halfway, change logo

	cpx	#16
	bne	no_change_logo

	txa
	pha

	jsr	lzss_init		; init R to zero

	lda	#>loading_logo			; load logo pointer
        sta	BASH
        lda	#<loading_logo
        sta	BASL

	lda	#>loading_logo_end		; load logo end pointer
        sta	LZSS_ENDH
        lda	#<loading_logo_end
        sta	LZSS_ENDL

	; HGR page 2
	lda	#>$2000
	sta	OUTH
	lda	#<$2000
	sta	OUTL

	jsr	lzss_decompress

	pla
	tax

no_change_logo:

	; Update message

	txa
	and	#$3
	bne	no_quotes

	; clear line

	lda	#$D0		; VTAB 22
	sta	OUTL
	lda	#$6
	sta	OUTH

	ldy	#40
	lda	#(' '+$80)		; ' '
clear_line:
	sta	(OUTL),Y
	dey
	bpl	clear_line


	ldy	#0
	lda	(NAMEL),Y
	adc	#$CE			; -1 because we inc Y once
					; and another because HTAB starts at 1
	sta	OUTL
	iny
print_quote_loop:
	lda	(NAMEL),Y
	beq	done_quote
	ora	#$80			; make non-inverse
	sta	(OUTL),Y
	iny
	jmp	print_quote_loop
done_quote:
	iny
	clc
	tya
	adc	NAMEL
	sta	NAMEL
	lda	#0
	adc	NAMEH
	sta	NAMEH

no_quotes:
	lda	#$f0
	jsr	WAIT
	lda	#$f0
	jsr	WAIT
	lda	#$f0
	jsr	WAIT
	lda	#$f0
	jsr	WAIT

	inx
	cpx	#32
	bpl	done_progress_bar
	jmp	progress_bar_loop
done_progress_bar:
	jsr	clear_bottom


	lda	#>ksp_title		; load logo pointer
        sta	BASH
        lda	#<ksp_title
        sta	BASL

	lda	#>ksp_title_end		; load logo end pointer
        sta	LZSS_ENDH
        lda	#<ksp_title_end
        sta	LZSS_ENDL

	; HGR page 2
	lda	#>$2000
	sta	OUTH
	lda	#<$2000
	sta	OUTL

	jsr	lzss_decompress

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
	txa
	pha
	tya
	pha
				; Should we save X and Y too?

	bit	$C404		; can clear 6522 interrupt by reading T1C-L

;	inc	$0401		; DEBUG: increment text char

;	jsr	interrupt_handle_right
;	jsr	interrupt_handle_left




interrupt_handle_right:
	dec	MB_FRAME_DIFF
	bne	done_right_interrupt

	ldy	#0
bottom_regs_right:
	lda	(INL),Y			; load low reg bitmask
	sta	MASK
	ldx	#$ff			; init to -1
bottom_regs_right_loop:
	inx				; increment X
	cpx	#$8			; if we reach 8, done
	beq	top_regs_right		; move on to top
	ror	MASK
	bcc	bottom_regs_right_loop	; if bit not set in mask, skip reg

	stx	XX			; save X

	iny				; get next output value
	lda	(INL),Y			; read in value

	sty	YY			; save Y

	tax				; value in X
	ldy	XX			; register# in Y

	; reg in Y, value in X
	jsr	write_ay_right		; so write same to both left/write

	ldx	XX			; restore X
	ldy	YY			; restore Y

	jmp	bottom_regs_right_loop	; loop

top_regs_right:
	iny				; point to next value
	lda	(INL),Y			; load top reg bitmask
	sta	MASK
	ldx	#$7			; load X as 7 (we increment first)
top_regs_right_loop:
	inx				; increment
	cpx	#16
	beq	done_with_masks_right	; exit if done
	ror	MASK
	bcc	top_regs_right_loop	; loop if not set

	stx	XX			; save X value

	iny				; point to value
	lda	(INL),Y			; read in output value

	sty	YY			; save Y value

	tax				; value in X
	ldy	XX			; register in Y

	; reg in Y, value in X
	jsr	write_ay_right		; so write same to both left/write

	ldx	XX
	ldy	YY

	jmp	top_regs_right_loop

done_with_masks_right:
	iny
	lda	(INL),Y			; read in frame delay
	cmp	#$ff			; see if end
	bne	not_done_right		; if so, done
	inc	DONE_PLAYING		; set done playing flag
	jmp	done_right_interrupt
not_done_right:
	sta	MB_FRAME_DIFF

	iny
	clc
	tya
	adc	INL
	sta	INL
	lda	#0
	adc	INH
	sta	INH

done_right_interrupt:
;	rts



	;=============
	; Left
	;=============

interrupt_handle_left:
	dec	MB_FRAME_DIFF2
	bne	done_left_interrupt

	ldy	#0
bottom_regs_left:
	lda	(NUM1L),Y		; load low reg bitmask
	sta	MASK
	ldx	#$ff			; init to -1
bottom_regs_left_loop:
	inx				; increment X
	cpx	#$8			; if we reach 8, done
	beq	top_regs_left		; move on to top
	ror	MASK
	bcc	bottom_regs_left_loop	; if bit not set in mask, skip reg

	stx	XX			; save X

	iny				; get next output value
	lda	(NUM1L),Y		; read in value

	sty	YY			; save Y

	tax				; value in X
	ldy	XX			; register# in Y

	; reg in Y, value in X
	jsr	write_ay_left		; assume 3 channel (not six)

	ldx	XX			; restore X
	ldy	YY			; restore Y

	jmp	bottom_regs_left_loop	; loop

top_regs_left:
	iny				; point to next value
	lda	(NUM1L),Y			; load top reg bitmask
	sta	MASK
	ldx	#$7			; load X as 7 (we increment first)
top_regs_left_loop:
	inx				; increment
	cpx	#16
	beq	done_with_masks_left	; exit if done
	ror	MASK
	bcc	top_regs_left_loop	; loop if not set

	stx	XX			; save X value

	iny				; point to value
	lda	(NUM1L),Y		; read in output value

	sty	YY			; save Y value

	tax				; value in X
	ldy	XX			; register in Y

	; reg in Y, value in X
	jsr	write_ay_left		; assume 3 channel (not six)

	ldx	XX
	ldy	YY

	jmp	top_regs_left_loop

done_with_masks_left:
	iny
	lda	(NUM1L),Y		; read in frame delay
	cmp	#$ff			; see if end
	bne	not_done_left		; if so, done
	inc	DONE_PLAYING		; set done playing flag
	jmp	done_left_interrupt
not_done_left:
	sta	MB_FRAME_DIFF2

	iny
	clc
	tya
	adc	NUM1L
	sta	NUM1L
	lda	#0
	adc	NUM1H
	sta	NUM1H

done_left_interrupt:
;	rts

done_interrupt:
	pla
	tay
	pla
	tax
	pla
	rti






;=========
;routines
;=========
.include	"../asm_routines/gr_offsets.s"
.include	"../asm_routines/text_print.s"
.include	"../asm_routines/mockingboard.s"
.include	"../asm_routines/lzss_decompress.s"
.include	"../asm_routines/gr_fast_clear.s"

;=======
; music
;=======
.include	"ksp_theme_compressed.inc"
.include	"ksp_theme2_compressed.inc"



;=========
; strings
;=========
mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4"
not_message:		.byte   "NOT "
found_message:		.asciiz "FOUND"
done_message:		.asciiz "DONE PLAYING"

load_quotes:
.byte	10
.asciiz	"Adding Extraneous Ks"
.byte 14
.asciiz "Locating Jeb"
.byte 11
.asciiz "Breaking Quicksaves"
.byte 12
.asciiz "Patching Conics"
.byte 12
.asciiz "Spinning up Duna"
.byte 11
.asciiz "Warming up the 6502"
.byte 10
.asciiz "Preparing Explosions"
.byte 10
.asciiz "Unleashing the Kraken"


;=============
; Grahpics
; Must be at end as get over-written
;=============

.include	"ksp_title.inc"
.include	"ksp_squad.inc"
.include	"ksp_loading.inc"

