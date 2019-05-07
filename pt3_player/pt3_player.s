; VMW Chiptune Player

.include	"zp.inc"

PT3_LOC = $2000

UNPACK_BUFFER	EQU	$6000		; $6000 - $9800, 14k, $3800
NUM_FILES	EQU	15



	;=============================
	; Setup
	;=============================
pt3_setup:
	jsr     HOME
	jsr     TEXT

	; Init disk code

	jsr	rts_init

	; init variables

	lda	#0
;	sta	DRAW_PAGE
;	sta	CH
;	sta	CV
;	sta	DONE_PLAYING
;	sta	MB_CHUNK_OFFSET
;	sta	DECODE_ERROR
	sta	WHICH_FILE

;	lda	#$ff
;	sta	RASTERBARS_ON

	; print detection message

;	lda	#<mocking_message		; load loading message
;	sta	OUTL
;	lda	#>mocking_message
;	sta	OUTH
;	jsr	move_and_print			; print it

	jsr	mockingboard_detect_slot4	; call detection routine
	cpx	#$1
	beq	mockingboard_found

	lda	#<not_message			; if not found, print that
	sta	OUTL
	lda	#>not_message
	sta	OUTH
	inc	CV
	jsr	move_and_print

;	jmp	forever_loop			; and wait forever

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

;	lda	#<interrupt_handler
;	sta	$03fe
;	lda	#>interrupt_handler
;	sta	$03ff

	;============================
	; Enable 50Hz clock on 6522
	;============================

	sei			; disable interrupts just in case

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

;	jsr	set_gr_page0			; set page 0

;	lda	#$4				; draw page 1
;	sta	DRAW_PAGE

;	jsr	clear_screens			; clear both screens

;	lda	#<chip_title			; point to title data
;	sta	GBASL
;	lda	#>chip_title
;	sta	GBASH

;	bit	PAGE1

	; Load image				; load the image
;	lda	#<$800
;	sta	BASL
;	lda	#>$800
;	sta	BASH

;	jsr	load_rle_gr

	;==================
	; load first song
	;==================

	jsr	new_song

	;============================
	; Init Background
	;============================
;	jsr	set_gr_page0

;	lda	#0
;	sta	DRAW_PAGE
;	sta	SCREEN_Y

	;============================
	; Enable 6502 interrupts
	;============================

;	cli		; clear interrupt mask


	;============================
	; Loop forever
	;============================
main_loop:


	jmp	main_loop

check_done:
	lda	#$ff
	bit	DONE_PLAYING
	beq	main_loop	; if was all zeros, loop
	bmi	main_loop	; if high bit set, paused
	bvs	minus_song	; if bit 6 set, then left pressed

				; else, either song finished or
				; right pressed

plus_song:
	sei			; disable interrupts
	jsr	increment_file
	jmp	done_play

minus_song:
	sei			; disable interrupts
	jsr	decrement_file

done_play:

	lda	#0
	sta	DONE_PLAYING

	lda	#0
	sta	CH

	jsr	clear_bottoms

	jsr	new_song

	cli				; re-enable interrupts

	jmp	main_loop

forever_loop:
	jmp	forever_loop



	;=================
	; load a new song
	;=================

new_song:

	;=========================
	; Init Variables
	;=========================

;	lda	#$0
;	sta	FRAME_COUNT
;	sta	A_VOLUME
;	sta	B_VOLUME
;	sta	C_VOLUME
;	sta	COPY_OFFSET
;	sta	DECOMPRESS_TIME
;	sta	COPY_TIME
;	sta	MB_CHUNK_OFFSET
;	lda	#$20
;	sta	DECODER_STATE
;	lda	#3
;	sta	CHUNKSIZE

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
	; Load in PT3 file
	;===========================

	jsr	get_filename

	lda	#8		; print filename to screen
	sta	CH
	lda	#21
	sta	CV

	lda	INL
	sta	OUTL
	lda	INH
	sta	OUTH
	jsr	print_both_pages


	; needs to be space-padded $A0 30-byte filename

	lda	#<readfile_filename
	sta	namlo
	lda	#>readfile_filename
	sta	namhi

	ldy	#0
	ldx	#30		; 30 chars
