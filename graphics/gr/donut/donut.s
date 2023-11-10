; donut
; based on donut code by @a1k0n

; zero-page
GBASL	=	$26
GBASH	=	$27

sB_l	=	$70
sB_h	=	$71
cB_l	=	$72
cB_h	=	$73
sA_l	=	$74
sA_h	=	$75
cA_l	=	$76
cA_h	=	$77
sAsB_l	=	$78
sAsB_h	=	$79
cAsB_l	=	$7A
cAsB_h	=	$7B
sAcB_l	=	$7C
sAcB_h	=	$7D
cAcB_l	=	$7E
cAcB_h	=	$7F

r1i_l	=	$80
r1i_h	=	$81
r2i_l	=	$82
r2i_h	=	$83
p0x_l	=	$84
p0x_h	=	$85
p0y_l	=	$86
p0y_h	=	$87
p0z_l	=	$88
p0z_h	=	$89
yincC_l	=	$8A
yincC_h	=	$8B
yincS_l	=	$8C
yincS_h	=	$8D
xincX_l	=	$8E
xincX_h	=	$8F
xincY_l	=	$90
xincY_h	=	$91
xincZ_l	=	$92
xincZ_h	=	$93
ycA_l	=	$94
ycA_h	=	$95
ysA_l	=	$96
ysA_h	=	$97
xsAsB_l	=	$98
xsAsB_h	=	$99
xcAsB_l	=	$9A
xcAsB_h	=	$9B
vxi14_l	=	$9C
vxi14_h	=	$9D
vyi14_l	=	$9E
vyi14_h	=	$9F
vzi14_l	=	$A0
vzi14_h	=	$A1
t_l	=	$A2
t_h	=	$A3
px_l	=	$A4
px_h	=	$A5
py_l	=	$A6
py_h	=	$A7
pz_l	=	$A8
pz_h	=	$A9
lx0_l	=	$AA
lx0_h	=	$AB
ly0_l	=	$AC
ly0_h	=	$AD
lz0_l	=	$AE
lz0_h	=	$AF
t0_l	=	$B0
t0_h	=	$B1
t1_l	=	$B2
t1_h	=	$B3
t2_l	=	$B4
t2_h	=	$B5
d_l	=	$B6
d_h	=	$B7
lx_l	=	$B8
lx_h	=	$B9
ly_l	=	$BA
ly_h	=	$BB
lz_l	=	$BC
lz_h	=	$BD
n_l	=	$BE
n_h	=	$BF
dx_l	=	$C0
dx_h	=	$C1
dy_l	=	$C2
dy_h	=	$C3
dz_l	=	$C4
dz_h	=	$C5
a_l	=	$C6
a_h	=	$C7
b_l	=	$C8
b_h	=	$C9
c_l	=	$CA
c_h	=	$CB
arg1_l	=	$CC
arg1_h	=	$CD
arg2_l	=	$CE
arg2_h	=	$CF
arg3_l	=	$D0
arg3_h	=	$D1
arg4_l	=	$D2
arg4_h	=	$D3

CTEMP1_L	=	$D4
CTEMP1_H	=	$D5
CTEMP2_L	=	$D6
CTEMP2_H	=	$D7
CTEMP3_L	=	$D8
CTEMP3_H	=	$D9
CTEMP4_L	=	$DA
CTEMP4_H	=	$DB



TEMP1_L	=	$F0
TEMP1_H	=	$F1
TEMP2_L	=	$F2
TEMP2_H	=	$F3

XX	=	$F4
YY	=	$F5
II	=	$F6

; soft-switches
FULLGR  =       $C052

; ROM routines
PLOT	=	$F800   ;; PLOT AT Y,A
SETGR	=	$FB40


donut:
	jsr	SETGR
	bit	FULLGR

init_vars:
	; high-precision rotation directions
	; sines and cosines and their products

	; int16_t sB = 0, cB = 16384;
	lda	#0
	sta	sB_l
	sta	sB_h
	lda	#<16384
	sta	cB_l
	lda	#>16384
	sta	cB_h

	; int16_t sA = 11583, cA = 11583;
	lda	#<11583
	sta	sA_l
	sta	cA_l
	lda	#>11583
	sta	sA_h
	sta	cA_h

	; int16_t sAsB = 0, cAsB = 0;
	lda	#<0
	sta	sAsB_l
	sta	cAsB_l
	lda	#>0
	sta	sAsB_h
	sta	cAsB_h

	; int16_t sAcB = 11583, cAcB = 11583;

	lda	#<11583
	sta	sAcB_l
	sta	cAcB_l
	lda	#>11583
	sta	sAcB_h
	sta	cAcB_h

	; FIXME: propogate
	; const int16_t r1i = 256;
	; const int16_t r2i = 2*256;
	lda	#<256
	sta	r1i_l
	lda	#>256
	sta	r1i_h

	lda	#<512
	sta	r2i_l
	lda	#>512
	sta	r2i_h

