; Title Screen / Menu for OOTW

;.include "../zp.inc"
;.include "../hardware.inc"

title:
	lda	#0
	sta	MENU_BASE		; start at level0 by default
	sta	MENU_HIGHLIGHT

redraw_title:
	bit	TEXT
	bit	PAGE0
	jsr	HOME

	lda	#<title_text
	sta	OUTL
	lda	#>title_text
	sta	OUTH
	jsr	move_and_print_list

title_loop:
	clc
	lda	MENU_BASE
	adc	MENU_HIGHLIGHT
	sta	WHICH_LOAD


	jsr	draw_menu

	jsr	wait_for_keypress

	; $15/$A = right/down
	cmp	#$15+$80
	beq	down_pressed
	cmp	#$A+$80
	beq	down_pressed

	; 8/B = left/up
	cmp	#$8+$80
	beq	up_pressed
	cmp	#$B+$80
	beq	up_pressed

	; Return = 13
	cmp	#13+$80
	beq	all_done

	cmp	#'H'+$80
	beq	want_help
	cmp	#'h'+$80
	bne	key_unknown
want_help:

	jsr	print_help

	jsr	wait_for_keypress

	jmp	redraw_title

key_unknown:
	; unknown, ignore
	jmp	title_loop

down_pressed:
	lda	MENU_HIGHLIGHT
	cmp	#2
	beq	down_offset
	inc	MENU_HIGHLIGHT
	bne	title_loop	; branch always

down_offset:
	lda	MENU_BASE
	cmp	#16-2
	beq	title_loop	; don't increment if 16
	inc	MENU_BASE
	bne	title_loop	; branch always

up_pressed:
	lda	MENU_HIGHLIGHT
	beq	up_offset	; don't decrement if 0
	dec	MENU_HIGHLIGHT
	jmp	title_loop
up_offset:
	lda	MENU_BASE
	beq	title_loop	; don't decrement if 0
	dec	MENU_BASE
	jmp	title_loop

all_done:

print_help_and_go:
	jsr	HOME

	lda	#<directions_load
	sta	OUTL
	lda	#>directions_load
	sta	OUTH
	jsr	move_and_print_list

ready_to_load:
	jmp	$1400			; LOADER starts here

wait_for_keypress:
	lda     KEYPRESS
	bpl	wait_for_keypress
	bit	KEYRESET
	rts

print_help:
	jsr	HOME

	lda	#<directions_text
	sta	OUTL
	lda	#>directions_text
	sta	OUTH
	jsr	move_and_print_list

	rts

.include "../text_print.s"
.include "../gr_offsets.s"

draw_menu:
	lda	#<menu_items
	sta	OUTL
	lda	#>menu_items
	sta	OUTH

	clc
	ldy	#0
get_right_offset:
	cpy	MENU_BASE
	beq	get_right_offset_done

	lda	OUTL
	adc	#23
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

	iny

	jmp	get_right_offset

get_right_offset_done:

	ldy	#1
	lda	#19
	sta	(OUTL),Y

	jsr	disable_highlight
	lda	MENU_HIGHLIGHT
	bne	no_highlight_line1
	jsr	enable_highlight
no_highlight_line1:

	jsr	move_and_print

	ldy	#1
	lda	#20
	sta	(OUTL),Y

	jsr	disable_highlight
	lda	MENU_HIGHLIGHT
	cmp	#1
	bne	no_highlight_line2
	jsr	enable_highlight
no_highlight_line2:

	jsr	move_and_print

	ldy	#1
	lda	#21
	sta	(OUTL),Y

	jsr	disable_highlight
	lda	MENU_HIGHLIGHT
	cmp	#2
	bne	no_highlight_line3
	jsr	enable_highlight
no_highlight_line3:

	jsr	move_and_print

	jsr	disable_highlight

draw_scrollbar:
	lda	#' '+$80
	sta	$550+29
	sta	$550+30
	ldx	WHICH_LOAD
	beq	draw_line1
draw_top:
	lda	#'/'+$80
	sta	$550+29		; line 18
	lda	#'\'+$80
	sta	$550+30
draw_line1:
	lda	#'I'+$80
	cpx	#5
	bcs	draw_line1_I	; bge
draw_line1_X:
	clc
	adc	#'X'-'I'
draw_line1_I:
	sta	$5d0+29		; line 19
	sta	$5d0+30

draw_line2:
	lda	#'I'+$80
	cpx	#5
	bcc	draw_line2_I	; blt
	cpx	#10
	bcs	draw_line2_I	; bge

draw_line2_X:
	clc
	adc	#'X'-'I'
