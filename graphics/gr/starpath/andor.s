; calculates &X,Y,Z,C
;  C = (X|Y)&Z

; Routine for calling from &
;	when called next char/token in A
;	can't return anything unless you look up a variable by name
;	and write to it

; dump with od -t u1 ./ANDOR

VARPNTL = $83
VARPNTH = $84

FRMEVL = $DD7B
GETADDR= $E752
CHKCOM = $DEBE
SNGFLT = $E301
PTRGET = $DFE3	; returns pointer to variable in VARPNT and (Y,A)
MOVMF  = $EB2B

; 58 bytes -- first working value
; 48 bytes -- make it recursive

andor:
	jsr	oog
	sta	$24
	jsr	oog
	sta	$25		; 85 50
	jsr	oog

	lda	$24		; A5 24
	ora	$25		; 05 25
	and	$50		; 25 50
	pha

	jsr	PTRGET		; 20 E3 DF
	pla
	tay
	jsr	SNGFLT		; 20 01 E3  unsigned Y -> FAC

	ldx	VARPNTL		;VARPNT
	ldy	VARPNTH		;VARPNT+1
	jmp	MOVMF

oog:
	jsr	FRMEVL		; 20 7B DD  (or FRMNUM) 20 67 DD   value->FAC
	jsr	GETADDR		; 20 52 E7  FAC-> LINNUM ($50/$51)
	jsr	CHKCOM		; 20 BE DE  move past comma
	lda	$50
	rts