main_loop:
	; int16_t p0x = (sB + (sB<<2)) >> 6;

	lda	sB_l		; p0x = SB
	sta	p0x_l
	lda	sB_h
	sta	p0x_h

	asl	p0x_l		; p0x = SB<<1
	rol	p0x_h
	asl	p0x_l		; p0x = SB<<2
	rol	p0x_h

	clc			; p0x = SB + (SB<<2)
	lda	p0x_l
	adc	sB_l
	sta	p0x_l
	lda	p0x_h
	adc	sB_h
	sta	p0x_h

	ldx	#6		; p0x = (SB + (SB<<2)) >> 6
p1:
	lda	p0x_h
;	cmp	#$80
;	ror
;	sta	p0x_h

	lsr	p0x_h

	ror	p0x_l
	dex
	bne	p1

	; int16_t p0y = (sAcB + (sAcB<<2)) >> 6;

	; urgh math is done in 32-bit before casting down to 16

	lda	sAcB_l
	sta	p0y_l
	lda	sAcB_h
	sta	p0y_h

	asl	p0y_l	; 2d3f*5 = e23b / 0x40 = 388
	rol	p0y_h
	asl	p0y_l	; expect 0x388
	rol	p0y_h

	clc
	lda	p0y_l
	adc	sAcB_l
	sta	p0y_l
	lda	p0y_h
	adc	sAcB_h
	sta	p0y_h

	ldx	#6
p2:
;	lda	p0y_h
;	cmp	#$80
;	ror
;	sta	p0y_h

	lsr	p0y_h
	ror	p0y_l
	dex
	bne	p2

	; int16_t p0z = (- (cAcB +(cAcB<<2))) >> 6;

	lda	cAcB_l
	sta	p0z_l
	lda	cAcB_h
	sta	p0z_h

	asl	p0z_l
	rol	p0z_h
	asl	p0z_l
	rol	p0z_h

	clc
	lda	p0z_l
	adc	cAcB_l
	sta	p0z_l
	lda	p0z_h
	adc	cAcB_h
	sta	p0z_h


	ldx	#6
p3:
;	lda	p0z_h
;	cmp	#$80
;	ror
;	sta	p0z_h

	lsr	p0z_h
	ror	p0z_l
	dex
	bne	p3

	; negate
	sec
	lda	#0
	sbc	p0z_l
	sta	p0z_l
	lda	#0
	sbc	p0z_h
	sta	p0z_h


	;========================================
	; int16_t yincC = (cA >> 6) + (cA >> 5);
	;  tested: OK

	lda	cA_l		; TEMP1 = cA
	sta	TEMP1_L
	lda	cA_h
	sta	TEMP1_H

	ldx	#5		; TEMP1 = (cA>>5)
p4:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	p4

	lda	TEMP1_L		; TEMP2 = (cA>>6)
	sta	TEMP2_L
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP2_H
	ror	TEMP2_L

	clc			; yincC = TEMP1+TEMP2
	lda	TEMP2_L
	adc	TEMP1_L
	sta	yincC_l
	lda	TEMP2_H
	adc	TEMP1_H
	sta	yincC_h

	;========================================
	; int16_t yincS = (sA >> 6) + (sA >> 5);
	;   tested: OK

	lda	sA_l
	sta	TEMP1_L
	lda	sA_h
	sta	TEMP1_H

	ldx	#5
p5:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	p5


	lda	TEMP1_L
	sta	TEMP2_L
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP2_H
	ror	TEMP2_L

	clc
	lda	TEMP2_L
	adc	TEMP1_L
	sta	yincS_l
	lda	TEMP2_H
	adc	TEMP1_H
	sta	yincS_h

	;=========================================
	; int16_t xincX = (cB >> 7) + (cB >> 6);
	;	CB = $72	xincX= 8E
	; Tested: OK

	lda	cB_l		; TEMP1 = CB
	sta	TEMP1_L
	lda	cB_h
	sta	TEMP1_H

	ldx	#6		; TEMP1 = CB>>6
p6:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	p6

	lda	TEMP1_L		; TEMP2 = CB>>7
	sta	TEMP2_L
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP2_H
	ror	TEMP2_L

	clc			; xincx = TEMP1+TEMP2
	lda	TEMP2_L
	adc	TEMP1_L
	sta	xincX_l
	lda	TEMP2_H
	adc	TEMP1_H
	sta	xincX_h

	;===========================================
	; int16_t xincY = (sAsB >> 7) + (sAsB >> 6);

	lda	sAsB_l
	sta	TEMP1_L
	lda	sAsB_h
	sta	TEMP1_H

	ldx	#6
p7:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	p7


	lda	TEMP1_L
	sta	TEMP2_L
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP2_H
	ror	TEMP2_L

	clc
	lda	TEMP2_L
	adc	TEMP1_L
	sta	xincY_l
	lda	TEMP2_H
	adc	TEMP1_H
	sta	xincY_h

	;===========================================
	; int16_t xincZ = (cAsB >> 7) + (cAsB >> 6);

	lda	cAsB_l
	sta	TEMP1_L
	lda	cAsB_h
	sta	TEMP1_H

	ldx	#6
