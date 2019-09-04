
	;=============================
	; Setup
	;=============================
pt3_setup:

	;===========================
	; Check for Apple II/II+/IIc
	;===========================
	; this is used to see if we have lowecase support

	lda	$FBB3           ; IIe and newer is $06
	cmp	#6
	beq	apple_iie_or_newer

	lda	#1		; set if older than a IIe
	sta	apple_ii
	jmp	done_apple_detect
apple_iie_or_newer:
	lda	$FBC0		; 0 on a IIc
	bne	done_apple_detect
apple_iic:
	; activate IIc mockingboard?
	; this might only be necessary to allow detection
	; I get the impression the Mockingboard 4c activates
	; when you access any of the 6522 ports in Slot 4
	lda	#$ff
	sta	$C403
	sta	$C404

	; bypass the firmware interrupt handler
	; should we do this on IIe too? probably faster

	sei				; disable interrupts
	lda	$c08b			; disable ROM (enable language card)
	lda	$c08b
	lda	#<interrupt_handler
	sta	$fffe
	lda	#>interrupt_handler
	sta	$ffff

	lda	#$EA			; nop out the "lda $45" in the irq hand
	sta	interrupt_smc
	sta	interrupt_smc+1

done_apple_detect:

	;===============
	; init variables
	;===============

	lda	#0
	sta	DONE_PLAYING
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

;	lda	#<not_message			; if not found, print that
;	sta	OUTL
;	lda	#>not_message
;	sta	OUTH
;	inc	CV
;	jsr	move_and_print

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
	; Enable 60Hz clock on 6522
	;============================

	sei			; disable interrupts just in case

	lda	#$40		; Continuous interrupts, don't touch PB7
	sta	$C40B		; ACR register
	lda	#$7F		; clear all interrupt flags
	sta	$C40E		; IER register (interrupt enable)

	lda	#$C0
	sta	$C40D		; IFR: 1100, enable interrupt on timer one oflow
	sta	$C40E		; IER: 1100, enable timer one interrupt

	lda	#$1b
	sta	$C404		; write into low-order latch
	lda	#$41
	sta	$C405		; write into high-order latch,
				; load both values into counter
				; clear interrupt and start counting

	; 4fe7 / 1e6 = .020s, 50Hz
	; 411b / 1e6 = .0166s, 60Hz

	;==================
	; init song
	;==================

	jsr	pt3_init_song

	rts

;========================================
;========================================

; Helper routines below

;========================================
;========================================

;=========
; vars
;=========

time_frame:	.byte	$0
apple_ii:	.byte	$0

;=========
; strings
;=========
;mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4"
not_message:		.byte   "NOT "
found_message:		.asciiz "FOUND"
;done_message:		.asciiz "DONE PLAYING"

