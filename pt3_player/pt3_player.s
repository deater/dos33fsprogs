;===============
; VMW PT3 Player
;===============

; zero page definitions
.include	"zp.inc"

; Location the files load at.
; If you change this, you need to update the Makefile
PT3_LOC = $4000

; Number of files.  Should probably detect this automatically
NUM_FILES	EQU	18


	;=============================
	; Setup
	;=============================
pt3_setup:
	jsr     HOME
	jsr     TEXT

	bit	LORES		; Lo-res graphics
	bit	SET_GR
        bit	TEXTGR		; split text/graphics

	jsr	clear_screens


	;=======================
	; Check for Apple II/II+
	;=======================
	; this is used to see if we have lowecase support

	lda	$FBB3           ; IIe and newer is $06
	cmp	#6
	beq	apple_iie

	lda	#1		; set if older than a IIe
	sta	apple_ii
apple_iie:

	;===============
	; Init disk code
	;===============

	jsr	rts_init

	;===============
	; init variables
	;===============

	lda	#0
	sta	DRAW_PAGE
	sta	DONE_PLAYING
	sta	WHICH_FILE
	sta	LOOP

	;=======================
	; Detect mockingboard
	;========================

	; Note, we do this, but then ignore it, as sometimes
	; the test fails and then you don't get music.
	; In theory this could do bad things if you had something
	; easily confused in slot4, but that's probably not an issue.

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
	jsr	fire_init


	;============================
	; Enable 6502 interrupts
	;============================
start_interrupts:
	cli		; clear interrupt mask


	;============================
	; Loop forever
	;============================
main_loop:

	; Do the visualization

	jsr	draw_fire_frame
	jsr	put_letters
	jsr	page_flip

check_done:
	lda	DONE_PLAYING
	asl			; bit 7 to carry, bit 6 to bit 7
	beq	main_loop	; if was all zeros, loop
	bcs	main_loop	; if high bit set, paused
	bmi	minus_song	; if bit 6 set, then left pressed

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

	; clear the flame
	; FIXME: doesn't matter as we aren't displaying right now

	jsr	fire_setline

	jsr	new_song

	; re-enable the flame
	lda	#7
	jsr	fire_setline

	bmi	start_interrupts






;========================================
;========================================

; Helper routines below

;========================================
;========================================









	;=================
	; load a new song
	;=================

new_song:

	;=========================
	; Init Variables
	;=========================

	; ?

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
	;lda	#21
	;sta	CV

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
	; loads to whatever it was BSAVED at (default is $4000)

	jsr	read_file		; read PT3 file from disk


	;=========================
	; Print Info
	;=========================

	jsr	clear_bottoms		; clear bottom of page 0/1

	; NUL terminate the strings we want to print
	lda	#0
	sta	PT3_LOC+$3E
	sta	PT3_LOC+$62

upcase:
	; if Apple II/II+, uppercase the lowercase letters
	lda	apple_ii
	beq	no_uppercase

	ldy	#$1e
upcase_loop:
	lda	PT3_LOC,Y

	cmp	#$60
	bcc	not_lowercase	; blt
	sbc	#$20
	sta	PT3_LOC,Y
not_lowercase:
	iny
	cpy	#$63
	bne	upcase_loop

no_uppercase:
	; print title

	lda	#>(PT3_LOC+$1E)		; point to header title
	sta	OUTH
	lda	#<(PT3_LOC+$1E)
	sta	OUTL

	lda	#20			; VTAB 20: HTAB 4
	sta	CV
	lda	#4
	sta	CH
	jsr     print_both_pages	; print, tail call


	; Print Author

	lda	#<(PT3_LOC+$42)
	sta	OUTL

	inc	CV			; VTAB 21: HTAB 4
	jsr     print_both_pages	; print, tail call

	; Print clock

	lda	#>(clock_string)	; point to clock string
	sta	OUTH
	lda	#<(clock_string)
	sta	OUTL

	lda	#23			; VTAB 23: HTAB 13
	sta	CV
	lda	#13
	sta	CH
	jsr     print_both_pages	; print, tail call


	; Print which file

	; first update with current values

	lda	WHICH_FILE
	clc
	adc	#$1
	jsr	convert_decimal
	lda	which_10s
	sta	which_song_string
	lda	which_1s
	sta	which_song_string+1

	lda	#NUM_FILES
	jsr	convert_decimal
	lda	which_10s
	sta	which_song_string+3
	lda	which_1s
	sta	which_song_string+4

	; now print modified string

	lda	#>(which_song_string)	; point to which song string
	sta	OUTH
	lda	#<(which_song_string)
	sta	OUTL

	lda	#0			; HTAB 1
	sta	CH
	jsr     print_both_pages	; print, tail call



	; Print MHz indicator

	lda	#>(mhz_string)	; point to MHz string
	sta	OUTH
	lda	#<(mhz_string)
	sta	OUTL

	lda	#34			; HTAB 34
	sta	CH
	jsr     print_both_pages	; print, tail call

	; update the MHz indicator with current state

	ldx     #'0'+$80
	lda	convert_177_smc1
	cmp	#$18
	beq	done_MHz

	ldx	#'7'+$80

done_MHz:
        stx     $7F4
        stx     $BF4

	; Print Left Arrow (INVERSE)
	lda	#'<'
	sta	$6D0
	sta	$AD0

	lda	#'-'
	sta	$6D1
	sta	$AD1

	; Print Rright Arrow (INVERSE)
	lda	#'-'
	sta	$6F6
	sta	$AF6

	lda	#'>'
	sta	$6F7
	sta	$AF7

	jsr	pt3_init_song

