;                 35..96
;
;		= 35<<2 + 35 = 175	235
;		= 40<<2 + 35 = 195	4
;		= 50<<2 + 35 = 235	39
;		= 60<<2 + 35 = 19	79
;		= 64<<2 + 35 = 35	95



;				35	96
;		= 35<<1 + 35 = 105	166
;		= 45<<1 + 35 = 125	186
;		= 55<<1 + 35 = 145	206
		= 95<<1	+ 35 = 225	29


; 32..96                   
; <<
; add
;         1
;         2631
;         8426 8421
; 4 bits  0XXX X000  so 
;		..95
load:
	ldx	#1
sub_loop:
	lda	string,X
	bmi	done_sub_loop
	sec
	sbc	#'#'
	

done_sub_loop:

	inx
	ldy	#1	; make Y 1
hard_loop:

	lda	string,X	; a=buf[len+x+1];
	bmi	all_done
	sec
	sbc	#'#'

	stx	$FE
	ldx	#3

inner_loop:
	asl
	asl
	pha
	and	#$c0
	ora	string,Y
	sta	$2FF,Y
	pla
	iny

	dex
	bne	inner_loop

	ldx	$FE

	inx
	jmp	hard_loop

all_done:
	jmp	$300

string:
.byte 34,"O3#O5#CS_Lb4M+3^L9(HCE_CJKS(-S'3%,@+S-TKL*M`\&4K+3I)H3@S0#^#M#<#@ ***Q+[C1*&+4%#K+FSV+E/",$80