p8:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	p8


	lda	TEMP1_L
	sta	TEMP2_L
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP2_H
	ror	TEMP2_L

	clc
	lda	TEMP2_L
	adc	TEMP1_L
	sta	xincZ_l
	lda	TEMP2_H
	adc	TEMP1_H
	sta	xincZ_h

	;========================================
	; int16_t ycA = -((cA >> 1) + (cA >> 4));
	;	ycA = $94
	; tested: OK

	lda	cA_l		; TEMP1 = CA
	sta	TEMP1_L
	lda	cA_h
	sta	TEMP1_H

	cmp	#$80		; TEMP1 = CA>>1
	ror
	sta	TEMP1_H
	ror	TEMP1_L

	lda	TEMP1_L		; TEMP2 = CA>>1
	sta	TEMP2_L
	lda	TEMP1_H
	sta	TEMP2_H

	ldx	#3		; TEMP2 = CA>>4
p9:
	lda	TEMP2_H
	cmp	#$80
	ror
	sta	TEMP2_H
	ror	TEMP2_L
	dex
	bne	p9

	; add
	clc			; yCA = TEMP1+TEMP2
	lda	TEMP2_L
	adc	TEMP1_L
	sta	ycA_l
	lda	TEMP2_H
	adc	TEMP1_H
	sta	ycA_h

	; negate
	sec			; yCA = -(TEMP1+TEMP2)
	lda	#0
	sbc	ycA_l
	sta	ycA_l
	lda	#0
	sbc	ycA_h
	sta	ycA_h


	;========================================
	; int16_t ysA = -((sA >> 1) + (sA >> 4));

	lda	sA_l
	sta	TEMP1_L
	lda	sA_h
	sta	TEMP1_H

	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L

	lda	TEMP1_L
	sta	TEMP2_L
	lda	TEMP1_H
	sta	TEMP2_H

	ldx	#3
