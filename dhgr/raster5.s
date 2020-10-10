

	ldy	#0
loop:
	lda	offset,Y
	asl
	asl

1 DEFFNP(X)=PEEK(800+I)-32
2 J=0:FORI=0TO119STEP4
3 POKE768+J,FNP(0)*4+FNP(1)/16
4 POKE769+J,FNP(1)*16+FMP(3)/4)
5 POKE770+J,FNP(3)*64+FNP(4)
6 J=J+3
	iny
	bne	loop
	jmp	$300


offset:
.byte "(.CS(-;SC5? C0/ C0# 1NF@9*H (#P#J0$@, ",34
.byte "8, ')0+P(HL(LHH*.+0 8R-3CA?^8212HJ0&%_:G]R0&0 D(#*0 89?^JO7X#A?^82.G]H@",34
.byte "@ ",34
.byte "@1]*@GC57 ('P#C57 ('P#B!3Q:*K&_13+8*G_D2G)@",34
.byte "G_8  1(CP W>O_8!8 "

