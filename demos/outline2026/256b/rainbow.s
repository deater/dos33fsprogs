; hectic

; by Vince `deater` Weaver / dSr

; For Outline 2026

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

;HGR_COLOR	= $E4
HGR_SCALE	= $E7
HGR_ROTATION	= $E8

ROTATION	=       $F9
SCALE           =       $FA
ROTATE          =       $FB
XPOS            =       $FC
YPOS            =       $FD

FRAME_DIV	= $FE
FRAME		= $FF

; ROM locations
HGR2		= $F3D8
HGR		= $F3E2
HPOSN		= $F411
;DRAW0		= $F601
XDRAW0		= $F65D
XDRAW1		= $F661
;HPLOT0          = $F457

HLINE		= $F819			; HLINE Y,$2C at A
;VLINE		= $F828			; VLINE A,$2D at Y
;TABV		= $FB5B			; go to A

SETCOL		= $F864

MOVE		= $FE2C		; move mem from A1 thru A2 to A4 (A trashed, Y start 0)

SET_GR		= $C050
SET_TEXT	= $C051
;FULLGR		= $C052
;TEXTGR		= $C053
PAGE1		= $C054
PAGE2		= $C055
LORES		= $C056	; Enable LORES graphics
HIRES		= $C057	; Enable HIRES graphics

VBLANK          = $C019 ; *not* RDVBL (VBL signal low) (iie, opposite iigs)





do_demo:

	;============================
	; setup gears
	;============================

	lda	#8
	sta	HGR_SCALE

	; page 1

	jsr	HGR

	jsr	draw_scene

	; page 2

	jsr	HGR2

	lda	#<gear2_table	; draw alternate gear
	sta	which_smc+1

	jsr	draw_scene


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

	; copy mem from A1H/L thru A2H/L to A4H/L (A trashed, Y start 0)

	ldy	#0		; 2

	sty	A1L		; 2
	sty	A2L		; 2
	sty	A4L		; 2
	lda	#$4		; 2	; $400
	sta	A1H		; 2
	asl			; 1	; $800
	sta	A2H		; 2
	sta	A4H		; 2
	jsr	MOVE		; 3 	; call MOVE
				;=======
				; 20 bytes


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
        ; delay 17020

        lda     #7                                                      ; 2
        ldy     #96                                                     ; 2
        jsr     size_delay                                              ; 17012
        nop                                                             ; 2
        nop                                                             ; 2

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

	ldx	#0

main_loop:

	; wait 24 cycles then switch to HIRES mode
	;	24 = 12 nop instrcutions (12 bytes)
	;		jsr to delay 12 twice (6 bytes)

	jsr	delay_12	; 12	; 12
	jsr	delay_12	; 12	; 24

	; switch to HIRES

	bit	HIRES		; 4	; 28

	; delay ?? cycles then switch to LORES

;	jsr	delay_12	; 12	; 40
;	nop			; 2	; 42

	nop
	nop
	nop
	nop
	nop
;	nop

	; create zig-zags
	; delay one fewer/one more depending on current row in X


	txa			; 2	; 44

	clc			; 2
	adc	FRAME_DIV	; 3
	and	#$4		; 2	; 46
	beq	less		; 2/3
more:
				; 52
	jmp	more_done	; 55
less:
				; 53

				; 53 / 55



more_done:

	bit	LORES		; 4	; 44

	lda	$0

;	nop			; 2	; 55 / 57
;	nop			; 2	; 57 / 59

	; increment row and see if at end

	inx			; 2	; 59 / 61
	cpx	#183		; 2	; 61 / 63
	bne	main_loop	; 3/2	; 64 / 66


	;=======================================
	; enter text mode for 8 lines (well, until end of VBLANK)
start_text:
	bit	SET_TEXT		; 4


	;=======================================
	; VBLANK
	;=======================================

	; need to delay 4551 = (4550+1) from fall through
	; plus9*65 for text mode = 5136

	;====================================
	; delay first to avoid text tearing
	; 5136
	; -4   set_text
	; -15  flip page
	; -22  smc the string
	; -24  draw new char
	; -841 string move
	; -5   inc frame
	; -9   end loop
	;===============
	; 4216

	; delay = 4216


	;=============================
	; delay!
	;=============================

	; 9*(256+209)=4185

	lda	#1		; 2
	ldy	#209		; 2
	jsr	size_delay	; 20+4185+4 = 4209
	; padding

	nop			; 2
	nop			; 2
	lda	$0		; 3

				;=================
				; 4209 + 7 = 4216


	;================================================
	; move the string at the bottom
	;================================================
	; note it's too fast, only do this one time in 4?


flip_page:
	lda	FRAME_DIV		; 3
	lsr				; 2
;	lsr				; 2
;	nop
	nop
	and	#1			; 2
	tay				; 2
	lda	PAGE1,Y			; 4
					;====
					; 15
draw_string:

	; see if should move
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

	;===========================
	; increment frame

	inc	FRAME		; 5


	;==========================
	; restore graphics mode

	bit	SET_GR		; 4		; reset graphics
	ldx	#0		; 2		; clear X
	beq	main_loop
;	jmp	main_loop	; 3

	;=====================================
        ; short delay by Bruce Clark
        ;   any delay between 8 to 589832 with res of 9
        ;=====================================
        ; 9*(256*A+Y)+8 + 12 for jsr/rts
        ; A and Y both $FF at the end

size_delay:

delay_loop:
        cpy     #1		; 2
        dey			; 2
        sbc     #0		; 2
        bcs     delay_loop	; 3/2
delay_12:
        rts

string:
	.byte 'O'+$80,'U'+$80,'T'+$80,'L'+$80,'I'+$80,'N'+$80,'E'+$80,' '+$80


	;=========================
	; draw scene
	;=========================

draw_scene:

	ldx	#10		; X = y position
	ldy	#32		; Y = steps to draw
	lda	#2		; A = rotation increment
	jsr	draw_gear	; A and X zero on return

	ldx	#50		; X = y position
	ldy	#16		; only 16 repeats
	lda	#4		; A = rotation increment

	; fall through

	;===============================
	;===============================
draw_gear:
	sty	ROTATION	; set number of rotations
	sta	smaller_smc+1	; set rotation increment

	ldy	#0
	txa
	ldx	#160
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??


gear1_loop:

	clc
	lda	rot_smc+1
smaller_smc:
	adc	#2
	sta	rot_smc+1

not_smaller:

which_smc:
	ldx	#<gear1_table	; point to bottom byte of shape address
	ldy	#>gear1_table	; point to top byte of shape address
				; this is always 0 if in zero page

rot_smc:
	lda	#1		; ROT=1 at first

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	dec	ROTATION
	bne	gear1_loop
	rts


gear1_table:
.byte	$25,$35,$00		; 37,53,0
gear2_table:
.byte	$2c,$2e,$00		; 44,46,0
