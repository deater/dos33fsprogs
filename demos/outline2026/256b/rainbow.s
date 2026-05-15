; rainbow

; by Vince `deater` Weaver / dSr

; For ???

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

HGR_COLOR	= $E4
HGR_SCALE	= $E7
HGR_ROTATION	= $E8

FRAME		= $FF

; ROM locations
HGR2		= $F3D8
HPOSN		= $F411
DRAW0		= $F601
XDRAW0		= $F65D
XDRAW1		= $F661
HPLOT0          = $F457

HLINE		= $F819			; HLINE Y,$2C at A
VLINE		= $F828			; VLINE A,$2D at Y
TABV		= $FB5B			; go to A

SETCOL		= $F864

MOVE		= $FE2C		; move mem from A1 thru A2 to A4 (A trashed, Y start 0)

SET_GR		= $C050
SET_TEXT	= $C051
FULLGR		= $C052
TEXTGR		= $C053
PAGE1		= $C054
PAGE2		= $C055
LORES		= $C056	; Enable LORES graphics
HIRES		= $C057	; Enable HIRES graphics

VBLANK          = $C019 ; *not* RDVBL (VBL signal low) (iie, opposite iigs)





rainbow_effect:

	bit	LORES			; switch to lores (necessary?)
	bit	PAGE1			; switch to PAGE1 (necessary?)
	bit	SET_GR			; set graphics mode (necessary?)

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
	;

	ldx	#0

main_loop:

	nop			; 2	; 2
	nop			; 2	; 4
	nop			; 2	; 6

	nop			; 2	; 8
	nop			; 2	; 10
	nop			; 2	; 12

	nop			; 2	; 14
	nop			; 2	; 16
	nop			; 2	; 18
	nop			; 2	; 20
	nop			; 2	; 22

	bit	HIRES		; 4	; 26

	nop			; 2	; 28

	nop			; 2	; 30
	nop			; 2	; 32
	nop			; 2	; 34

	nop			; 2	; 36
	nop			; 2	; 38
	nop			; 2	; 40
	bit	LORES		; 4	; 44

	nop
;	inx			; 2	; 46
	txa			; 2	; 48
	and	#$4		; 2	; 50
	beq	less		; 2/3
more:
				; 52
	jmp	more_done	; 55
less:
				; 53

				; 53 / 55
more_done:
	nop			; 2	; 55 / 57

	nop			; 2	; 57 / 59
;	nop			; 2	; 59 / 61
;	nop			; 2	; 61 / 63

;	jmp	main_loop	; 3	; 64 / 66

	inx			; 2
	cpx	#184		; 2
	bne	main_loop	; 3/2

	; need to delay 4551 = (4550+1) from fall through
	; plus8*65 for text mode = 5071


move_string:
	bit	SET_TEXT		; 4

	ldy	#0			; 2
move_string_loop:
	lda	$7D1,Y			; 4+
	sta	$7D0,Y			; 5
	lda	$BD1,Y			; 4+
	sta	$BD0,Y			; 5
	iny				; 2
	cpy	#39			; 2
	bne	move_string_loop	; 2/3

	lda	FRAME		; 3
	and	#$7		; 2
	tay			; 2
	lda	string,Y	; 4+
	sta	$7F7		; 4
	sta	$BF7		; 4
				;===
				; 19

	; 4+2+(25*39)-1 = 975+5 =980
	; 980+19 = 999

	; 5071-995=4072

					; 4072
	ldx	#0	; 2		; 4070
	lda	#1	; 2		; 4068
	ldy	#192	; 2		; 4066

					; 7 from end = 4059


	; 9*(256+192)=4032

	jsr	size_delay	;	; 20+4032 = 4052


	inc	FRAME	; 5
	nop


	bit	SET_GR		; 4
	jmp	main_loop	; 3


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
