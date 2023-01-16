; Zero Wing Into
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

hires_start:

	;===================
	; set graphics mode
	;===================
	jsr	HOME



	;===================
	; Load graphics
	;===================
load_loop:

	jsr	HGR

	;=============================
	; In AD...
	;=============================

	jsr	HOME

	lda	#<inad_text
	sta	OUTL
	lda	#>inad_text
	sta	OUTH

	jsr	move_and_print

	jsr	wait_until_keypress

	;=============================
	; War was beginning
	;=============================


	jsr	HOME

	lda	#<ship_data
	sta	zx_src_l+1

	lda	#>ship_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	move_and_print

	jsr	wait_until_keypress

	;=============================
	; OPERATOR
	;=============================

	jsr	HOME

	lda	#<operator_data
	sta	zx_src_l+1

	lda	#>operator_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	lda	#<operator_text
	sta	OUTL
	lda	#>operator_text
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print

	jsr	wait_until_keypress


	;=============================
	; CATS
	;=============================

	jsr	HOME

	lda	#<cats_data
	sta	zx_src_l+1

	lda	#>cats_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	lda	#<cats_text
	sta	OUTL
	lda	#>cats_text
	sta	OUTH

	jsr	move_and_print

	jsr	wait_until_keypress

	;=============================
	; CAPTAIN
	;=============================

	jsr	HOME

	lda	#<captain_data
	sta	zx_src_l+1

	lda	#>captain_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	lda	#<captain_text
	sta	OUTL
	lda	#>captain_text
	sta	OUTH

	jsr	move_and_print

	jsr	wait_until_keypress





	jmp	load_loop




.align $100
	.include	"wait_keypress.s"
	.include	"zx02_optim.s"
	.include	"text_print.s"
	.include	"gr_offsets.s"


inad_text:
	.byte 14,21,"IN A.D. 2101",0
war_text:
	.byte 11,21,"WAR WAS BEGINNING.",0
what_text:
	.byte 0,21,"CAPTAIN: WHAT HAPPEN ?",0	; scroll
bomb_text:
	.byte 0,21,"MECHANIC: SOMEBODY SET UP US",0
	.byte 10,21,         "THE BOMB.",0
operator_text:
	.byte 0,20,"OPERATOR: WE GET SIGNAL.",0
	.byte 1,22, "CAPTAIN: WHAT !",0
main_text:
	.byte 0,20,"OPERATOR: MAIN SCREEN TURN ON.",0
you_text:
	.byte 0,20,"CAPTAIN: IT'S YOU !!",0
cats_text:
	.byte 0,21,"CATS: HOW ARE YOU GENTLEMEN !!",0
base_text:
	.byte 0,21,"CATS: ALL YOUR BASE ARE BELONG",0
	.byte 6,22,      "TO US.",0
destruction_text:
	.byte 0,21,"CATS: YOU ARE ON THE WAY TO",0
	.byte 6,22,      "DESTRUCTION.",0
captain_text:
	.byte 0,21,"CAPTAIN: WHAT YOU SAY !!",0
survive_text:
	.byte 0,21,"CATS: YOU HAVE NO CHANCE TO",0
	.byte 6,22,      "SURVIVE MAKE YOUR TIME.",0
ha_text:
	.byte 0,21,"CATS: HA HA HA HA ....",0
op_cap_text:
	.byte 0,21,"OPERATOR: CAPTAIN !!",0
zig_text:
	.byte 0,21,"CAPTAIN: TAKE OFF EVERY 'ZIG'!!",0
doing_text:
	.byte 0,21,"CAPTAIN: YOU KNOW WHAT YOU DOING.",0
move_zig_text:
	.byte 0,21,"CAPTAIN: MOVE 'ZIG'.",0
justice_text:
	.byte 0,21,"CAPTAIN: FOR GREAT JUSTICE.",0

cats_data:
	.incbin "graphics/cats.hgr.zx02"

captain_data:
	.incbin "graphics/captain.hgr.zx02"

operator_data:
	.incbin "graphics/operator.hgr.zx02"

ship_data:
	.incbin "graphics/ship.hgr.zx02"

hands_data:
	.incbin "graphics/hands.hgr.zx02"


