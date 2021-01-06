; Loads to 806

HLINE   = $F819                 ;; HLINE Y,$2C at A
SETGR	= $F390

; $20 to $60
;	AND (all)
;	BIT
;	BMI, BVC
;	EOR (all)
;	SEC
;	CLI
;	JMP
;	JSR
;	LSR
;	ROL
;	RTI
;	PHA
;	PLP


; DEY $88 = 1000 1000-> $44 ROL

plain:
	nop
	nop
	nop
	nop
	nop
	nop

	sec
	rol	;0x01
	sec
	rol	;0x03
	sec
	rol	;0x07
	sec
	rol	;0x0f
	sec
	rol	;0x1f
	sec
	rol	;0x3f


flip_it:
	jsr	SETGR

	lda	#$99
	sta	$30
	lda	#39
	sta	$2c
	ldy	#0
	lda	#15
	jsr	HLINE

end:
	jmp	end



.if 0
; x012345 ; xx6789ab ; xxcdef01 ; xx234567
; x=0, y=0

lda	eeep+3		; 3
asl			; 1
asl			; 1
ror	eeep+2		; 3
ror			; 1
ror	eeep+2		; 3
ror			; 1
sta	urgh+2		; 3
			;=======
			; 18

; xx012345 ; xx6789ab ; xxxxcdef ; 01234567

lda	eeep+0		; 3
asl	eeep+1		; 3
asl	eeep+1		; 3
asl	eeep+1		; 3
rol			; 1
asl	eeep+1		; 3
rol			; 1
sta	urgh+0		; 3
			;======
			; 20

; 01234567 ; 89ab0000 ; xxxxcdef ; 01234567

lda	eep+2		; 3
and	#$f		; 2
ora	eep+1		; 3
sta	urgh+1		; 3
			;=====
			; 11

inx
inx
inx			; 3
iny
iny
iny
iny			; 4
;bne			; 2


	ldy	#0
loop:
	lda	eeep,Y
	asl
	asl
	sta	urgh,Y
	iny
;	cmp	#$
	bne	loop

	ldy	#0
loop:
	lda	eeep,Y
	sta	ZP
	ldx	#3
three_loop:
	lda	ZP
	and	#$3
	ora	urgh,Y
	sta	urgh,Y
	lsr	ZP
	lsr	ZP
	iny
	dex
	bne	three_loop
	tya
	bne	loop


01xx xx00

ldy	#0
loop:
lda	eep,Y	;3
asl		;1
asl		;1
sta	urgh,Y  ;3
lda	eep+,Y	;3
lsr		;1
lsr		;1
and	#$f	;2
ora	urgh,Y	;3
sta	urgh,Y	;3
iny
bpl	loop
.endif

; fory=0to2:fori=0to39:z=y*40+i:color=peek(2054+z):ploti,y*16:color=peek(2154+z):ploti,1+y*16:nextI,Y



