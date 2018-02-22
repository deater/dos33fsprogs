; VMW Chiptune Player

.include	"zp.inc"

LZ4_BUFFER	EQU	$2000		; 16k for now, FIXME: expand
CHUNK_BUFFER	EQU	$6000		; 10.5k, $2A00
CHUNKSIZE	EQU	$3

	;=============================
	; Setup
	;=============================
	jsr     HOME
	jsr     TEXT

	; init variables

	lda	#0
	sta	DRAW_PAGE
	sta	CH
	sta	CV
	sta	DONE_PLAYING
	sta	XPOS
	sta	MB_FRAME_DIFF

	; print detection message

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
;	lda     #<found_message			; print found message
;	sta     OUTL
;	lda     #>found_message
;	sta     OUTH
;	inc     CV
;	jsr     move_and_print

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

	lda	#$40		; Continuous interrupts, don't touch PB7
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
	; Draw title screen
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
	; load first song
	;===========================

	jsr	new_song


	lda	#<CHUNK_BUFFER		; set input pointer
	sta	INL
	lda	#>CHUNK_BUFFER
	sta	INH


	;============================
	; Enable 6502 interrupts
	;============================

	cli		; clear interrupt mask


	;============================
	; Init Background
	;============================
;	jsr	clear_screens		; clear top/bottom of page 0/1
	jsr	set_gr_page0

	lda	#0
	sta	DRAW_PAGE
	sta	SCREEN_Y

	;============================
	; Loop forever
	;============================
playing_loop:


	;============================
	; rasters
	;============================

	jsr	clear_top

	jsr	draw_rasters

	jsr	volume_bars

	jsr	page_flip

	lda	DONE_PLAYING
	beq	playing_loop

done_play:

				; FIXME: disable timer on 6522
				; FIXME: unhook interrupt handler

	sei			; disable interrupts

	jsr	clear_ay_both

	lda	#0
	sta	CH

	jsr	clear_bottoms

	lda	#21
	sta	CV
	lda	#<done_message
	sta	OUTL
	lda	#>done_message
	sta	OUTH

	jsr	print_both_pages

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
;	tya
;	pha
;	txa
;	pha
				; Should we save X and Y too?

;	inc	$0404		; debug

	bit	$C404		; can clear 6522 interrupt by reading T1C-L

	;=====================
	; Update time counter
	;=====================

	inc	FRAME_COUNT
	lda	FRAME_COUNT
	cmp	#50
	bne	frame_good

	lda	#$0
	sta	FRAME_COUNT

update_second_ones:
	inc	$7d0+17
	inc	$bd0+17
	lda	$bd0+17
	cmp	#$ba			; one past '9'
	bne	frame_good
	lda	#'0'+$80
	sta	$7d0+17
	sta	$bd0+17
update_second_tens:
	inc	$7d0+16
	inc	$bd0+16
	lda	$bd0+16
	cmp	#$b6			; 6
	bne	frame_good
	lda	#'0'+$80
	sta	$7d0+16
	sta	$bd0+16
update_minutes:
	inc	$7d0+14
	inc	$bd0+14
					; we don't handle > 9:59 songs yet

frame_good:

	ldy	MB_FRAME_DIFF

	ldx	#0

mb_write_loop:
	lda	(INL),y

	cpx	#1
	bne	mb_not_one
	cmp	#$ff			; if ff, done song
	bne	mb_not_one

	lda	#1
	sta	DONE_PLAYING
	jmp	done_interrupt

mb_not_one:
	cpx	#13
	bne	mb_not_13
	cmp	#$ff
	beq	skip_r13

mb_not_13:
	sta	MB_VALUE

	cpx	#8
	bne	mb_not_8
	and	#$f
	sta	A_VOLUME
mb_not_8:
	cpx	#9
	bne	mb_not_9
	and	#$f
	sta	B_VOLUME
mb_not_9:
	cpx	#10
	bne	mb_not_10
	and	#$f
	sta	C_VOLUME
mb_not_10:
					; INLINE?
	jsr	write_ay_both		; assume 3 channel (not six)
					; so write same to both left/write
	clc
	lda	INH
	adc	#CHUNKSIZE
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
	cmp	#CHUNKSIZE
	bne	chunk_good
	lda	#0
	sta	MB_CHUNK

	jsr	next_subsong

