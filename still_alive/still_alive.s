; And Believe Me, I'm Still Alive

.include	"zp.inc"
				; program is ~16k, so from 0xc00 to 0x4C00
UNPACK_BUFFER	EQU	$5E00		; $5E00 - $9600, 14k, $3800
					; trying not to hit DOS at $9600
					; Reserve 3 chunks plus spare (14k)

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
	sta	MB_CHUNK_OFFSET
	sta	DECODE_ERROR
	sta	LYRICS_ACTIVE

	; Testing, let's get 40col working first
	lda	#1
	sta	FORTYCOL

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




	;===========================
	; clear both screens
	;===========================

	; Clear text page0

	lda	#0
	sta	DRAW_PAGE
	lda	#(' '+$80)
	sta	clear_all_color+1
	jsr	clear_all


	;============================
	; Draw Lineart around edges
	;============================

	lda	FORTYCOL
	bne	fortycol_lineart

eightycol_lineart:

	; Draw top line

	lda	#' '+$80
	sta	dal_first+1
	lda	#'-'+$80
	sta	dal_second+1
	jsr	draw_ascii_line

	; Draw columns

	ldy	#20

	lda	#'|'+$80
	sta	dal_first+1
	lda	#' '+$80
	sta	dal_second+1
line_loop:
	jsr	draw_ascii_line
	dey
	bne	line_loop

	; Draw bottom line

	lda	#' '+$80
	sta	dal_first+1
	lda	#'-'+$80
	sta	dal_second+1
	jsr	draw_ascii_line

	jsr	word_bounds

	jmp	done_lineart

fortycol_lineart:

	jsr	word_bounds

done_lineart:


	jsr	HOME

	;==============================
	; Setup lyrics
	;==============================

	lda	#<(lyrics)
	sta	LYRICSL
	lda	#>(lyrics)
	sta	LYRICSH


	;==================
	; load song
	;==================

	jsr	load_song

	;============================
	; Init Background
	;============================




	;============================
	; Enable 6502 interrupts
	;============================

	cli		; clear interrupt mask


	;============================
	; Loop forever
	;============================
main_loop:
	lda	DECODE_ERROR
	beq	check_copy
	sei
	brk				; panic if we had an error


check_copy:
	lda	COPY_TIME
	beq	check_decompress	; if zero, skip

	lda	#0
	sta	COPY_OFFSET
check_copy_loop:
	jsr     page_copy                                               ;6+3621

	inc     COPY_OFFSET     ; (opt: make subtract?)                 ; 5

	lda	#14		; NOT HEX URGH!
	cmp	COPY_OFFSET
	bne	check_copy_loop

	lda	#0			; we are done
	sta	COPY_TIME

check_decompress:
	lda	DECOMPRESS_TIME
	beq	check_done		; if zero, skip

	jsr	setup_next_subsong	; decompress

	lda	MB_CHUNK_OFFSET
	sta	TIME_TAKEN

	lda	#0
	sta	DECOMPRESS_TIME


check_done:
	lda	DONE_PLAYING
	beq	main_loop

forever_loop:
	jmp	forever_loop



	;=================
	; load our song
	;=================

load_song:

	;=========================
	; Init Variables
	;=========================

	lda	#$0
	sta	COPY_OFFSET
	sta	DECOMPRESS_TIME
	sta	COPY_TIME
	sta	MB_CHUNK_OFFSET
	lda	#$20
	sta	DECODER_STATE
	lda	#3
	sta	CHUNKSIZE

	; We buffer one frame so start out one frame behind
	lda	#$ff
	sta	FRAME_COUNT


	;===========================
	; Setup KRW file
	;===========================

	; Point LZ4 src at proper place

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

	lda	#<UNPACK_BUFFER		; set input pointer
	sta	INL
	lda	#>UNPACK_BUFFER
	sta	INH

	; Decompress first chunks

	lda	#$0
	sta	COPY_OFFSET
	sta	DECOMPRESS_TIME
	lda	#$3
	sta	CHUNKSIZE
	lda	#$20
	sta	DECODER_STATE
	sta	COPY_TIME

	jsr	setup_next_subsong

	rts

	;=================
	; next sub-song
	;=================
