; VMW Chiptune Player

.include	"zp.inc"
				; program is ~4k, so from 0xc00 to 0x1C00
LZ4_BUFFER	EQU	$1C00		; $1C00 - $4400, 10k = $2800
DISK_BUFFER	EQU	$4400		; for disk loading
LZ4_BUFFER2	EQU	$D100		; $D100 - $F900
UNPACK_BUFFER1	EQU	$5000		; $5000 - $8800, 14k, $3800
UNPACK_BUFFER2	EQU	$8800		; $8800 - $C000, 14k, $3800
					; by using qkumba's RTS code
					; no need for DOS, so we actually
					; are free the whole way to $C000
					; instead of stopping at $9600
					; $6000 - $C000 = 24k


NUM_FILES	EQU	1


	jmp	chiptune_setup

.include "chip_title_uncompressed.inc"

	.align	$400

	;=============================
	; Setup
	;=============================
chiptune_setup:
;	jsr     HOME
;	jsr     TEXT

	; Init disk code

	jsr	rts_init

	ldx	#0
copy_from_ff00:
	lda	$ff00,X
	sta	$6000,X
	inx
	bne	copy_from_ff00

	; Setup language card
	lda     $C08B           ; 4
	lda     $C08B           ; 4	; RR C08B = read RAM/write RAM

	ldx	#0
