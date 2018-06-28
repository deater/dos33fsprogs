;.include "zp.inc"

	H2	= $2C
	V2	= $2D
	TEMPY	= $FB

	HGR	= $F3E2
	HPLOT0	= $F457
	HCOLOR	= $F6EC
	HLINE	= $F819
	VLINE	= $F828
	COLOR	= $F864
	TEXT 	= $FB36
	HOME	= $FC58

	jsr	TEXT
	jsr	HOME

	jsr	HGR
	lda	#0
	sta	$C052		; POKE  - 16302,0

	ldx	#4
	jsr	HCOLOR			; HCOLOR= 4
	ldx	#0
	ldy	#0
	lda	#0
	jsr	HPLOT0			; HPLOT 0,0

	jsr	$F3F6			; CALL 62454
					; BGND, fill screen with color

	ldx	#2
	jsr	HCOLOR			; HCOLOR= 2
;HPLOT 0,63 TO 279,63:RETURN
;HPLOT 0,62 TO 279,62:RETURN
	ldx	#6
	jsr	HCOLOR			; HCOLOR= 6
;HPLOT 0,61 TO 279,61:RETURN
;HPLOT 0,60 TO 279,60:RETURN
	ldx	#1
	jsr	HCOLOR			; HCOLOR= 1
;HPLOT 0,59 TO 279,59:RETURN
;HPLOT 0,58 TO 279,58:RETURN
	ldx	#5
	jsr	HCOLOR			; HCOLOR= 5
;HPLOT 0,55 TO 279,55:RETURN
;HPLOT 0,54 TO 279,54:RETURN
	ldx	#0
	jsr	HCOLOR			; HCOLOR= 0
;HPLOT 0,123 TO 100,123:RETURN
;HPLOT 0,122 TO 100,122:RETURN
;HPLOT 0,119 TO 100,119:RETURN
;HPLOT 0,118 TO 100,118:RETURN

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

