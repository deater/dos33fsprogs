; Play music while showing AppleIIbot programs

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

STROUT = $db3a

DONE	= 0
DO_LOAD	= 1
DO_LIST	= 2
DO_RUN	= 3

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

command_loop:
	lda	trigger
	beq	not_trigger

	lda	#0
	sta	trigger

	lda	command
	cmp	#DONE
	beq	command_loop

	cmp	#DO_LIST
	bne	not_do_list
	jmp	do_list

not_do_list:
	cmp	#DO_LOAD
	bne	not_do_load
	jsr	do_load
	jmp	not_trigger

not_do_load:
	cmp	#DO_RUN
	bne	not_trigger

	jmp	do_run

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

.include	"nozp.inc"



PT3_LOC = song
.align	$100
song:
.incbin "../pt3_player/music/DF.PT3"
