.org 300

FRMEVL = $DD7B
GETADDR= $E752
CHKCOM = $DEBE
SNGFLT = $E301

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

	lda	$50		; A5 50
	ora	$24		; 05 24
	and	$25		; 25 25
	tay			; A8
	jmp	SNGFLT		; 20 01 E3  unsigned Y -> FAC