copy_to_ff00:
	lda	$6000,X
	sta	$ff00,X
	inx
	bne	copy_to_ff00


	; init variables

	lda	#0
	sta	DRAW_PAGE
	sta	CH
	sta	CV
	sta	DONE_PLAYING
	sta	MB_CHUNK_OFFSET
	sta	DECODE_ERROR			; clear out error message
	sta	WHICH_FILE


	; Disable the rasterbars for now, they take too long :(
;	lda	#$ff
	sta	RASTERBARS_ON

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


	;==================
	; load first song
	;==================

	jsr	new_song

	;============================
	; Init Background
	;============================
	jsr	set_gr_page0

	lda	#0
	sta	DRAW_PAGE
	sta	SCREEN_Y

	;============================
	; Enable 6502 interrupts
	;============================

	cli		; clear interrupt mask


	;============================
	; Loop forever
	;============================
main_loop:
	lda	DECODE_ERROR		; see if an error happened
	beq	check_copy
	sei				; turn off music
	brk				; if so, stop

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
	lda	DECOMPRESS_TIME		; see if it is time to decompress
	beq	check_done		; if zero, skip

	jsr	setup_next_subsong	; decompress

	lda	MB_CHUNK_OFFSET
	sta	TIME_TAKEN

	lda	#0
	sta	DECOMPRESS_TIME

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

	lda	#$0
	sta	FRAME_COUNT
	sta	A_VOLUME
	sta	B_VOLUME
	sta	C_VOLUME
	sta	COPY_OFFSET
	sta	DECOMPRESS_TIME
	sta	COPY_TIME
	sta	MB_CHUNK_OFFSET
	lda	#$20
	sta	DECODER_STATE
	lda	#3
	sta	CHUNKSIZE

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
	; Load 2nd file first
	;===========================
	; needs to be space-padded $A0 30-byte filename
	; this is hard-coded for now

	lda	#<readfile_filename
	sta	namlo
	lda	#>readfile_filename
	sta	namhi

	ldy	#0
	ldx	#30		; 30 chars
name_loop2:
	lda	filename2,Y
	beq	space_loop2
	ora	#$80
	sta	(namlo),Y
	iny
	dex
	bne	name_loop2
	beq	done_name_loop2
space_loop2:
	lda	#$a0		; pad with ' '
	sta	(namlo),Y
	iny
	dex
	bne	space_loop2

done_name_loop2:

	; open and read a file
	; loads to whatever it was BSAVED at (default is $D100)

	jsr	read_file		; read KRW file from disk


	;===========================
	; Load in KRW file
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
	; loads to whatever it was BSAVED at (default is $1C00)

	jsr	read_file		; read KRW file from disk


	;=========================
	; Print Info
	;=========================

	jsr	clear_bottoms		; clear bottom of page 0/1

	lda	#>LZ4_BUFFER		; point to LZ4 data
	sta	OUTH
	lda	#<LZ4_BUFFER
	sta	OUTL

	ldy	#3			; skip KRW magic at front

	; print title
	lda	#20			; VTAB 20: HTAB from file
	jsr	print_header_info

	; Print Author
	lda	#21			; VTAB 21: HTAB from file
	jsr	print_header_info

	; Print clock
	lda	#23			; VTAB 23: HTAB from file
	jsr	print_header_info

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


	; Point Second LZ4 src at proper place

	ldy	#0
	lda	#>(LZ4_BUFFER2+3)
	sta	LZ4_SRC2+1
	lda	#<(LZ4_BUFFER2+3)
	sta	LZ4_SRC2

	lda	(LZ4_SRC2),Y		; get header skip
	clc
	adc	LZ4_SRC2
	sta	LZ4_SRC2
	lda	LZ4_SRC2+1
	adc	#0
	sta	LZ4_SRC2+1

	; Point First LZ4 src at proper place

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

	lda	#<UNPACK_BUFFER1		; set input pointer
	sta	INL
	lda	#>UNPACK_BUFFER1
	sta	INH

	lda	#<UNPACK_BUFFER2		; set input pointer
	sta	INL2
	lda	#>UNPACK_BUFFER2
	sta	INH2

	; Decompress first chunks

	lda	#$0
	sta	COPY_OFFSET
	sta	DECOMPRESS_TIME
	lda	#$3
	sta	CHUNKSIZE
	lda	#$20
	sta	DECODER_STATE
	sta	COPY_TIME

	lda	LZ4_SRC
	sta	LZ4_SRC1

	lda	LZ4_SRC+1
	sta	LZ4_SRC1+1

	jsr	setup_next_subsong

	rts

	;=================
	; next sub-song
	;=================
setup_next_subsong:

	;==============
	; Left side

	ldy	#0

	lda	LZ4_SRC1
	sta	LZ4_SRC
	lda	LZ4_SRC1+1
	sta	LZ4_SRC+1

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

	lda	#>UNPACK_BUFFER1	; original unpacked data offset
	sta	LZ4_DST+1
	lda	#<UNPACK_BUFFER1
	sta	LZ4_DST


	jsr	lz4_decode		; decode

	lda	LZ4_SRC
	sta	LZ4_SRC1
	lda	LZ4_SRC+1
	sta	LZ4_SRC1+1

	;==================
	; right side

	ldy	#0

	lda	LZ4_SRC2
	sta	LZ4_SRC
	lda	LZ4_SRC2+1
	sta	LZ4_SRC+1

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

	lda	#>UNPACK_BUFFER2	; original unpacked data offset
	sta	LZ4_DST+1
	lda	#<UNPACK_BUFFER2
	sta	LZ4_DST


	jsr	lz4_decode		; decode

	lda	LZ4_SRC
	sta	LZ4_SRC2
	lda	LZ4_SRC+1
	sta	LZ4_SRC2+1


					; tail-call?

	rts



	;===================
	; print header info
	;===================
	; shortcut to print header info
	; a = VTAB

print_header_info:

	sta	CV

	iny				; adjust pointer
	tya
	ldy	#0
	clc
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#$0
	sta	OUTH

	lda	(OUTL),Y		; get HTAB value
	sta	CH

	inc	OUTL			; increment 16-bits
	bne	bloop22
	inc	OUTH
bloop22:

	jmp     print_both_pages	; print, tail call


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
	lda	#>(UNPACK_BUFFER1+512)					; 3
	adc	COPY_OFFSET						; 3
	adc	COPY_OFFSET						; 3
	adc	COPY_OFFSET						; 3
	sta	page_copy_loop+2			; self modify	; 5

	lda	#>(UNPACK_BUFFER1+$2A00)					; 2
	adc	COPY_OFFSET						; 3
	sta	page_copy_loop+5			; self modify	; 5

	ldx	#$00							; 2
page_copy_loop:
	lda	$1000,x							; 4
	sta	$1000,X							; 5
	inx								; 2
	bne	page_copy_loop						; 2nt/3


	;========================
	; page copy2
	;========================
	; want to copy:
	;	SRC: chunk_buffer+(2*256)+(COPY_OFFSET*3*256)
	;	DST: chunk_buffer+$2A00+(COPY_OFFSET*256)
page_copy2:
	clc								; 2
	lda	#>(UNPACK_BUFFER2+512)					; 3
	adc	COPY_OFFSET						; 3
	adc	COPY_OFFSET						; 3
	adc	COPY_OFFSET						; 3
	sta	page_copy_loop2+2			; self modify	; 5

	lda	#>(UNPACK_BUFFER2+$2A00)					; 2
	adc	COPY_OFFSET						; 3
	sta	page_copy_loop2+5			; self modify	; 5

	ldx	#$00							; 2
page_copy_loop2:
	lda	$1000,x							; 4
	sta	$1000,X							; 5
	inx								; 2
	bne	page_copy_loop2						; 2nt/3


	rts								; 6
							;======================
							; 2+14*256+6+29= 3621


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

	lda	#<krw_file			; point to filename
	sta	INL
	lda	#>krw_file
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

krw_file:

.include "song_list.inc"

;=========
;routines
;=========
.include	"../asm_routines/gr_offsets.s"
.include	"text_print.s"
.include	"mockingboard_a.s"
.include	"../asm_routines/gr_fast_clear.s"
.include	"../asm_routines/pageflip.s"
;.include	"../asm_routines/gr_unrle.s"
.include	"gr_setpage.s"
.include	"qkumba_rts.s"
.include	"../asm_routines/gr_hlin.s"
.include	"lz4_decode.s"
.include	"../asm_routines/keypress_minimal.s"
.include	"rasterbars.s"
.include	"volume_bars.s"
.if .def(UNROLLED)
.include	"interrupt_handler_unrolled.s"
.else
.include	"interrupt_handler.s"
.endif
;=========
; strings
;=========
;mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4"
not_message:		.byte   "NOT "
found_message:		.asciiz "FOUND"
;done_message:		.asciiz "DONE PLAYING"
loading_message:	.asciiz "LOADING"

