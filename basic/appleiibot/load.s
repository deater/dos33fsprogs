string = $86A
;size = 65
size=117

load:
	ldx	#0
sub_loop:
	lda	string,X
	bmi	all_done		; goes off end, do we care?

	asl
	asl
	asl
	eor	string+size,X
	sta	$C00,X
	inx
	bne	sub_loop
all_done:
	jmp	$c00

;string:
.byte 34,"MBPMBPLFW]WZMYJW]JXLLLW\LEVHIVHZHAKANI^MMH]_OIZMYJTPLJSNQH_H]H[HSD@@DB@@@DAGAB@@CAFEE@BD@G@@EB@D@BAE@@BA@AGBEADA@@@FFE@E@E@C@B@A@E",80


