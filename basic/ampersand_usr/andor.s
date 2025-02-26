; calculates &X,Y,Z,C
;  C = (X|Y)&Z


; Routine for calling from &
;	when called next char/token in A
;	can't return anything unless you look up a variable by name
;	and write to it

; USER() can take one argument, returns value

; dump with od -t u1 ./ANDOR

VARPNTL = $83
VARPNTH = $84


FRMEVL = $DD7B
GETADDR= $E752
CHKCOM = $DEBE
SNGFLT = $E301
PTRGET = $DFE3	; returns pointer to variable in VARPNT and (Y,A)
MOVMF  = $EB2B

andor:
	jsr	FRMEVL		; 20 7B DD  (or FRMNUM) 20 67 DD   value->FAC
	jsr	GETADDR		; 20 52 E7  FAC-> LINNUM ($50/$51)
	jsr	CHKCOM		; 20 BE DE  move past comma
	lda	$50
	sta	$24

	jsr	FRMEVL		; 20 7B DD  (or FRMNUM) 20 67 DD   value->FAC
	jsr	GETADDR		; 20 52 E7  FAC-> LINNUM ($50/$51)
	jsr	CHKCOM		; 20 BE DE  move past comma
	lda	$50		; A5 50
	sta	$25		; 85 50

	jsr	FRMEVL		; 20 7B DD  (or FRMNUM) 20 67 DD   value->FAC
	jsr	GETADDR		; 20 52 E7  FAC-> LINNUM ($50/$51)
	jsr	CHKCOM		; 20 BE DE  move past comma

	lda	$24		; A5 24
	ora	$25		; 05 25
	and	$50		; 25 50
	sta	$24

	jsr	PTRGET		; 20 E3 DF
	ldy	$24		; A8
	jsr	SNGFLT		; 20 01 E3  unsigned Y -> FAC

	ldx	VARPNTL		;VARPNT
	ldy	VARPNTH		;VARPNT+1
	jmp	MOVMF

