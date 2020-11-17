; Play music while showing AppleIIbot programs

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

STROUT = $db3a

NONE		= 0
DO_LOAD		= 1
DO_LIST		= 2
DO_RUN		= 3
DO_CREDITS	= 4
DONE		= 5

	;==========================================
	; we are loaded at $6000
	;
	; since we are now decompressed here after load
	; we don't have to worry about running into DOS3.3 at $9600
	;
	; we shouldn't need to set HIMEM as we don't use many vars
	; and variable memory starts right after the program

bot_demo:

	;===================
	; PT3 player Setup

	lda	#0
	sta	DONE_PLAYING
	lda	#1
	sta	LOOP

	jsr	mockingboard_detect
	bcc	mockingboard_not_found
setup_interrupt:
	jsr	mockingboard_init
	jsr	mockingboard_setup_interrupt
	jsr	reset_ay_both
	jsr	clear_ay_both
	jsr	pt3_init_song

start_interrupts:
	tsx
	stx	original_stack

	cli

mockingboard_not_found:

	;===================
	; init screen
	;===================

	jsr	TEXT
	jsr	SETGR
;	jsr	HOME
;	bit	SET_GR
;	bit	TEXTGR
	bit	KEYRESET

	;===================
	; init vars
	;===================

	;=============================
	; Load title screen
	;=============================

	lda	#<bg_rle
	sta	GBASL
	lda	#>bg_rle
	sta	GBASH
	lda	#$c
	jsr	load_rle_gr

	;==============================
	; wipe it to page1 gr
	;==============================

	jsr	do_wipe

	;=============================
	; mockingboard where available
	;=============================

	jsr	mock_anim


	;==============================
	;==============================
	;==============================
	; command loop
	;==============================
	;==============================
	;==============================


command_loop:

	; check if irq handler has set trigger because we hit limit

	lda	trigger
	beq	not_trigger

	lda	#0		; reset trigger
	sta	trigger

	lda	command		; load current command (also set in irq)
	cmp	#DONE		; if done, just loop forever
	beq	command_loop

	cmp	#DO_LIST	; if command is list
	bne	not_do_list
	jmp	do_list		; then do it

not_do_list:
	cmp	#DO_LOAD	; if command is load
	bne	not_do_load
	jsr	do_load		; then do it
	jmp	not_trigger

not_do_load:
	cmp	#DO_RUN		; if command is run
	bne	not_do_run

	jmp	do_run		; then do it

not_do_run:
;	cmp	#DO_CREDITS
;	bne	not_trigger

;	jmp	switch_to_credits

not_trigger:

	jmp	command_loop

command:	.byte $00
which:		.byte $00
timeout:	.byte 10
trigger:	.byte $00
original_stack:	.byte $00

	.include "gr_unrle.s"
	.include "gr_offsets.s"
	.include "bg.inc"

.include        "pt3_lib_core.s"
.include        "pt3_lib_init.s"
.include        "pt3_lib_mockingboard_setup.s"
.include        "interrupt_handler.s"
; if you're self patching, detect has to be after interrupt_handler.s
.include        "pt3_lib_mockingboard_detect.s"

.include	"commands.s"
.include	"timeline.inc"

.include	"wipe.s"
.include	"mock_anim.s"
.include	"credits.s"

.include	"nozp.inc"



PT3_LOC = song
.align	$100
song:
.incbin "music/Second_Best_2_Nothing.pt3"
