LEN = $ff

load:
	ldx	#1
sub_loop:
	lda	string,X
	cmp	#' '
	beq	done_sub_loop
;	sty	LEN
;nolen:
	sec
	sbc	#'#'
	sta	string,X
	inx
	bne	sub_loop

done_sub_loop:

;	ldx	LEN
	inx
	ldy	#1	; make Y 1
hard_loop:
;	cpy	LEN
;	bcs	all_done

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
