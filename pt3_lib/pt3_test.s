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

	;===============
	; init variables
	;===============

	lda	#0
	sta	DONE_PLAYING
	sta	LOOP

	;=======================
	; Detect mockingboard
	;========================

	jsr	print_mockingboard_detect

	jsr	mockingboard_detect_slot4	; call detection routine
	cpx	#$1
	beq	mockingboard_found

	jsr	print_mocking_notfound
	;jmp	forever_loop
	; can't detect on IIc so just run with it anyway
	jmp	setup_interrupt

mockingboard_found:

	jsr	print_mocking_found

setup_interrupt:
	;=======================
	; Set up 50Hz interrupt
	;========================

	jsr	mockingboard_init
	jsr	pt3_setup_interrupt

	;============================
	; Init the Mockingboard
	;============================

	jsr	reset_ay_both
	jsr	clear_ay_both

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

	;==================================
	; Print mockingboard detect message
	;==================================
	; note: on IIc must do this before enabling interrupt
	;	as we disable ROM (COUT won't work?)

print_mockingboard_detect:

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

	rts

print_mocking_notfound:

	ldy	#0
print_not_message:
	lda	not_message,Y		; load loading message
	beq	print_not_message_done
	ora	#$80
	jsr	COUT
	iny
	jmp	print_not_message
print_not_message_done:
	rts

print_mocking_found:
	ldy	#0
print_found_message:
	lda	found_message,Y		; load loading message
	beq	done_found_message
	ora	#$80
	jsr	COUT
	iny
	jmp	print_found_message
done_found_message:

	rts

;=========
; strings
;=========
mocking_message:	.asciiz "LOOKING FOR MOCKINGBOARD IN SLOT #4"
not_message:		.byte "NOT "
found_message:		.asciiz "FOUND"



;=========
; vars
;=========

;=========
;routines
;=========

.include	"pt3_lib_core.s"
.include	"pt3_lib_init.s"
.include	"pt3_lib_mockingboard.s"
.include	"interrupt_handler.s"

;=============
; include song
;=============
.align	256		; must be on page boundary
			; this can be fixed but some changes would have
			; to be made throughout the player code
song:
.incbin "../pt3_player/music/EA.PT3"
;.incbin "../ootw/ootw_audio/ootw_outro.pt3"