name_loop:
	lda	(INL),Y
	beq	space_loop
	ora	#$80
	sta	(namlo),Y
	iny
	dex
	bne	name_loop
	beq	done_name_loop
space_loop:
	lda	#$a0		; pad with ' '
	sta	(namlo),Y
	iny
	dex
	bne	space_loop

done_name_loop:

	; open and read a file
	; loads to whatever it was BSAVED at (default is $2000)

	jsr	read_file		; read PT3 file from disk


	;=========================
	; Print Info
	;=========================

	jsr	clear_bottoms		; clear bottom of page 0/1

	; NUL terminate the strings we want to print
	lda	#0
	sta	PT3_LOC+$3E
	sta	PT3_LOC+$62

	; print title

	lda	#>(PT3_LOC+$1E)		; point to header title
	sta	OUTH
	lda	#<(PT3_LOC+$1E)
	sta	OUTL

	lda	#20			; VTAB 20: HTAB from file
	jsr	print_header_info

	; Print Author

	lda	#>(PT3_LOC+$42)		; point to header title
	sta	OUTH
	lda	#<(PT3_LOC+$42)
	sta	OUTL

	lda	#21			; VTAB 21: HTAB from file
	jsr	print_header_info

	; Print clock
;	lda	#23			; VTAB 23: HTAB from file
;	jsr	print_header_info

	; Print Left Arrow (INVERSE)
	lda	#'<'
	sta	$750
	sta	$B50

	lda	#'-'
	sta	$751
	sta	$B51

	; Print Rright Arrow (INVERSE)
	lda	#'-'
	sta	$776
	sta	$B76

	lda	#'>'
	sta	$777
	sta	$B77

	jsr	pt3_init_song

	rts


	;===================
	; print header info
	;===================
	; shortcut to print header info
	; a = VTAB

print_header_info:

	sta	CV
	lda	#4
	sta	CH
	jmp     print_both_pages	; print, tail call




	;==================
	; Get filename
	;==================
	; WHICH_FILE holds number
	; MAX_FILES has max
	; Scroll through until find
	; point INH:INL to it
get_filename:

	ldy	#0
	ldx	WHICH_FILE

	lda	#<song_list			; point to filename
	sta	INL
	lda	#>song_list
	sta	INH

get_filename_loop:
	cpx	#0
	beq	filename_found

inner_loop:
	iny
	lda	(INL),Y
	bne	inner_loop

	iny

	dex
	jmp	get_filename_loop

filename_found:
	tya
	clc
	adc	INL
	sta	INL
	lda	INH
	adc	#0
	sta	INH

	rts

	;===============================
	; Increment file we want to load
	;===============================
increment_file:
	inc	WHICH_FILE
	lda	WHICH_FILE
	cmp	#NUM_FILES
	bne	done_increment
	lda	#0
	sta	WHICH_FILE
done_increment:
	rts

	;===============================
	; Decrement file we want to load
	;===============================
decrement_file:
	dec	WHICH_FILE
	bpl	done_decrement
	lda	#(NUM_FILES-1)
	sta	WHICH_FILE
done_decrement:
	rts

;==========
; filenames
;==========

song_list:

.include "song_list.inc"

;=========
;routines
;=========
.include	"../asm_routines/gr_offsets.s"
.include	"text_print.s"
.include	"../asm_routines/mockingboard_a.s"
.include	"gr_fast_clear.s"
.include	"../asm_routines/pageflip.s"
;.include	"../asm_routines/gr_unrle.s"
.include	"../asm_routines/gr_setpage.s"
.include	"qkumba_rts.s"
.include	"../asm_routines/gr_hlin.s"
.include	"../asm_routines/lz4_decode.s"
.include	"../asm_routines/keypress_minimal.s"
;.include	"rasterbars.s"
;.include	"volume_bars.s"
.include	"interrupt_handler.s"
.include	"pt3.s"

;=========
; strings
;=========
;mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4"
not_message:		.byte   "NOT "
found_message:		.asciiz "FOUND"
;done_message:		.asciiz "DONE PLAYING"
loading_message:	.asciiz "LOADING"

