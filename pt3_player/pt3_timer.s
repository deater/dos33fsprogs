; PT3 Timer -- times how long it takes

.include	"zp.inc"
.include	"hardware.inc"

PT3_LOC = $4000

PT3_USE_ZERO_PAGE = 1

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
	sta	DRAW_PAGE
	sta	DONE_PLAYING
	sta	WHICH_FILE

	jsr	mockingboard_detect_slot4	; call detection routine
	cpx	#$1
	beq	mockingboard_found


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

	;==================
	; load first song
	;==================

	jsr	new_song

	;============================
	; Enable 6502 interrupts
	;============================

	cli		; clear interrupt mask


	;============================
	; Loop forever
	;============================
main_loop:
	; play song as fast as possible

	jsr	interrupt_simulator

check_done:
	lda	#$ff
	bit	DONE_PLAYING
	beq	main_loop	; if was all zeros, loop
				; right pressed


done_play:
	sei			; disable interrupts

	; print results

	jsr	CROUT
	jsr	CROUT
	lda	timer_seconds_h
	jsr	PRBYTE
	lda	timer_seconds_l
	jsr	PRBYTE
	lda	#'.'+$80
	jsr	COUT
	lda	timer_fractions
	jsr	PRBYTE
	jsr	CROUT
	jsr	CROUT

	lda	#0
	sta	DONE_PLAYING


forever_loop:
	jmp	forever_loop



	;=================
	; load a new song
	;=================

new_song:

	;=========================
	; Init Variables
	;=========================

	; ?


	;===========================
	; Load in PT3 file
	;===========================

	jsr	get_filename

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

	; re-init, as we've run through it
	lda	#0
	sta	DONE_PLAYING

	jsr	pt3_init_song

	rts





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

;==========
; filenames
;==========

song_list:

	.asciiz "SR.PT3"

;=========
;routines
;=========
.include	"mockingboard_a.s"
.include	"qkumba_rts.s"

.include	"pt3_lib_core.s"
.include	"pt3_lib_init.s"





timer_fractions:	.byte	$0
timer_seconds_l:	.byte	$0
timer_seconds_h:	.byte	$0

	;======================================
	; simply time things with a 50Hz clock

interrupt_handler:
;	pha			; save A				; 3
				; A is saved in $45 by firmware
	txa
	pha			; save X
	tya
	pha			; save Y

	bit	$C404		; clear 6522 interrupt by reading T1C-L	; 4

count_time:

	inc	timer_fractions
	lda	timer_fractions
	cmp	#50			; 50Hz

	bne	done_count_time

	lda	#$0
	sta	timer_fractions

	inc	timer_seconds_l
	bne	done_count_time

	inc	timer_seconds_h

done_count_time:


exit_interrupt_handler:

;	pla			; restore a				; 4

	pla
	tay			; restore Y
	pla
	tax			; restore X
	lda	$45		; restore A


	rti			; return from interrupt			; 6








interrupt_simulator:
;	pha			; save A				; 3
				; A is saved in $45 by firmware
	txa
	pha			; save X
	tya
	pha			; save Y

;	bit	$C404		; clear 6522 interrupt by reading T1C-L	; 4

	bit	$1234

	lda	DONE_PLAYING						; 3
	beq	pt3_play_music	; if song done, don't play music	; 3/2nt
	jmp	check_keyboard						; 3
								;============
								;	13

pt3_play_music:

	jsr	pt3_make_frame

	lda	DONE_SONG
	beq	mb_write_frame

	lda	#$20
	jmp	quiet_exit


	;======================================
	; Write frames to Mockingboard
	;======================================
	; actually plays frame loaded at end of
	; last interrupt, so 20ms behind?

mb_write_frame:


	ldx	#0		; set up reg count			; 2
								;============
								;	  2

	;==================================
	; loop through the 14 registers
	; reading the value, then write out
	;==================================

mb_write_loop:
	lda	AY_REGISTERS,X	; load register value			; 4

	; special case R13.  If it is 0xff, then don't update
	; otherwise might spuriously reset the envelope settings

	cpx	#13							; 2
	bne	mb_not_13						; 3/2nt
	cmp	#$ff							; 2
	beq	mb_skip_13						; 3/2nt
								;============
								; typ 5
mb_not_13:


	; address
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	stx	MOCK_6522_ORA2		; put address on PA2		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
	ldy	#MOCK_AY_INACTIVE	; go inactive			; 2
	sty	MOCK_6522_ORB1						; 4
	sty	MOCK_6522_ORB2						; 4

        ; value
	lda	AY_REGISTERS,X		; load register value		; 4
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	sta	MOCK_6522_ORB2		; write on PB2			; 4
	sty	MOCK_6522_ORB1						; 4
	sty	MOCK_6522_ORB2						; 4
								;===========
								; 	60
mb_no_write:
	inx				; point to next register	; 2
	cpx	#14			; if 14 we're done		; 2
	bmi	mb_write_loop		; otherwise, loop		; 3/2nt
								;============
								; 	7
mb_skip_13:


	;=================================
	; Finally done with this interrupt
	;=================================

done_interrupt:

update_time:

done_time:

check_keyboard:
	jmp	exit_interrupt

quiet_exit:
	sta	DONE_PLAYING
	jsr	clear_ay_both

exit_interrupt:

;	pla			; restore a				; 4

	pla
	tay			; restore Y
	pla
	tax			; restore X
	lda	$45		; restore A


	rts			; return from interrupt			; 6


;============
; dummy vars
;============

pt3_loop_smc:

