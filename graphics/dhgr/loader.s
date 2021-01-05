;	XX012345 XX67ABCD XXEFGH01 XX234567
;	XX012345 XX67ABCD XXEFGH01 XX234567
;	XX012345 XX67ABCD XXEFGH01 XX234567
	a	b		c	d

a*4+b/16
b*16+c/4
c*64+d


loader:

	ldy	#0		; 2
loop:
	rol	offset+1,Y	;	XX0123456 X789ABCX XXEFGHIJ XXKLMNOP
	rol	offset+1,Y	;	XX0123456 789ABCXX XXEFGHIJ XXKLMNOP
	rol	offset+1,Y
	rol	offset,Y	;	X01234567 89ABCXXX XXEFGHIJ XXKLMNOP
	rol	offset,Y;	;	012345678 9ABCXXXX XXEFGHIJ XXKLMNOP
	rol	offset+1,Y
	rol	offset,Y
	iny
	bne	loop

	jmp	





offset:
.byte "(.CS(-;SC5? C0/ C0# 1NF@9*H (#P#J0$@, "
.byte 34,"8, ')0+P(HL(LHH*.+0 8R-3CA?^8212HJ0&%_:G]R0&0 D(#*0 89?^JO7X#A"
.byte "?^82.G]H@",34,"@ ",34,"@1]*@GC57 ('P#C57 ('P#B!3Q:*K&_13+8*G_D2G)@"
.byte 34,"G_8  1(CP W>O_8!8 "