setup_next_subsong:

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

					; tail-call?

	rts

	;==============================================
	; plan: takes 256  50Hz to play a chunk
	; need to copy 14 256-byte blocks
	; PLAY A (copying C)
	; PLAY B (copying C)
	; PLAY D (decompressing A/B/C)


	;========================
	; page copy
	;========================
	; want to copy:
	;	SRC: chunk_buffer+(2*256)+(COPY_OFFSET*3*256)
	;	DST: chunk_buffer+$2A00+(COPY_OFFSET*256)
page_copy:
	clc								; 2
	lda	#>(UNPACK_BUFFER+512)					; 3
	adc	COPY_OFFSET						; 3
	adc	COPY_OFFSET						; 3
	adc	COPY_OFFSET						; 3
	sta	page_copy_loop+2			; self modify	; 5

	lda	#>(UNPACK_BUFFER+$2A00)					; 2
	adc	COPY_OFFSET						; 3
	sta	page_copy_loop+5			; self modify	; 5

	ldx	#$00							; 2
page_copy_loop:
	lda	$1000,x							; 4
	sta	$1000,X							; 5
	inx								; 2
	bne	page_copy_loop						; 2nt/3
	rts								; 6
							;======================
							; 2+14*256+6+29= 3621



	;=====================
	; Draw ascii line art
	;
	; trashes A,X

draw_ascii_line:

dal_first:
	lda	#'|'+$80
	jsr	COUT1

	ldx	#38
dal_second:
	lda	#' '+$80
dal_loop:
	jsr	COUT1
	dex
	bne	dal_loop

	lda	dal_first+1
	jsr	COUT1

	rts


	;=============================
	; Draw ASCII art
	;=============================
	;	Eventually will be LZ4 encoded to save room
	;	It's 7063 bytes of data unencoded
	; A is which one to draw
	; Decode it to 0x800 (text page 2) which we aren't using
	;  and we shouldn't have to worry about screen holes
draw_ascii_art:
	sty	TEMPY

	asl
	tay
	dey
	dey

	lda	ascii_art,Y
	sta	OUTL
	lda	ascii_art+1,Y
	sta	OUTH

;	lda	#<aperture
;	sta	OUTL
;	lda	#>aperture
;	sta	OUTH

	ldy	#0
ascii_loop:
	lda	(OUTL),Y
	beq	done_ascii

	jsr	COUT

	; 16-bit increment
	inc	OUTL
	bne	alsb
	inc	OUTH
alsb:

	jmp	ascii_loop

done_ascii:
	ldy	TEMPY
	rts


	;============================
	; Setup Word Bounds
	;============================
word_bounds:

	lda	FORTYCOL
	bne	fortycol_word_bounds

eightycol_word_bounds:

	; on 80 column, words go from 2,1 to 35,21

	lda	#2
	sta	WNDLFT
	lda	#35
	sta	WNDWDTH
	lda	#1
	sta	WNDTOP
	lda	#21
	sta	WNDBTM

	rts

fortycol_word_bounds:
	; on 40 column, words go from 1,0 to 35,4

	lda	#1
	sta	WNDLFT
	lda	#35
	sta	WNDWDTH
	lda	#0
	sta	WNDTOP
	lda	#4
	sta	WNDBTM

	rts

	;============================
	; Setup Art Bounds
	;============================
art_bounds:

	lda	FORTYCOL
	bne	fortycol_art_bounds

eightycol_art_bounds:
	; on 80 column, art goes from 39,1 to 40,23 (????)

	lda	#2
	sta	WNDLFT
	lda	#35
	sta	WNDWDTH
	lda	#1
	sta	WNDTOP
	lda	#21
	sta	WNDBTM

	rts

fortycol_art_bounds:
	; on 40 column, art goes from 0,4 to 39,24

	lda	#2
	sta	WNDLFT
	lda	#35
	sta	WNDWDTH
	lda	#1
	sta	WNDTOP
	lda	#21
	sta	WNDBTM

	rts


;=========
;routines
;=========
.include	"../asm_routines/gr_offsets.s"
.include	"../asm_routines/text_print.s"
.include	"../asm_routines/mockingboard_a.s"
.include	"../asm_routines/gr_fast_clear.s"
.include	"../asm_routines/lz4_decode.s"

.include	"interrupt_handler.s"

;=========
; strings
;=========
mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4"
not_message:		.byte   "NOT "
loading_message:	.asciiz "LOADING"


lyrics:
.include	"lyrics.inc"

.include	"ascii_art.inc"

LZ4_BUFFER:
.incbin		"SA.KRW"

