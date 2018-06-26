;.include "zp.inc"

	H2	= $2C
	V2	= $2D
	TEMPY	= $FB

	HGR	= $F3E2
	HLINE	= $F819
	VLINE	= $F828
	COLOR	= $F864
	TEXT 	= $FB36
	HOME	= $FC58

	jsr	TEXT
	jsr	HOME

;30 HPLOT 0,Y TO X,Y:RETURN

	jsr	HGR
	lda	#0
	sta	$C052		; POKE  - 16302,0
;X=279
;80 HCOLOR= 4:HPLOT 0,0
	jsr	$F3F6			; CALL 62454
					; BGND, fill screen with color

;90 HCOLOR= 2:Y=63:GOSUB 30:Y=62:GOSUB 30
;100 HCOLOR= 6:Y=61:GOSUB 30:Y=60:GOSUB 30
;110 HCOLOR= 1:Y=59:GOSUB 30:Y=58:GOSUB 30
;120 HCOLOR= 5:Y=55:GOSUB 30:Y=54:GOSUB 30
;C=100
;130 HCOLOR= 0:X=C
;140 Y=123:GOSUB 30:Y=122:GOSUB 30
;150 Y=119:GOSUB 30:Y=118:GOSUB 30
	lda	#0
	jsr	COLOR	; COLOR= 0

	ldy	#0	; FOR I = 0 TO 39

iloop:
	sty	TEMPY
			;      A,V2 at Y
			; VLIN 0,39 AT I:NEXT
	lda	#39
	sta	V2
	lda	#0
	ldy	TEMPY
	jsr	VLINE
	ldy	TEMPY
	iny
	cpy	#40
	bne	iloop


	lda	#13
	jsr	COLOR	; COLOR= 13

	lda	#39
	sta	H2
	ldy	#0
	lda	#14	;     Y,H2 at A
	jsr	HLINE	;HLIN 0,39 AT 14

	;A = 9200 = $23F0
	;B = 13168 = $3370
	;FOR I = 0 TO 7:POKE A + I,0:POKE B + I,0:NEXT

	lda	#0
	sta	$23F0
	sta	$23F1
	sta	$23F2
	sta	$23F3
	sta	$23F4
	sta	$23F5
	sta	$23F6
	sta	$23F7
	sta	$3370
	sta	$3371
	sta	$3372
	sta	$3373
	sta	$3374
	sta	$3375
	sta	$3376
	sta	$3377

	lda	#1		; COLOR= 1
	jsr	COLOR

	lda	#39
	sta	H2

	lda	#13
	ldy	#0
				;     Y,H2 at A
	jsr	HLINE		;HLIN 0,39 AT 13

;200 VTAB 21:PRINT TAB(16)"RAINBOW"
;210 PRINT:PRINT "MIXED GRAPHICS (HI-RES/COLOR)"

; code
	lda	$C057
	lda	$C053
	lda	$C054
loop:
	lda	$C050
	bne	loop
	lda	$C056
	ldy	#$16
yloop:
	dey
	bne	yloop
	nop
	lda	$C057
	jmp	loop

