; nyan

; by Vince `deater` Weaver <vince@deater.net> / dSr

; zero page

H2	= $2C
COLOR	= $30
X0	= $F0
XX	= $F1
FRAME	= $F2
Y1	= $F3
Y0	= $F4
X1	= $F5

; soft-switches
FULLGR	= $C052

; ROM routines

PLOT	= $F800		;; PLOT AT Y,A
PLOT1	= $F80E		;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
HLINE	= $F819		;; HLINE Y,$2C at A
SETCOL	= $F864		;; COLOR=A
SETGR	= $FB40		;; init lores and clear screen
WAIT	= $FCA8		;; delay 1/2(26+27A+5A^2) us



	;================================
	; Clear screen and setup graphics
	;================================
boxes:

	jsr	SETGR		; set lo-res 40x40 mode

	lda	#0
	sta	COLOR
	sta	X0	; X0
	tax

	lda	#39
	sta	H2	; X1
	sta	Y1

draw_box_loop:

	stx	Y0
inner_loop:

	;; HLINE Y,H2 at A
	;; X left alone, carry set on exit
	;; H2 left alone
	;; Y and A trashed

	ldy	X0
	txa
	jsr	HLINE	; y, H2 at A

	cpx	Y1
	inx
	bcc	inner_loop


	inc	COLOR

	ldx	Y0
	inx		; Y0
	inx
	dec	Y1
	dec	Y1

	inc	X0
	dec	H2

	cpx	#20
	bne	draw_box_loop


end:
	jmp	end
