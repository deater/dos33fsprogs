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
