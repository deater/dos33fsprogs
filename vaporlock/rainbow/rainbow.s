; hectic

; by Vince `deater` Weaver / dSr

; For Outline 2026

; 276 bytes -- first close version, already most obvious optimizations done
; 270 bytes -- consolidate nops
; 266 bytes -- delay routines from bisqwit
; 265 bytes -- replace jmp with branch
; 261 bytes -- run main loop backward, re-arrange to re-eliminate jump
; 259 bytes -- initialize HGR_SCALE inside the memory copy
; 258 bytes -- re-arrange params to draw_gear to remove txa
; 257 bytes -- make smaller a ZP location not smc
; 255 bytes -- use HGR to init Y to 0

; zero page locations
H2		= $2C
V2		= $2D
COLOR		= $30
A1L		= $3C
A1H		= $3D
A2L		= $3E
A2H		= $3F
A4L		= $42
A4H		= $43

HGR_SCALE	= $E7
HGR_ROTATION	= $E8

FAKE_NOP	= $F0

ROTSMC		= $F8
SMALLER		= $F9
ROTATION	= $FA
SCALE		= $FB
XPOS		= $FC
YPOS		= $FD

FRAME_DIV	= $FE
FRAME		= $FF

; ROM locations
HGR2		= $F3D8
HGR		= $F3E2
HPOSN		= $F411
XDRAW0		= $F65D
XDRAW1		= $F661
HLINE		= $F819	; HLINE Y,$2C at A
SETCOL		= $F864

MOVE		= $FE2C	; move mem from A1 thru A2 to A4 (A trashed, Y start 0)

SET_GR		= $C050
SET_TEXT	= $C051
PAGE1		= $C054
PAGE2		= $C055
LORES		= $C056	; Enable LORES graphics
HIRES		= $C057	; Enable HIRES graphics

VBLANK		= $C019	; *not* RDVBL (VBL signal low) (iie, opposite iigs)





hectic_demo:



rainbow_effect:
	;=====================================
	; draw rainbow pattern
	;=====================================

	lda	#39			; want to HLIN from 0 to 39
	sta	H2

	ldx	#47			; reverse rainbow to save 2 bytes
					; 47 down to 0
rainbow_loop:

	ldy	#$0

	txa				; set color
	jsr	SETCOL			; A is A*17 after running

	txa
	jsr	HLINE			; draw hline from Y to H2 at A
	dex
	bpl	rainbow_loop

	;=====================================
	; copy rainbow to PAGE2
	;=====================================
	; using MOVE for this is maybe 4 bytes shorter than open-coding
	;	with self-modifying code?

memory_copy:

	jsr	HGR		; hack!  Y is 0 after

	; copy mem from A1H/L thru A2H/L to A4H/L (A trashed, Y start 0)

;	ldy	#0		; 2

	sty	A1L		; 2
	sty	A2L		; 2
	sty	A4L		; 2
	lda	#$4		; 2	; $400
	sta	A1H		; 2
	asl			; 1	; $800

	sta	HGR_SCALE		; saves us 2 bytes!


	sta	A2H		; 2
	sta	A4H		; 2
	jsr	MOVE		; 3 	; call MOVE
				;=======
				; 20 bytes



	;============================
	; setup gears
	;============================


	; page 1



	jsr	draw_scene

	; page 2

	jsr	HGR2

	lda	#<gear2_table	; draw alternate gear
	sta	which_smc+1

	jsr	draw_scene



	;=====================================
	; sync screen to start of frame
	;=====================================
	; HACK: this only works on Apple IIe
	; This is based on code from Sather Apple IIe book
	;
	;  each line 65 cycles total;  25 hblank, 40 drawing
	; 262 lines total (192 on screen, 70 vblank)
	; 262/4 = 65.5
	; 262 = 2* 131 (prime)

sync_frame:

poll1:
        lda     VBLANK          ; Find end of VBL
        bmi     poll1           ; Fall through at VBL
poll2:
        lda     VBLANK
        bpl     poll2           ; Fall through at VBL'                  ; 2

	lda     $00     ;nop3   ; Now slew back in 17029 cycle loops    ; 3
lp17029:
	;===================
        ; delay 17020

	; from https://bisqwit.iki.fi/utils/nesdelay.php
	; 11 bytes
	ldx	#60
	ldy	#39
	nop
	dey
	bne	*-2
	dex
	bpl	*-7


;        lda     #7                                                      ; 2
 ;       ldy     #96                                                     ; 2
  ;      jsr     size_delay                                              ; 17012
   ;     nop                                                             ; 2
    ;    nop                                                             ; 2

        lda     VBLANK          ; Back to VBL yet?                      ; 4
        nop                     ;                                       ; 2
        bmi     lp17029         ; no, slew back                         ; 2/3



	;================================================
	; do the cycle-counted effect
	;================================================
	; 184 lines of zig-zag lo/hires
	; 8 lines of text mode (scrolling OUTLINE)
	; vblank
	; alternate page1/page2 each time through

	; ldx	#0
outer_loop:
	ldx	#183

main_loop:

	; wait 24 cycles then switch to HIRES mode
	;	24 = 12 nop instrcutions (12 bytes)
	;		jsr to delay 12 twice (6 bytes)

;	jsr	delay_12	; 12	; 12
;	jsr	delay_12	; 12	; 24


	; 4 bytes, 24 cycles
	; from https://bisqwit.iki.fi/utils/nesdelay.php
hack:
	lda	#$0A	; hides 'asl a'
	bpl	hack+1

	;========================
	; switch to HIRES
	;========================

	bit	HIRES		; 4	; 28

	; delay ?? cycles then switch to LORES