chunk_good:

done_interrupt:
	pla
;	tax
;	pla
;	tay
;	pla
	rti


	;=================
	; load a new song
	;=================

new_song:

	;=========================
	; Init Variables
	;=========================

	lda	#$0
	sta	MB_CHUNK
	sta	FRAME_COUNT
	sta	A_VOLUME
	sta	B_VOLUME
	sta	C_VOLUME

	;===========================
	; Print loading message
	;===========================

	jsr	clear_bottoms		; clear bottom of page 0/1

	lda	#0			; print LOADING message
	sta	CH
	lda	#21
	sta	CV

	lda	#<loading_message
	sta	OUTL
	lda	#>loading_message
	sta	OUTH
        jsr     print_both_pages


	;===========================
	; Load in KRW file
	;===========================

	lda	#<krw_file			; point to filename
	sta	INL
	lda	#>krw_file
	sta	INH

	jsr	read_file		; read KRW file from disk


	;=========================
	; Print Info
	;=========================

	jsr	clear_bottoms		; clear bottom of page 0/1

	lda	#>LZ4_BUFFER
	sta	OUTH
	lda	#<LZ4_BUFFER
	sta	OUTL

	ldy	#4			; skip KRW at front


; FIXME: optimize

	lda	#20
	sta	CV
	lda	(OUTL),Y
	sta	CH

	lda	OUTL
	clc
	adc	#5				; point past header stuff
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

        jsr     print_both_pages

	iny
	tya
	ldy	#0
	clc
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#$0
	sta	OUTH

	lda	#21
	sta	CV
	lda	(OUTL),Y
	sta	CH

	inc	OUTL
	bne	bloop2
	inc	OUTH
bloop2:

	jsr	print_both_pages

	iny
	tya
	ldy	#0
	clc
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#$0
	sta	OUTH

	lda	#23
	sta	CV
	lda	(OUTL),Y
	sta	CH

	inc	OUTL
	bne	bloop3
	inc	OUTH
bloop3:
	jsr	print_both_pages

	ldy	#0
	lda	#>(LZ4_BUFFER+3)
	sta	LZ4_SRC+1
	lda	#<(LZ4_BUFFER+3)
	sta	LZ4_SRC

	lda	(LZ4_SRC),Y		; get header skip
	clc
	adc	LZ4_SRC
	sta	LZ4_SRC
	lda	LZ4_SRC+1
	adc	#0
	sta	LZ4_SRC+1

	jsr	next_subsong

	; should tail call

	rts


	;=================
	; next sub-song
	;=================
next_subsong:

	ldy	#0

	lda	(LZ4_SRC),Y		; get next size value
	sta	LZ4_END
	iny
	lda	(LZ4_SRC),Y
	sta	LZ4_END+1

	lda	#2			; increment pointer
	clc
	adc	LZ4_SRC
	sta	LZ4_SRC
	lda	LZ4_SRC+1
	adc	#0
	sta	LZ4_SRC+1

	jsr	lz4_decode		; decode

	rts

;==========
; filenames
;==========
krw_file:
	.asciiz "INTRO2.KRW"

;=========
;routines
;=========
.include	"../asm_routines/gr_offsets.s"
.include	"../asm_routines/text_print.s"
.include	"../asm_routines/mockingboard_a.s"
.include	"../asm_routines/gr_fast_clear.s"
.include	"../asm_routines/pageflip.s"
.include	"../asm_routines/gr_unrle.s"
.include	"../asm_routines/gr_setpage.s"
.include	"../asm_routines/dos33_routines.s"
.include	"../asm_routines/gr_hlin.s"
.include	"../asm_routines/lz4_decode.s"
.include	"rasterbars.s"
.include	"volume_bars.s"

;=========
; strings
;=========
mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4"
not_message:		.byte   "NOT "
found_message:		.asciiz "FOUND"
done_message:		.asciiz "DONE PLAYING"
loading_message:	.asciiz "LOADING..."

;============
; graphics
;============
.include "chip_title.inc"