p10:
	lda	TEMP2_H
	cmp	#$80
	ror
	sta	TEMP2_H
	ror	TEMP2_L
	dex
	bne	p10

	; add
	clc
	lda	TEMP2_L
	adc	TEMP1_L
	sta	ysA_l
	lda	TEMP2_H
	adc	TEMP1_H
	sta	ysA_h

	; negate
	sec
	lda	#0
	sbc	ysA_l
	sta	ysA_l
	lda	#0
	sbc	ysA_h
	sta	ysA_h

	;=================================
	; for (int j = 0; j < 23; j++) {
	ldx	#0
	stx	YY
yloop:
	ldx	YY
	lda	gr_offsets_l,X
	sta	GBASL
	lda	gr_offsets_h,X
	sta	GBASH			; TODO: add in page

	;======================================
	; int16_t xsAsB = (sAsB >> 4) - sAsB;  ; -40*xincY
	;  tested: OK

	lda	sAsB_l		; xsAsB = sAsB
	sta	xsAsB_l
	lda	sAsB_h
	sta	xsAsB_h

	ldx	#4
p99:				; xsAsB = sAsB>>4
	lda	xsAsB_h
	cmp	#$80
	ror
	sta	xsAsB_h
	ror	xsAsB_l
	dex
	bne	p99

	sec			; xsAsB = (sAsB>>4)-sAsB
	lda	xsAsB_l
	sbc	sAsB_l
	sta	xsAsB_l
	lda	xsAsB_h
	sbc	sAsB_h
	sta	xsAsB_h


	; int16_t xcAsB = (cAsB >> 4) - cAsB;  ; -40*xincZ;

	lda	cAsB_l
	sta	xcAsB_l
	lda	cAsB_h
	sta	xcAsB_h

	ldx	#4
p98:
	lda	xcAsB_h
	cmp	#$80
	ror
	sta	xcAsB_h
	ror	xcAsB_l
	dex
	bne	p98

	sec
	lda	xcAsB_l
	sbc	cAsB_l
	sta	xcAsB_l
	lda	xcAsB_h
	sbc	cAsB_h
	sta	xcAsB_h

	;==============================
	; int16_t vxi14 = (cB >> 4) - cB - sB; ; -40*xincX - sB;
	;	cxi14 = $9C
	; tested OK

	lda	cB_l		; vxi14 = cB
	sta	vxi14_l
	lda	cB_h
	sta	vxi14_h

	ldx	#4		; vxi14 = (cB>>4)
p97:
	lda	vxi14_h
	cmp	#$80
	ror
	sta	vxi14_h
	ror	vxi14_l
	dex
	bne	p97

	sec			; vxi14 = (cb>>4) - CB
	lda	vxi14_l
	sbc	cB_l
	sta	vxi14_l
	lda	vxi14_h
	sbc	cB_h
	sta	vxi14_h

	sec			; cxi14 = (cb>>4) - CB - SB
	lda	vxi14_l
	sbc	sB_l
	sta	vxi14_l
	lda	vxi14_h
	sbc	sB_h
	sta	vxi14_h

	; int16_t vyi14 = ycA - xsAsB - sAcB;
	sec
	lda	ycA_l		; vyi14 = yCA - xsAsB
	sbc	xsAsB_l
	sta	vyi14_l
	lda	ycA_h
	sbc	xsAsB_h
	sta	vyi14_h

	sec			; vyi14 = yCA - xsAsB - sAcB
	lda	vyi14_l
	sbc	sAcB_l
	sta	vyi14_l
	lda	vyi14_h
	sbc	sAcB_h
	sta	vyi14_h

	; int16_t vzi14 = ysA + xcAsB + cAcB;

	clc			; vzi14 = ysA + xcAsB
	lda	ysA_l
	adc	xcAsB_l
	sta	vzi14_l
	lda	ysA_h
	adc	xcAsB_h
	sta	vzi14_h

	clc			; vzi14 = ysA + xcAsB + cAcB
	lda	vzi14_l
	adc	cAcB_l
	sta	vzi14_l
	lda	vzi14_h
	adc	cAcB_h
	sta	vzi14_h


	; for (int i = 0; i < 79; i++) {
	ldy	#0
	sty	XX
xloop:

	; int16_t t = 512;
	lda	#$2
	sta	t_h
	lda	#0
	sta	t_l

	; int16_t px = p0x + (vxi14 >> 5);

	lda	vxi14_l		; px = (vxi14)
	sta	px_l
	lda	vxi14_h
	sta	px_h

	ldx	#5		; px = (vxi14>>5)
p96:
	lda	px_h
	cmp	#$80
	ror
	sta	px_h
	ror	px_l
	dex
	bne	p96

	clc			; px = p0x + (vxi14>>5)
	lda	px_l
	adc	p0x_l
	sta	px_l
	lda	px_h
	adc	p0x_h
	sta	px_h

	; int16_t py = p0y + (vyi14 >> 5);

	lda	vyi14_l
	sta	py_l
	lda	vyi14_h
	sta	py_h

	ldx	#5
p95:
	lda	py_h
	cmp	#$80
	ror
	sta	py_h
	ror	py_l
	dex
	bne	p95

	clc
	lda	py_l
	adc	p0y_l
	sta	py_l
	lda	py_h
	adc	p0y_h
	sta	py_h

	; int16_t pz = p0z + (vzi14 >> 5);

	lda	vzi14_l
	sta	pz_l
	lda	vzi14_h
	sta	pz_h

	ldx	#5
p94:
	lda	pz_h
	cmp	#$80
	ror
	sta	pz_h
	ror	pz_l
	dex
	bne	p94

	clc
	lda	pz_l
	adc	p0z_l
	sta	pz_l
	lda	pz_h
	adc	p0z_h
	sta	pz_h

	; int16_t lx0 = sB >> 2;

	lda	sB_l
	sta	lx0_l
	lda	sB_h
	sta	lx0_h

	ldx	#2
p93:
	lda	lx0_h
	cmp	#$80
	ror
	sta	lx0_h
	ror	lx0_l
	dex
	bne	p93

	; int16_t ly0 = (sAcB - cA) >> 2;

	sec
	lda	sAcB_l
	sbc	cA_l
	sta	ly0_l
	lda	sAcB_h
	sbc	cA_h
	sta	ly0_h

	ldx	#2
p92:
	lda	ly0_h
	cmp	#$80
	ror
	sta	ly0_h
	ror	ly0_l
	dex
	bne	p92


	; int16_t lz0 = (-cAcB - sA) >> 2;

	; negate
	sec			; lz0 = -cAcB
	lda	#0
	sbc	cAcB_l
	sta	lz0_l
	lda	#0
	sbc	cAcB_h
	sta	lz0_h

	sec			; lz0 = (-cAcB - sA)
	lda	lz0_l
	sbc	sA_l
	sta	lz0_l
	lda	lz0_h
	sbc	sA_h
	sta	lz0_h

	ldx	#2
p91:
	lda	lz0_h
	cmp	#$80
	ror
	sta	lz0_h
	ror	lz0_l
	dex
	bne	p91


color_loop:
	;=========================================
	; int16_t lx = lx0, ly = ly0, lz = lz0;
	;	AA, AC ,AE
	; Tested OK!

	lda	lx0_l
	sta	lx_l
	lda	lx0_h
	sta	lx_h

	lda	ly0_l
	sta	ly_l
	lda	ly0_h
	sta	ly_h

	lda	lz0_l
	sta	lz_l
	lda	lz0_h
	sta	lz_h

	;=====================================
	; t0 = length_cordic(px, py, &lx, ly);
	;	px=A4, py=A6
	; TEST OK!

	lda	px_l
	sta	arg1_l
	lda	px_h
	sta	arg1_h

	lda	py_l
	sta	arg2_l
	lda	py_h
	sta	arg2_h

	lda	lx_l
	sta	arg3_l
	lda	lx_h
	sta	arg3_h

	lda	ly_l
	sta	arg4_l
	lda	ly_h
	sta	arg4_h

	jsr	length_cordic

	;===========================
	; T0 = $B0
	;	check OK!

	lda	arg1_l
	sta	t0_l
	lda	arg1_h
	sta	t0_h

	lda	arg3_l
	sta	lx_l
	lda	arg3_h
	sta	lx_h


	;===============
	; t1 = t0 - r2i;
	;	t1=$B2
	; TESTED OK

	sec
	lda	t0_l
	sbc	r2i_l
	sta	t1_l
	lda	t0_h
	sbc	r2i_h
	sta	t1_h


	;=====================================
	; t2 = length_cordic(pz, t1, &lz, lx);
	;	PZ=$A8 LZ=$BC
	; TESTED: PZ is off by 1

	lda	pz_l
	sta	arg1_l
	lda	pz_h
	sta	arg1_h

	lda	t1_l
	sta	arg2_l
	lda	t1_h
	sta	arg2_h

	lda	lz_l
	sta	arg3_l
	lda	lz_h
	sta	arg3_h

	lda	lx_l
	sta	arg4_l
	lda	lx_h
	sta	arg4_h

	jsr	length_cordic

	;========================
	; after
	;	check arg1=$CC arg3=$D0
	;	T2=B4 LZ=BC
	; TEST OK

	lda	arg1_l
	sta	t2_l
	lda	arg1_h
	sta	t2_h

	lda	arg3_l
	sta	lz_l
	lda	arg3_h
	sta	lz_h

	;==============
	; d = t2 - r1i;
	; TEST: ok
	sec
	lda	t2_l
	sbc	r1i_l
	sta	d_l
	lda	t2_h
	sbc	r1i_h
	sta	d_h


	;========
	; t += d;

	clc
	lda	t_l
	adc	d_l
	sta	t_l
	lda	t_h
	adc	d_h
	sta	t_h

	; check if too far

	; T in $A2, D in $B6
	;	CORRECT

check_t:
	lda	t_h			; if (t > 8*256)
	cmp	#8
	bcc	check_d

	lda	#0			; black
	beq	do_plot_color		; bra

check_d:
	lda	d_l	; if (d<2)
	cmp	#2	; 16-bit signed compare
	lda	d_h
	sbc	#0
	bvc	label
	eor	#$80
label:
	; if N=1 then less

	bpl	skip_plot		; bge

	;int N = lz >> 9;
	lda	lz_h
	cmp	#$80
	ror

	tax
	bmi	n_negative
	cpx	#12
	bcc	do_plot		; blt
	; if (N>11) N=11;
	ldx	#11
	bne	do_plot		; bra

n_negative:
	; if (N<0) N=0;
	ldx	#0

;	beq	do_plot		; bra

	; fall through
do_plot:
	lda	colors,X
do_plot_color:
	; T=A2
	pha
	lda	XX
	lsr
	tay
	pla
	sta	(GBASL),Y

	jmp	done_color

skip_plot:

	; 11x1.14 fixed point 3x parallel multiply
	; only 16 bit registers needed; starts from highest bit to lowest
	; d is about 2..1100, so 11 bits are sufficient

	; int16_t dx = 0, dy = 0, dz = 0;
	lda	#0
	sta	dx_l
	sta	dx_h
	sta	dy_l
	sta	dy_h
	sta	dz_l
	sta	dz_h

	; int16_t a = vxi14, b = vyi14, c = vzi14;
	lda	vxi14_l
	sta	a_l
	lda	vxi14_h
	sta	a_h

	lda	vyi14_l
	sta	b_l
	lda	vyi14_h
	sta	b_h

	lda	vzi14_l
	sta	c_l
	lda	vzi14_h
	sta	c_h

	; check a,b,c = c6, c8, cA
	; TEST: OK

mul_loop:
	lda	d_h			; while(d)
	bne	cont_mul_loop
	lda	d_l
	beq	done_mul_loop
cont_mul_loop:
	lda	d_h
	and	#(4)		; if (d&1024) {
	beq	not_1023

	; dx += a;
	clc
	lda	dx_l
	adc	a_l
	sta	dx_l
	lda	dx_h
	adc	a_h
	sta	dx_h

	; dy += b;
	clc
	lda	dy_l
	adc	b_l
	sta	dy_l
	lda	dy_h
	adc	b_h
	sta	dy_h

	; dz += c;
	clc
	lda	dz_l
	adc	c_l
	sta	dz_l
	lda	dz_h
	adc	c_h
	sta	dz_h

not_1023:
	; d = (d&1023) << 1;
	lda	d_h
	and	#$3
	sta	d_h

	asl	d_l	; d<<=1
	rol	d_h

	; a >>= 1;

	lda	a_h
	cmp	#$80
	ror
	sta	a_h
	ror	a_l

	; b >>= 1;

	lda	b_h
	cmp	#$80
	ror
	sta	b_h
	ror	b_l

	; c >>= 1;

	lda	c_h
	cmp	#$80
	ror
	sta	c_h
	ror	c_l

	jmp	mul_loop
done_mul_loop:

	; we already shifted down 10 bits, so get the last four
	; DX=C0 / C2 / C4
	; px=A4 / a6 / a8
	; TEST: GOOD

	; px += dx >> 4;

	lda	dx_l
	sta	TEMP1_L
	lda	dx_h
	sta	TEMP1_H

	ldx	#4
p90:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	p90

	clc
	lda	px_l
	adc	TEMP1_L
	sta	px_l
	lda	px_h
	adc	TEMP1_H
	sta	px_h

	;===================
	; py += dy >> 4;

	lda	dy_l
	sta	TEMP1_L
	lda	dy_h
	sta	TEMP1_H

	ldx	#4
p89:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	p89

	clc
	lda	py_l
	adc	TEMP1_L
	sta	py_l
	lda	py_h
	adc	TEMP1_H
	sta	py_h

	; pz += dz >> 4;

	lda	dz_l
	sta	TEMP1_L
	lda	dz_h
	sta	TEMP1_H

	ldx	#4
p88:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	p88

	clc
	lda	pz_l
	adc	TEMP1_L
	sta	pz_l
	lda	pz_h
	adc	TEMP1_H
	sta	pz_h

	; AFTER
	; px=ok, py=unchanged?

	jmp	color_loop
done_color:

	; vxi14 += xincX;
	clc
	lda	vxi14_l
	adc	xincX_l
	sta	vxi14_l
	lda	vxi14_h
	adc	xincX_h
	sta	vxi14_h

	; vyi14 -= xincY;
	sec
	lda	vyi14_l
	sbc	xincY_l
	sta	vyi14_l
	lda	vyi14_h
	sbc	xincY_h
	sta	vyi14_h

	; vzi14 += xincZ;
	clc
	lda	vzi14_l
	adc	xincZ_l
	sta	vzi14_l
	lda	vzi14_h
	adc	xincZ_h
	sta	vzi14_h


	inc	XX
	ldy	XX
	cpy	#79
	beq	done_xloop
	jmp	xloop

done_xloop:

	;==============
	; ycA += yincC;

	clc
	lda	ycA_l
	adc	yincC_l
	sta	ycA_l
	lda	ycA_h
	adc	yincC_h
	sta	ycA_h

	;===============
	; ysA += yincS;

	clc
	lda	ysA_l
	adc	yincS_l
	sta	ysA_l
	lda	ysA_h
	adc	yincS_h
	sta	ysA_h

	inc	YY
	lda	YY
	cmp	#24
	beq	done_yloop

	jmp	yloop

done_yloop:

rotate:

	; rotate sines, cosines, and products thereof
	; this animates the torus rotation about two axes

	;===============
	; cA-=(sA>>5);

	lda	sA_l
	sta	TEMP1_L
	lda	sA_h
	sta	TEMP1_H

	ldx	#5
zp1:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	zp1

	sec
	lda	cA_l
	sbc	TEMP1_L
	sta	cA_l
	lda	cA_h
	sbc	TEMP1_H
	sta	cA_h

	;==============
	; sA+=(cA>>5);

	lda	cA_l
	sta	TEMP1_L
	lda	cA_h
	sta	TEMP1_H

	ldx	#5
zp2:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	zp2

	clc
	lda	sA_l
	adc	TEMP1_L
	sta	sA_l
	lda	sA_h
	adc	TEMP1_H
	sta	sA_h

	;==================
	; cAsB-=(sAsB>>5);

	lda	sAsB_l
	sta	TEMP1_L
	lda	sAsB_h
	sta	TEMP1_H

	ldx	#5
zp3:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	zp3

	sec
	lda	cAsB_l
	sbc	TEMP1_L
	sta	cAsB_l
	lda	cAsB_h
	sbc	TEMP1_H
	sta	cAsB_h

	;===================
	; sAsB+=(cAsB>>5);

	lda	cAsB_l
	sta	TEMP1_L
	lda	cAsB_h
	sta	TEMP1_H

	ldx	#5
zp4:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	zp4

	clc
	lda	sAsB_l
	adc	TEMP1_L
	sta	sAsB_l
	lda	sAsB_h
	adc	TEMP1_H
	sta	sAsB_h


	;==================
	; cAcB-=(sAcB>>5);

	lda	sAcB_l
	sta	TEMP1_L
	lda	sAcB_h
	sta	TEMP1_H

	ldx	#5
zp5:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	zp5

	sec
	lda	cAcB_l
	sbc	TEMP1_L
	sta	cAcB_l
	lda	cAcB_h
	sbc	TEMP1_H
	sta	cAcB_h


	;=====================
	; sAcB+=(cAcB>>5);

	lda	cAcB_l
	sta	TEMP1_L
	lda	cAcB_h
	sta	TEMP1_H

	ldx	#5
zp6:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	zp6

	clc
	lda	sAcB_l
	adc	TEMP1_L
	sta	sAcB_l
	lda	sAcB_h
	adc	TEMP1_H
	sta	sAcB_h


	;================
	; cB-=(sB>>6);

	lda	sB_l
	sta	TEMP1_L
	lda	sB_h
	sta	TEMP1_H

	ldx	#6
zp7:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	zp7

	sec
	lda	cB_l
	sbc	TEMP1_L
	sta	cB_l
	lda	cB_h
	sbc	TEMP1_H
	sta	cB_h

	;================
	; sB+=(cB>>6);

	lda	cB_l
	sta	TEMP1_L
	lda	cB_h
	sta	TEMP1_H

	ldx	#6
zp8:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	zp8

	clc
	lda	sB_l
	adc	TEMP1_L
	sta	sB_l
	lda	sB_h
	adc	TEMP1_H
	sta	sB_h


	;====================
	; cAcB-=(cAsB>>6);

	lda	cAsB_l
	sta	TEMP1_L
	lda	cAsB_h
	sta	TEMP1_H

	ldx	#6
zp9:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	zp9

	sec
	lda	cAcB_l
	sbc	TEMP1_L
	sta	cAcB_l
	lda	cAcB_h
	sbc	TEMP1_H
	sta	cAcB_h


	;===================
	; cAsB+=(cAcB>>6);

	lda	cAcB_l
	sta	TEMP1_L
	lda	cAcB_h
	sta	TEMP1_H

	ldx	#6
zp10:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	zp10

	clc
	lda	cAsB_l
	adc	TEMP1_L
	sta	cAsB_l
	lda	cAsB_h
	adc	TEMP1_H
	sta	cAsB_h

	;===================
	; sAcB-=(sAsB>>6);

	lda	sAsB_l
	sta	TEMP1_L
	lda	sAsB_h
	sta	TEMP1_H

	ldx	#6
zp11:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	zp11

	sec
	lda	sAcB_l
	sbc	TEMP1_L
	sta	sAcB_l
	lda	sAcB_h
	sbc	TEMP1_H
	sta	sAcB_h


	; sAsB+=(sAcB>>6);

	lda	sAcB_l
	sta	TEMP1_L
	lda	sAcB_h
	sta	TEMP1_H

	ldx	#6
zp12:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	zp12

	clc
	lda	sAsB_l
	adc	TEMP1_L
	sta	sAsB_l
	lda	sAsB_h
	adc	TEMP1_H
	sta	sAsB_h


	; flip pages?




	jmp	main_loop


; CORDIC algorithm to find magnitude of |x,y| by rotating the x,y vector onto
; the x axis. This also brings vector (x2,y2) along for the ride, and writes
; back to x2 -- this is used to rotate the lighting vector from the normal of
; the torus surface towards the camera, and thus determine the lighting amount.
; We only need to keep one of the two lighting normal coordinates.

; ARG1=x,ARG2=y,ARG3=x2,ARG4=y2

; int length_cordic(int16_t x, int16_t y, int16_t *x2_, int16_t y2) {

length_cordic:

	lda	arg1_h	;  if (arg1 < 0) { ; start in right half-plane
	bpl	no_adjust

	; arg1 = -arg1;
	; negate
	sec
	lda	#0
	sbc	arg1_l
	sta	arg1_l
	lda	#0
	sbc	arg1_h
	sta	arg1_h

	; arg3 = -arg3;
	; negate
	sec
	lda	#0
	sbc	arg3_l
	sta	arg3_l
	lda	#0
	sbc	arg3_h
	sta	arg3_h

no_adjust:
	; check here
	;  arg1=CC, CE, D0, D2
	;	TEST OK

	; for (int i = 0; i < 8; i++) {
	lda	#0
	sta	II
cordic_loop:
	; int16_t temp1 = arg1;
	lda	arg1_l
	sta	TEMP1_L
	lda	arg1_h
	sta	TEMP1_H

	; int16_t temp2 = arg3;
	lda	arg3_l
	sta	TEMP2_L
	lda	arg3_h
	sta	TEMP2_H

	; CTEMP1 = arg2>>i

	lda	arg2_l
	sta	CTEMP1_L
	lda	arg2_h
	sta	CTEMP1_H
	ldx	II
	beq	done_pc1
pc1:
	lda	CTEMP1_H
	cmp	#$80
	ror
	sta	CTEMP1_H
	ror	CTEMP1_L
	dex
	bne	pc1
done_pc1:

	; CTEMP2 = temp1>>i

	lda	TEMP1_L
	sta	CTEMP2_L
	lda	TEMP1_H
	sta	CTEMP2_H
	ldx	II
	beq	done_pc2
pc2:
	lda	CTEMP2_H
	cmp	#$80
	ror
	sta	CTEMP2_H
	ror	CTEMP2_L
	dex
	bne	pc2
done_pc2:

	; CTEMP3 = arg4>>i

	lda	arg4_l
	sta	CTEMP3_L
	lda	arg4_h
	sta	CTEMP3_H
	ldx	II
	beq	done_pc3
pc3:
	lda	CTEMP3_H
	cmp	#$80
	ror
	sta	CTEMP3_H
	ror	CTEMP3_L
	dex
	bne	pc3
done_pc3:

	; CTEMP4 = temp2>>i
	lda	TEMP2_L
	sta	CTEMP4_L
	lda	TEMP2_H
	sta	CTEMP4_H
	ldx	II
	beq	done_pc4
pc4:
	lda	CTEMP4_H
	cmp	#$80
	ror
	sta	CTEMP4_H
	ror	CTEMP4_L
	dex
	bne	pc4
done_pc4:

	;=========================

	lda	arg2_h		;    if (arg2 < 0) {
	bpl	cordic_pos
cordic_neg:

	; arg1 -= CTEMP1
	sec
	lda	arg1_l
	sbc	CTEMP1_L
	sta	arg1_l
	lda	arg1_h
	sbc	CTEMP1_H
	sta	arg1_h

	; arg2 += CTEMP2
	clc
	lda	arg2_l
	adc	CTEMP2_L
	sta	arg2_l
	lda	arg2_h
	adc	CTEMP2_H
	sta	arg2_h

	; arg3 -= CTEMP3
	sec
	lda	arg3_l
	sbc	CTEMP3_L
	sta	arg3_l
	lda	arg3_h
	sbc	CTEMP3_H
	sta	arg3_h

	; arg4 += CTEMP4
	clc
	lda	arg4_l
	adc	CTEMP4_L
	sta	arg4_l
	lda	arg4_h
	adc	CTEMP4_H
	sta	arg4_h

	jmp	cordic_if_done
cordic_pos:

	; arg1 += CTEMP1
	clc
	lda	arg1_l
	adc	CTEMP1_L
	sta	arg1_l
	lda	arg1_h
	adc	CTEMP1_H
	sta	arg1_h

	; arg2 -= CTEMP2
	sec
	lda	arg2_l
	sbc	CTEMP2_L
	sta	arg2_l
	lda	arg2_h
	sbc	CTEMP2_H
	sta	arg2_h

	; arg3 += CTEMP3
	clc
	lda	arg3_l
	adc	CTEMP3_L
	sta	arg3_l
	lda	arg3_h
	adc	CTEMP3_H
	sta	arg3_h

	; arg4 -= CTEMP4
	sec
	lda	arg4_l
	sbc	CTEMP4_L
	sta	arg4_l
	lda	arg4_h
	sbc	CTEMP4_H
	sta	arg4_h

cordic_if_done:

	inc	II
	lda	II
	cmp	#8
	beq	cordic_loop_done
	jmp	cordic_loop

cordic_loop_done:


	; divide by 0.625 as a c]heap approximation
	; to the 0.607 scaling factor factor
	; introduced by this algorithm
	; (see https://en.wikipedia.org/wiki/CORDIC)

	;  *arg3_ = (arg3 >> 1) + (arg3 >> 3);

	lda	arg3_l		; TEMP1 = arg3
	sta	TEMP1_L
	lda	arg3_h
	sta	TEMP1_H

	lda	TEMP1_H		; TEMP1 = arg3>>1
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L

	lda	TEMP1_L		; arg3 = arg3>>1
	sta	arg3_l
	lda	TEMP1_H
	sta	arg3_h

	ldx	#2		; TEMP1 = arg3>>3
cp5:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	cp5

	clc
	lda	arg3_l
	adc	TEMP1_L
	sta	arg3_l
	lda	arg3_h
	adc	TEMP1_H
	sta	arg3_h

	;  return (arg1 >> 1) + (arg1 >> 3);

	lda	arg1_l		; TEMP1 = arg1
	sta	TEMP1_L
	lda	arg1_h
	sta	TEMP1_H

	lda	TEMP1_H		; TEMP1 = arg1>>1
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L

	lda	TEMP1_L		; arg1 = arg1>>1
	sta	arg1_l
	lda	TEMP1_H
	sta	arg1_h

	ldx	#2		; TEMP1 = arg1>>3
cp6:
	lda	TEMP1_H
	cmp	#$80
	ror
	sta	TEMP1_H
	ror	TEMP1_L
	dex
	bne	cp6

	clc
	lda	arg1_l
	adc	TEMP1_L
	sta	arg1_l
	lda	arg1_h
	adc	TEMP1_H
	sta	arg1_h

	rts


	; 0 2 2 6 6 5 5 7  7 15 15 15
	; 2 2 6 6 5 5 7 7 15 15 15 15
colors:
	.byte $20,$22,$62,$66,$56,$55,$55,$75,$77,$F7,$FF,$FF


gr_offsets_h:
	.byte	>$400,>$480,>$500,>$580,>$600,>$680,>$700,>$780
	.byte	>$428,>$4a8,>$528,>$5a8,>$628,>$6a8,>$728,>$7a8
	.byte	>$450,>$4d0,>$550,>$5d0,>$650,>$6d0,>$750,>$7d0


gr_offsets_l:
	.byte	<$400,<$480,<$500,<$580,<$600,<$680,<$700,<$780
	.byte	<$428,<$4a8,<$528,<$5a8,<$628,<$6a8,<$728,<$7a8
	.byte	<$450,<$4d0,<$550,<$5d0,<$650,<$6d0,<$750,<$7d0