draw_line2_I:
	sta	$650+29		; line 20
	sta	$650+30

draw_line3:
	lda	#'I'+$80
	cpx	#10
	bcc	draw_line3_I	; blt

draw_line3_X:
	clc
	adc	#'X'-'I'
draw_line3_I:
	sta	$6d0+29		; line 21
	sta	$6d0+30
draw_bottom:
	lda	#' '+$80
	sta	$750+29		; line 22
	sta	$750+30		; line 22
	cpx	#16
	beq	done_draw_bottom
	lda	#'\'+$80
	sta	$750+29		; line 22
	lda	#'/'+$80
	sta	$750+30
done_draw_bottom:

	rts



enable_highlight:
	lda	#$29		; and
	sta	ps_smc1
	lda	#$3f
	sta	ps_smc1+1
	rts

disable_highlight:
	lda	#$49
	sta	ps_smc1		; eor
	lda	#$80
	sta	ps_smc1+1
	rts







;.byte 0,18,"                             /\",0
;.byte 0,19,"       CHECKPOINT  1 (IH8S)  XX",0
;.byte 0,20,"       CHECKPOINT  2 (RAGE)  II",0
;.byte 0,21,"       CHECKPOINT  3 (VENT)  II",0
;.byte 0,22,"                             \/",0


title_text:
.byte  1, 0, "//II II==\ II==\ II   II== ]][[ ]][[",0
.byte  0, 1,"//_II II__/ II__/ II   II-   ][   ][",0
.byte  0, 2,"II II II    II    II__ II__ ]][[ ]][[",0
.byte  0, 3,"II II II                            _",0
.byte  3, 4,   "II II      // //=I\ II==\ II   II \\",0
.byte  3, 5,   "II II     // //  II II==/ II   II //",0
.byte  3, 6,   "II II//\\//  \===I/ II \\ II== II//",0
.byte  0, 8,"OOTW PROOF-OF-CONCEPT V3.1 (1 MAY 2021)",0
.byte  0, 9,"CODE: DEATER           DISK,LZ4: QKUMBA",0
.byte 12,10,            ",",0
.byte  0,11,"ORIGINAL BY ERIC CHAHI",0
.byte  0,12,"INSPIRED BY PAUL NICHOLAS PICO-8 VERSION",0
.byte 12,13,            "______",0
.byte 10,14,          "A \/\/\/ PRODUCTION",0
.byte 12,16,            "APPLE ][ FOREVER",0

.byte 0,23, "ARROWS SELECT, RETURN STARTS, H FOR HELP",0
.byte 255




menu_items:	; 23 wide
.byte 8,0,"INTRO MOVIE         ",0
.byte 8,0,"CHECKPOINT  1 (IH8S)",0		; LDKD
.byte 8,0,"CHECKPOINT  2 (RAGE)",0		; HTDC
.byte 8,0,"CHECKPOINT  3 (VENT)",0		; CLLD
.byte 8,0,"CHECKPOINT  4 (RCHG)",0		; LBKG
.byte 8,0,"CHECKPOINT  5 (CAVE)",0		; XDDJ
.byte 8,0,"CHECKPOINT  6 (CEIL)",0		; FXLC
.byte 8,0,"CHECKPOINT  7 (RUNC)",0		; KRFK
.byte 8,0,"CHECKPOINT  8 (ROLL)",0		; KLFB
.byte 8,0,"CHECKPOINT  9 (SWIM)",0		; TTCT
.byte 8,0,"CHECKPOINT 10 (GRND)",0		; HRTB
.byte 8,0,"CHECKPOINT 11 (ABVE)",0		; BRTD
.byte 8,0,"CHECKPOINT 12 (THRW)",0		; TFBB
.byte 8,0,"CHECKPOINT 13 (ARMS)",0		; TXHF
.byte 8,0,"CHECKPOINT 14 (TANK)",0		; CKJL
.byte 8,0,"CHECKPOINT 15 (ANKD)",0		; LFCK
.byte 8,0,"ENDING              ",0

directions_load:
.byte 0, 0,"LOADING...",0
directions_text:
.byte 0, 5,"CONTROLS:",0
.byte 3, 6,   "A OR <-      : MOVE LEFT",0
.byte 3, 7,   "D OR ->      : MOVE RIGHT",0
.byte 3, 8,   "W OR UP      : JUMP",0
.byte 3, 9,   "S OR DOWN    : CROUCH / PICKUP",0
.byte 3,10,   "SPACEBAR     : KICK / SHOOT",0
.byte 3,11,   "L            : CHARGE GUN",0
.byte 3,12,   "ESC          : QUITS",0
.byte 255