;=================================
; Calculate Length of Song
;=================================

	; There's no easy way to do this? (???)
	; We walk through the song counting frames
	; We can't even do this quickly, as the number of frames
	;   per pattern can vary, and you have to parse a channel
	;   to see this, and channel data is varying-width and so
	;   you have to parse it all.
	; Time is just number of frames/50Hz


	sta	current_line
	sta	current_subframe
	sta	current_pattern

frame_count_loop:

	lda	current_line
	bne	fc_pattern_good
	lda	current_subframe
	bne	fc_pattern_good

	; load a new pattern in
	jsr	pt3_set_pattern

	lda	DONE_SONG
	beq	fc_pattern_good
        jmp	done_counting

fc_pattern_good:
	lda     current_subframe
	bne	fc_line_good

	; we only calc length of chanel A, hopefully enough

	lda	#1
	sta	pt3_pattern_done

        ; decode_note(&pt3->a,&(pt3->a_addr),pt3);
        ldx     #(NOTE_STRUCT_SIZE*0)
        jsr     decode_note

	lda	pt3_pattern_done
	bne	fc_line_good

	inc     current_pattern         ; increment pattern
        sta     current_line
        sta     current_subframe
        bne     frame_count_loop	; branch always

fc_line_good:
        inc     current_subframe        ; subframe++
        lda     current_subframe
        eor     pt3_speed_smc+1         ; if we hit pt3_speed, move to next
        bne     fc_do_frame

fc_next_line:
        sta     current_subframe	; reset subframe to 0

        inc     current_line            ; and increment line
        lda     current_line

        eor     #64			; always end at 64.
        bne     fc_do_frame		; is this always needed?

fc_next_pattern:
        sta     current_line		; reset line to 0

        inc     current_pattern         ; increment pattern

fc_do_frame:
	inc	time_frame
	lda	time_frame
	eor	#50
	bne	frame_count_loop

	sta	time_frame

	; see if overflow low s
	lda	$BD0+13+10
	cmp	#'9'+$80
	bne	inc_low_s

	; see if overflow high s
	lda	$BD0+13+9
	cmp	#'5'+$80
	bne	inc_high_s

	inc	$7D0+13+7
	inc	$BD0+13+7

	lda	#'0'+$80
	sta	$7D0+13+9
	sta	$BD0+13+9
	bne	clear_low_s

inc_high_s:
	inc	$7D0+13+9
	inc	$BD0+13+9

clear_low_s:
	lda	#'0'+$80
	sta	$7D0+13+10
	sta	$BD0+13+10

	bne	inc_done

inc_low_s:
	inc	$7D0+13+10
	inc	$BD0+13+10

inc_done:

fc_bayern:
	jmp	frame_count_loop


done_counting:

	; re-init, as we've run through it
	lda	#0
	sta	DONE_PLAYING
	sta	current_pattern

	jmp	pt3_init_song










	;==================
	; Get filename
	;==================
	; WHICH_FILE holds number
	; MAX_FILES has max
	; Scroll through until find
	; point INH:INL to it
get_filename:

	ldy	#0

	lda	#<song_list			; point to filename
	sta	INL
	lda	#>song_list
	sta	INH
	ldx	WHICH_FILE
	beq	filename_found

get_filename_loop:

inner_loop:
	iny
	lda	(INL),Y
	bne	inner_loop

	iny

	dex
	bne	get_filename_loop

filename_found:
	tya
	clc
	adc	INL
	sta	INL
	bcc	skip_inh_inc
	inc	INH
skip_inh_inc:

	rts

	;===============================
	; Increment file we want to load
	;===============================
increment_file:
	inc	WHICH_FILE
	lda	WHICH_FILE
	eor	#NUM_FILES
	bne	done_increment
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


	;=========================
	; convert_decimal
	;=========================
	; convert byte (<100) to tens/ones decimal
	; this is probably not the optimal way to do this
	; value in A, output in ASCII+$80 in which_10s:which_1s
	; trashes X
convert_decimal:

	ldx	#'0'+$80
	stx	which_1s
	stx	which_10s

	tax				; special case zero
	beq	conv_decimal_done
conv_decimal_loop:
	inc	which_1s
	lda	which_1s
	cmp	#':'+$80
	bne	conv_decimal_not_10
	lda	#'0'+$80
	sta	which_1s
	inc	which_10s
conv_decimal_not_10:
	dex
	bne	conv_decimal_loop

conv_decimal_done:
	rts



;=========
; vars
;=========


time_frame:	.byte	$0
apple_ii:	.byte	$0
which_10s:	.byte	$0
which_1s:	.byte	$0


;==========
; filenames
;==========

song_list:

.include "song_list.inc"

;=========
;routines
;=========
.include	"gr_offsets.s"
.include	"text_print.s"
.include	"mockingboard_a.s"
.include	"gr_fast_clear.s"
.include	"pageflip.s"
.include	"gr_setpage.s"
.include	"qkumba_rts.s"
.include	"keypress_minimal.s"
.include	"interrupt_handler.s"
.include	"pt3_lib.s"
.include	"fire.s"
.include	"random16.s"
.include	"gr_putsprite.s"
.include	"put_letters.s"

;=========
; strings
;=========
;mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4"
not_message:		.byte   "NOT "
found_message:		.asciiz "FOUND"
;done_message:		.asciiz "DONE PLAYING"
loading_message:	.asciiz "LOADING"
clock_string:		.asciiz "0:00 / 0:00"
mhz_string:		.asciiz "1.7MHZ"
which_song_string:	.asciiz	"00/00"
