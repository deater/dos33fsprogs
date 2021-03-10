; Pastel

; pastel colors
;	see if we can force into BASIC

; zero page locations

; ROM calls
SETCOL		= $F864			; COLOR=A
PRHEX		= $FDE3			; print hex digit
COUT		= $FDED			; output A to screen
SETGR		= $FB40			; set lo-res graphics and clear screen

tiny_xdraw:

	bit	$C050		; switch to lo-res graphics
tiny_loop:
	txa
	eor	$50,X		; get value from zero page
	tay

	lda	#$40		; push return address-1	($082C)
	lsr
	lsr
	lsr
	pha
	lda	#$58		; can't be 2B :(    0010 1011
	lsr
	pha

	lda	#$A0		; A0 ^ 58	; F8 1111 1000
	eor	#$58
	pha
	lda	#$A3		; SETCOL = $F864
	eor	#$C0		; 63 = 0110 0011
	pha
	tya
	rts

	inx
	tay

;	jsr	SETCOL		; set bottom nibble to top

	lda	#$40		; want to return to $813 (so $812)
	lsr
	lsr
	lsr
	pha
	lda	#$24
	lsr
	pha

	lda	#$A5		; want 1111 1101
	eor	#$58
	pha

	lda	#$B0		; want 1110 1100
	eor	#$5C
	pha			; COUT = $FDED

	tya

	rts

;	jsr	COUT		; print to text screen (which is same
				; as lo-res graphics screen) with scroll


; NOT ALLOWED: ROL	(is ?)
;		} turns to ]
;		lowercase is uppercased


;	2C	,
;	50	P
;	C0	TAB(
;	8A	PR#
;	55	U
;	50	P
;	A8	STORE
;	A9	SPEED=
;	40	@
;	4A	J
;	4A	J
;	4A	J
;	48	H
;	A9	SPEED=
;	58	X
;	4A	J
;	48	H
;	A9	SPEED=
;	A0	COLOR=
;	49	I
;	58	X
;	48	H
;	A9	SPEED=
;	A3	HIMEM:
;	49	I
;	C0	TAB(
;	48	H
;	98	ROT=
;	60	`
;	E8	LEFT$
;	A8	STORE
;	A9	SPEED=
;	40	@
;	4A	J
;	4A	J
;	4A	J
;	48	H
;	A9	SPEED=
;	24	$
;	4A	J
;	48	H
;	A9	SPEED=
;	A5	ONERR
;	49	I
;	58	X
;	48	H
;	A9	SPEED=
;	B0	GOSUB
;	49	I
;	5C	\
;	48	H
;	98	ROT=
;	60	`

;10 CALL +2064
;20 ,PTAB(PR#UPSTORESPEED=@JJJHSPEED=XJHSPEED=COLOR=IXHSPEED=HIMEM:ITAB(HROT=`LEFT$STORESPEED=@JJJHSPEED=$JHSPEED=ONERRIXHSPEED=GOSUBI\HROT=`
