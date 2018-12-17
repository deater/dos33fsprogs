wide_flame0:
	.byte $2,$3
	.byte $dd,$dd
	.byte $dd,$dd
	.byte $dd,$dd
	; 00=0 0X=0 X0=0 XX=6 
	; = 33 + Y*(52)+ [30A + 64B + 69C + 54D]-Y
	; = 33 + 3*52 + 30*0 + 64*0 + 69*0 + 54*6 - 3
	; = 510

wide_flame1:
	.byte $2,$3
	.byte $dd,$dd
	.byte $dd,$dd
	.byte $9d,$9d
	; 00=0 0X=0 X0=0 XX=6 
	; = 33 + Y*(52)+ [30A + 64B + 69C + 54D]-Y
	; = 33 + 3*52 + 30*0 + 64*0 + 69*0 + 54*6 - 3
	; = 510

wide_flame2:
	.byte $2,$3
	.byte $dd,$dd
	.byte $dd,$dd
	.byte $99,$99
	; 00=0 0X=0 X0=0 XX=6 
	; = 33 + Y*(52)+ [30A + 64B + 69C + 54D]-Y
	; = 33 + 3*52 + 30*0 + 64*0 + 69*0 + 54*6 - 3
	; = 510

wide_flame3:
	.byte $2,$3
	.byte $dd,$dd
	.byte $dd,$dd
	.byte $d9,$d9
	; 00=0 0X=0 X0=0 XX=6 
	; = 33 + Y*(52)+ [30A + 64B + 69C + 54D]-Y
	; = 33 + 3*52 + 30*0 + 64*0 + 69*0 + 54*6 - 3
	; = 510


flame0:
	.byte $1,$3
	.byte $dd
	.byte $dd
	.byte $dd
	; 00=0 0X=0 X0=0 XX=3 
	; = 33 + Y*(52)+ [30A + 64B + 69C + 54D]-Y
	; = 33 + 3*52 + 30*0 + 64*0 + 69*0 + 54*3 - 3
	; = 348

flame1:
	.byte $1,$3
	.byte $dd
	.byte $dd
	.byte $99
	; 00=0 0X=0 X0=0 XX=3 
	; = 33 + Y*(52)+ [30A + 64B + 69C + 54D]-Y
	; = 33 + 3*52 + 30*0 + 64*0 + 69*0 + 54*3 - 3
	; = 348

flame2:
	.byte $1,$3
	.byte $dd
	.byte $dd
	.byte $d9
	; 00=0 0X=0 X0=0 XX=3 
	; = 33 + Y*(52)+ [30A + 64B + 69C + 54D]-Y
	; = 33 + 3*52 + 30*0 + 64*0 + 69*0 + 54*3 - 3
	; = 348

flame3:
	.byte $1,$3
	.byte $dd
	.byte $dd
	.byte $9d
	; 00=0 0X=0 X0=0 XX=3 
	; = 33 + Y*(52)+ [30A + 64B + 69C + 54D]-Y
	; = 33 + 3*52 + 30*0 + 64*0 + 69*0 + 54*3 - 3
	; = 348


