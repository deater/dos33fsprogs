LEN = $ff

load:
	ldy	#1
sub_loop:
	lda	string,Y
	bmi	done_sub_loop
	cmp	#' '
	bne	nolen
	sty	LEN
nolen:
	sec
	sbc	#'#'
	sta	string,Y
	iny
	jmp	sub_loop

done_sub_loop:

	ldx	LEN
	inx
	ldy	#1
hard_loop:
	cpy	LEN
	bcs	all_done

	lda	string,X	; a=buf[len+x+1];
;	lda	#00
	asl
	asl
	pha
	and	#$c0
	ora	string,Y
	sta	$2FF,Y
	pla
	iny

	asl
	asl
	pha
	and	#$c0
	ora	string,Y
	sta	$2FF,Y
	pla
	iny

	asl
	asl
	pha
	and	#$c0
	ora	string,Y
	sta	$2FF,Y
	pla
	iny

				; out[i]=buf[i]|((a<<2)&0xc0);
				; out[i+1]=buf[i+1]|((a<<4)&0xc0);
				; out[i+2]=buf[i+2]|((a<<6)&0xc0);
	inx
	jmp	hard_loop

all_done:
	jmp	$300

string:
.byte 34,"O3#O5#CS_Lb4M+3^L9(HCE_CJKS(-S'3%,@+S-TKL*M`\&4K+3I)H3@S0#^#M#<#@ ***Q+[C1*&+4%#K+FSV+E/",$80
