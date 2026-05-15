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
FRAME		= $E9

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





rainbow:
	bit	LORES
	bit	PAGE1
	bit	SET_GR

	lda	#39
	sta	H2

	ldx	#0
rainbow_loop:
	ldy	#$0

	txa
	jsr	SETCOL

	txa
	jsr	HLINE		; draw hline from Y to H2 at A
	inx
	cpx	#48
	bne	rainbow_loop

memory_copy:
	bit	PAGE2

.if 1
	lda	#0		; 2
	tay			; 1

	sta	A1L		; 2
	sta	A2L		; 2
	sta	A4L		; 2
	lda	#$4		; 2
	sta	A1H		; 2
	asl		; $8	; 1
	sta	A2H		; 2
	sta	A4H		; 2
	jsr	MOVE	; move mem from A1 thru A2 to A4 (A trashed, Y start 0)
				; 3
				;=======
				; 21 bytes
.else

	ldy	#0		; 2
cpyloop:
src_smc:
	lda	$400,Y		; 3
dst_smc:
	sta	$800,Y		; 3
	dey			; 1
	bne	cpyloop		; 2
	inc	src_smc+2	; 3
	inc	dst_smc+2	; 3
	lda	dst_smc+2	; 3
	cmp	#$c		; 2
	bne	cpyloop		; 2
				;=====
				; 24 bytes
.endif

initial:

poll1:
        lda     VBLANK          ; Find end of VBL
        bmi     poll1           ; Fall through at VBL
poll2:
        lda     VBLANK
        bpl     poll2           ; Fall through at VBL'                  ; 2


; 65

; 65 total;  25 blank, 40 drawing
; 262 lines (192 on screen, 70 vblank)
; 262/4 = 65.5
; 262 = 2* 131 (prime)



; 0: 4+21		4+3+33
;    4+21+(x*2)		4+3+33-(x*2)


;delay_2:			; 1 -> 6+(5*x)-1	1->4 2->9
;	dex		; 2
;	bne	delay_2	; 2/3
;	rts		; 6


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
	nop			; 2	; 59 / 61
;	nop			; 2	; 61 / 63

;	jmp	main_loop	; 3	; 64 / 66

	inx			; 2
	bne	main_loop	; 3/2

	; 256
	; need to delay 6*65 = 390+1 from fall through
					; 391
	ldx	#0	; 2		; 389

;	lda	$0	; 3		; 386
	lda	#0	; 2		; 384
	ldy	#39	; 2		; 382

					; 3 from end = 379
	nop
	nop
	 nop
;	lda	$0
	nop
	nop
	nop

	; 39*9=351

	jsr	size_delay	;	; 20+351 = 371




	jmp	main_loop


	;=====================================
        ; short delay by Bruce Clark
        ;   any delay between 8 to 589832 with res of 9
        ;=====================================
        ; 9*(256*A+Y)+8 + 12 for jsr/rts
        ; A and Y both $FF at the end

size_delay:

delay_loop:
        cpy     #1
        dey
        sbc     #0
        bcs     delay_loop
delay_12:
        rts