;	nop
;	nop

	lda	$0

;	inc	FRAME		; 5	; 33 ; nop5


	; create zig-zags
	; delay one fewer/one more depending on current row in X


	txa			; 2	; 40

	clc			; 2	; 42
	adc	FRAME_DIV	; 3	; 45
	and	#$4		; 2	; 47
	beq	less		; 2/3
more:
					; 49
	bne	more_done	; 3	; 52	; bra
less:
				; 50

				; 50 / 52
more_done:

	;==============================
	; switch back to LORES
	;==============================

	bit	LORES		; 4	; 54 / 56

	dec	FAKE_NOP	; 5	; 38 ; nop5

	inc	$F0		; 5			; nop5
	nop

	; decrement row and see if at end

	dex
;
;	inx			; 2	; 59 / 61
;	cpx	#183		; 2	; 61 / 63
	bne	main_loop	; 3/2	; 64 / 66


	;=======================================
	; enter text mode for 8 lines (well, until end of VBLANK)
start_text:
	bit	SET_TEXT		; 4


	;=======================================
	; VBLANK
	;=======================================

	; need to delay 4551 = (4550+1) from fall through
	; plus 9*65 for text mode = 5136

	;====================================
	; delay first to avoid text tearing
	; 5136
	; -4   set_text
	; -13  flip page
	; -22  smc the string
	; -24  draw new char
	; -841 string move
	; -5   inc frame
	; -9   end loop
	;===============
	; 4218

	; delay = 4218


	;=============================
	; delay!
	;=============================

	; 11 bytes
	php
	;delay_n (4211)
		; 9 bytes
		ldx #234 ;hides 'nop'
		;delay_n 11
			nop
			nop
			php
			plp
		dex
		bne *-6

	plp

	; 9*(256+210)=4194

;	lda	#1		; 2
;	ldy	#210		; 2
;	jsr	size_delay	; 20+4194+4 = 4218
	; padding

;	nop			; 2

				;=================
				; 4218 + 0 = 4218




	;================================================
	; page flip
	;================================================

flip_page:
	lda	FRAME_DIV		; 3
	lsr				; 2
	and	#1			; 2
	tay				; 2
	lda	PAGE1,Y			; 4
					;====
					; 13

	;================================================
	; move the string at the bottom
	;================================================

draw_string:

	; see if should move
	; only move every 16 frames

	lda	FRAME			; 3
	and	#$7			; 2
	php				; 3	; hack to get zero flag into A
	pla				; 4
	and	#$2			; 2
	lsr				; 2
	ora	#$D0			; 2
	sta	move_smc+1		; 4
					;=====
					; 22

	;==================================
	; draw new character
	; one past end as in theory that's unused at least on PAGE2

	lda	FRAME		; 3
	lsr			; 2
	lsr			; 2
	sta	FRAME_DIV	; 3
	lsr			; 2
	and	#$7		; 2
	tay			; 2
	lda	string,Y	; 4+
	sta	$BF8		; 4
				;===
				; 24


	;===========================
	; increment frame

	inc	FRAME		; 5


	;==========================
	; restore graphics mode

	bit	SET_GR		; 4		; reset graphics


	;==============================
	; move string


move_string:

	ldy	#0			; 2
move_string_loop:

move_smc:
	lda	$BD1,Y			; 4+
	sta	$7D0,Y			; 5
	sta	$BD0,Y			; 5
	iny				; 2
	cpy	#40			; 2
	bne	move_string_loop	; 2/3

	; 2+(21*40)-1 = 840+1 =841

;	ldx	#183		; 2		; clear X
;	bne	main_loop	; 3		; bra
	beq	outer_loop


	;=====================================
        ; short delay by Bruce Clark
        ;   any delay between 8 to 589832 with res of 9
        ;=====================================
        ; 9*(256*A+Y)+8 + 12 for jsr/rts
        ; A and Y both $FF at the end

;size_delay:
;
;delay_loop:
 ;       cpy     #1		; 2
  ;      dey			; 2
    ;    sbc     #0		; 2
   ;     bcs     delay_loop	; 3/2
;delay_12:
 ;       rts

string:
	.byte 'O'+$80,'U'+$80,'T'+$80,'L'+$80,'I'+$80,'N'+$80,'E'+$80,' '+$80

gear1_table:
.byte	$25,$35,$00		; 37,53,0
gear2_table:
.byte	$2c,$2e,$00		; 44,46,0

	;=========================
	; draw scene
	;=========================

draw_scene:

	lda	#10		; A = y position
	ldy	#32		; Y = steps to draw
	ldx	#2		; X = rotation increment
	jsr	draw_gear	; A and X zero on return

	lda	#50		; A = y position
	ldy	#16		; only 16 repeats
	ldx	#4		; X = rotation increment

	; fall through

	;===============================
	;===============================

draw_gear:
	sty	ROTATION	; set number of rotations
	stx	SMALLER		; set rotation increment

	ldy	#0
	ldx	#160
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??


gear1_loop:

	clc			; sadly needed
	lda	rot_smc+1
;	lda	ROTSMC
	adc	SMALLER
	sta	rot_smc+1
;	sta	ROTSMC

not_smaller:

which_smc:
	ldx	#<gear1_table	; point to bottom byte of shape address
	ldy	#>gear1_table	; point to top byte of shape address
				; this is always 0 if in zero page

rot_smc:
;	lda	ROTSMC
	lda	#1		; ROT=1 at first

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	dec	ROTATION
	bne	gear1_loop
delay_12:
	rts

