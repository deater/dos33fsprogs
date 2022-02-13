; Tiny Gr

; by Vince `deater` Weaver, vince@deater.net	--- d e s i r e ---

; trying to make small graphics in 8 bytes for Apple II

; drops into the middle of the CHRGET get next token routine
; that the Applesoft interpreter copies to $B1 - $C8 on boot

; zero page locations

; ROM calls
SETGR	= $FB40			; set lo-res graphics code, clear screen
PRHEX	= $FDE3			; print hex digit
COUT	= $FDED                 ; output A to screen
COUT1	= $FDF0                 ; output A to screen

tiny_gr:

;chrget	B1:	E6 B8		inc	txtptrl
;	B3:	D0 02		bne	chrgot
;	B5:	E6 B9		inc	txtptrh
;chrgot	B7:	AD 00 08	lda	$800	txtprtrl/txtptrh
;	BA:	C9 3A		cmp	#$3A
;	BC:	B0 0A		bcs	end
;	BE:	C9 20		cmp	#$20
;	C0:	F0 EF		beq	chrget
;	C2:	38		sec
;	C3:	E9 30		sbc	#$30
;	C5:	38		sec
;	C6:	E9 D0		sbc	#$D0
;	C8:	60		rts

; we drop this at B9

;chrget	B1:	E6 B8		inc	txtptrl
;	B3:	D0 02		bne	chrgot
;	B5:	E6 B9		inc	txtptrh
;chrgot	B7:	AD 00 08	lda	$800
tiny_loop:
;	lda	$7800
.byte 	$78	; sei		; B9
	bit	$C050		; BA BB BC set LORES
	jsr	COUT1		; BD BE BF output A to stdout, with scroll
.byte	$50 ; bvc (bra we hope)	; C0
;		chrget
