;=================
; VMW PT3_LIB test
;=================
; template for using the pt3_lib

; zero page definitions
.include	"zp.inc"

; some firmware locations
.include	"hardware.inc"

; Location the files load at.
; If you change this, you need to update the Makefile

PT3_LOC = song

; the below will make for more compact code, at the expense
; of using $80 - $ff by our routines.  You'll also need to
; grab the zp.inc file from the pt3_player code

; PT3_USE_ZERO_PAGE = 1


	;=============================
	; Setup
	;=============================
pt3_setup:
	jsr     HOME
	jsr     TEXT

	;===========================
	; Check for Apple IIc
	;===========================
	; it does interrupts differently

	lda	$FBB3           ; IIe and newer is $06
	cmp	#6
	beq	apple_iie_or_newer

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

	; print detection message
	ldy	#0
print_mocking_message:
	lda	mocking_message,Y		; load loading message
	beq	done_mocking_message
	ora	#$80
	jsr	COUT
	iny
	jmp	print_mocking_message
done_mocking_message:
	jsr	CROUT1

	jsr	mockingboard_detect_slot4	; call detection routine
	cpx	#$1
	beq	mockingboard_found

	ldy	#0
print_not_message:
	lda	not_message,Y		; load loading message
	beq	forever_loop
	ora	#$80
	jsr	COUT
	iny
	jmp	print_not_message


mockingboard_found:
	ldy	#0
print_found_message:
	lda	found_message,Y		; load loading message
	beq	done_found_message
	ora	#$80
	jsr	COUT
	iny
	jmp	print_found_message
done_found_message:

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
	; init song
	;==================

	jsr	pt3_init_song

	;============================
	; Enable 6502 interrupts
	;============================
start_interrupts:
	cli		; clear interrupt mask


	;============================
	; Loop forever
	;============================
forever_loop:
	jmp	forever_loop


;========================================
;========================================

; Helper routines below

;========================================
;========================================

;=========
; vars
;=========

;=========
;routines
;=========
.include	"mockingboard_a.s"
.include	"interrupt_handler.s"
.include	"pt3_lib_core.s"
.include	"pt3_lib_init.s"

;=========
; strings
;=========
mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4"
not_message:		.byte "NOT "
found_message:		.asciiz "FOUND"

;=============
; include song
;=============
.align	256		; must be on page boundary
			; this can be fixed but some changes would have
			; to be made throughout the player code
song:
.incbin "../pt3_player/music/EA.PT3"
;.incbin "../ootw/ootw_audio/ootw_outro.pt3"
