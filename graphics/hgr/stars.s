GBASL = $26
GBASH = $27
HGRPAGE = $E6

PAGE0           =       $C054
PAGE1           =       $C055

HGR = $F3E2
HGR2 = $F3D8
HCLR	= $F3F2
HPOSN	= $F411
WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

stars:
	jsr	HGR
	jsr	HGR2
;	lda	#0
;	sta	ybase
	lda	#$20
	sta	HGRPAGE

move_stars:
	lda	HGRPAGE
	cmp	#$20
	beq	show_page1
show_page2:
	bit	PAGE1
	lsr	HGRPAGE
	bne	doit

show_page1:
	bit	PAGE0
	asl	HGRPAGE

doit:
	jsr	HCLR

	; FORI=1TO10
	; A=X(I)
	; B=Y(I)
	; C=Z(I)*.1
	; X(I)=A+(A-140)*C
	; Y(I)=B+(B-96)*C
	; Z(I)=Z(I)+.1
	; IFX(I)<0ORX(I)>279ORY(I)<0ORY(I)>191THENX(I)=RND(1)*280:Y(I)=RND(1)*192:Z(I)=0:GOTO7
	;HPLOTA,BTOX(I),Y(I)
	;NEXTI

	jmp	move_stars
