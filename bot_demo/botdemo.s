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


bot_demo:
	;===================
	; init some stuff

	; we have from $6000 to $9600 (DOS 3.3)
	; which is $3600 = 12 + 1.5 = 13.5k

	; we don't need to set HIMEM as we don't use many vars
	; and variable memory starts right after the program it seems


	;===================
	; PT3 Setup

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
	jsr	TEXT
	jsr	HOME
	bit	SET_GR
	bit	TEXTGR
	bit	KEYRESET

	;===================
	; init vars

	;=============================
	; Load bg

	lda	#<bg_rle
	sta	GBASL
	lda	#>bg_rle
	sta	GBASH
	lda	#$c
	jsr	load_rle_gr

	jsr	do_wipe

;	jsr	gr_copy_to_current	; copy to page1

	;=============================
	; mockingboard where available

	lda	#5
	sta	CH
	lda	#21
	sta	CV
	jsr	VTAB

	lda	#<mock_string
	ldy	#>mock_string

	jsr	STROUT

	lda	#12
	sta	CH
	lda	#22
	sta	CV
	jsr	VTAB

	lda	#<mock2_string
	ldy	#>mock2_string

	jsr	STROUT





done:
	lda	trigger
	beq	not_trigger

	lda	#0
	sta	trigger

	lda	command
	cmp	#DONE
	beq	done

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

	jmp	done


mock_string:
	.byte ") ) ) MOCKINGBOARD SOUND ( ( (",0
mock2_string:
	.byte "WHERE AVAILABLE",0

todo_list:

	.byte	DO_LOAD,1
	.byte	DO_LIST,5
	.byte	DO_RUN,15	; a2

	.byte	DO_LOAD,1
	.byte	DO_LIST,4
	.byte	DO_RUN,10	; flyer

	.byte	DO_LOAD,1
	.byte	DO_LIST,4
	.byte	DO_RUN,20	; nyan

	.byte	DO_LOAD,1
	.byte	DO_LIST,5
	.byte	DO_RUN,15	; qr



	.byte	DO_LOAD,1
	.byte	DO_LIST,5
	.byte	DO_RUN,15

	.byte	DO_LOAD,1
	.byte	DO_LIST,5
	.byte	DO_RUN,15

	.byte	DO_LOAD,1
	.byte	DO_LIST,5
	.byte	DO_RUN,15

	.byte	DO_LOAD,1
	.byte	DO_LIST,5
	.byte	DO_RUN,15

	.byte	DONE,$FF

command:	.byte $00
which:		.byte $00
timeout:	.byte 10
trigger:	.byte $00
original_stack:	.byte $00

	.include "gr_unrle.s"
	.include "gr_offsets.s"
;	.include "gr_copy.s"
	.include "bg.inc"

.include        "pt3_lib_core.s"
.include        "pt3_lib_init.s"
.include        "pt3_lib_mockingboard_setup.s"
.include        "interrupt_handler.s"
; if you're self patching, detect has to be after interrupt_handler.s
.include        "pt3_lib_mockingboard_detect.s"

.include	"wipe.s"
.include	"load.s"

.include	"nozp.inc"



PT3_LOC = song
.align	$100
song:
.incbin "../pt3_player/music/DF.PT3"
