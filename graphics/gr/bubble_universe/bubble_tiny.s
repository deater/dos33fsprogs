; bubble universe tiny -- Apple II Lores

; by Vince `deater` Weaver

; this version based on fast c64 code by serato_fig
;	as posted to the sizecoding discord
;	based on his TIC-80 variant

; originally was working off the BASIC code posted on the pouet forum
; original effect by yuruyrau on twitter

; 578 bytes = original color
; 531 bytes = remove keyboard code
; 527 bytes = inline sine gen
; 523 bytes = optimize init a bit
; 301 bytes = generate color lookup table
; 297 bytes = optimize color lookup table
; 282 bytes = optimize color shift
; 266 bytes = reduce resolution of sine table x2
; 260 bytes = shave off some bytes with unneeded compares

; soft-switches

KEYPRESS	= $C000
KEYRESET	= $C010

SET_GR		= $C050
SET_TEXT	= $C051
FULLGR		= $C052
TEXTGR		= $C053
PAGE1		= $C054
PAGE2		= $C055


; ROM routines

;BKGND0		= $F3F4         ; clear current page to A
;HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
;HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
;HPLOT0		= $F457		; plot at (Y,X), (A)
;HCOLOR1	= $F6F0		; set HGR_COLOR to value in X
;COLORTBL	= $F6F6
;WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

PLOT    = $F800                 ;; PLOT AT Y,A
PLOT1   = $F80E                 ;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
HLINE   = $F819                 ;; HLINE Y,$2C at A
VLINE   = $F828                 ;; VLINE A,$2D at Y
CLRSCR  = $F832                 ;; Clear low-res screen
CLRTOP  = $F836                 ;; clear only top of low-res screen
GBASCALC= $F847                 ;; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)
SETCOL  = $F864                 ;; COLOR=A
ROM_TEXT2COPY = $F962           ;; iigs
SETTXT  = $FB36
SETGR   = $FB40





; zero page

GBASL		= $26
GBASH		= $27
MASK		= $2E
COLOR		= $30

HPLOTYL		= $92

I		= $D0
J		= $D1
T		= $D7
U		= $D8
V		= $D9

HGR_PAGE	= $E6

INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF

SINES_BASE	= $C0

sines	= $6c00
sines2	= $6d00

; must be aligned :(
cosines = $6e00
cosines2= $6f00

color_map = $1000


bubble_gr:

	;=======================
	; init graphics
	;=======================

	jsr	SETGR

	; can't rely on registers after this as different on IIe
	;	with 80 col card

	bit	FULLGR

	;========================
	; setup lookup tables
	;========================

	;========================
	; color lookup
	;========================
	; 34 bytes originally
	; 30 updated

	ldx	#0	; x=0;			; 2
loop2:
	lda	#0	; a=0;			; 2
loop1:
	ldy	#0				; 2
yloop:
	clc					; 1
	sta	color_map,X	; values[y]=a;	; 3
	beq	skip				; 2
	adc	#$10		; a+=16		; 2
skip:
	inx					; 1
	iny					; 1
	cpy	#16				; 2
	bne	yloop				; 2

;	sec
	adc	#$10		; carry set here	; 2

	cpx	#16				; 2
	beq	loop2				; 2
	cpx	#0				; 2
	bne	loop1				; 2

	; X=0 here

	;==========================
	; make sine/cosine tables
	;==========================

	; floor(s*sin((x-96)*PI*2/256.0)+48.5);

	;===================================
	;
	;
	; final_sine[i]=quarter_sine[i];          // 0..64
	; final_sine[128-i]=quarter_sine[i];      // 64..128
	; final_sine[128+i]=0x60-quarter_sine[i]; // 128..192
	; final_sine[256-i]=0x60-quarter_sine[i]; // 192..256

setup_sine_table:
.if 0
	; spread sine table
	ldy	#32
;	ldx	#0		; set previously
spread_loop:
	tya
	lsr
	tax

	lda	sines_base,Y

	sta	SINES_BASE,X	; double the output
;	inx
;	sta	SINES_BASE,X
;	inx
	dey
	bne	spread_loop
.endif



	; spread sine table

	; load from sines_base,Y/2
	;	store to SINES_BASE,Y

;	ldy	#32
;	ldx	#0		; set previously
spread_loop:
	txa
	lsr
	tay

	lda	sines_base,Y

	sta	SINES_BASE,X	; double the output
;	inx
;	sta	SINES_BASE,X
;	inx
;	dey
	inx
	cpx	#64
	bne	spread_loop




;	ldx	#64
	ldy	#64
setup_sine_loop:

	lda	SINES_BASE,X

	sta	sines,X
	sta	sines2,X
	sta	sines,Y
	sta	sines2,Y

	lda	#$60
	sec
	sbc	SINES_BASE,X

	sta	sines+128,X
	sta	sines2+128,X
	sta	sines+128,Y
	sta	sines2+128,Y

	iny
	dex
	bpl	setup_sine_loop

	; X is $FF here?

	inx

;	ldx	#0

cosine_loop:
	lda	sines+192,X
	sta	cosines,X
	sta	cosines2,X
	inx
	bne	cosine_loop

	; X is 0 here?

	;=======================
	; init variables
	;=======================
	;

;	lda	#0
	stx	U
	stx	V
	stx	T
	stx	INL

	dex				; Y=$FF (color white)
	stx	COLOR

	;=========================
	;=========================
	; main loop
	;=========================
	;=========================

next_frame:

	; reset I*T

	lda	T
	sta	it1_smc+1
	sta	it2_smc+1

	; reset I*S

	lda	#0
	sta	is1_smc+1
	sta	is2_smc+1

num1_smc:
	lda	#13	; 13
	sta	I

i_loop:
num2_smc:
	lda	#$18	; 24

	sta	J
j_loop:
	ldx	U
	ldy	V

	; where S=41 (approximately 1/6.28)

	clc			; 2

	; calc:	b=i+t+u;
	; 	u=cosines[a]+cosines[b];
is2_smc:
	lda	cosines,Y	; 4+
it2_smc:
	adc	cosines,X	; 4+
	sta	V

	; calc:	a=i*s+v;
	; 	u=sines[a]+sines[b];
is1_smc:
	lda	sines,Y		; 4+
it1_smc:
	adc	sines,X		; 4+
	sta	U		; 3

	;===========================================================
	; original code is centered at 96,96 (on hypothetical 192x192 screen)

	; we adjust to be 40x48 window centered at 48,48

	; PLOT U-48,V-48

	; U already in A
;	sec
	sbc	#48
	tay								; 2
;	bmi	no_plot
	cpy	#40
	bcs	no_plot

	; calculate Ypos
	lda	V
;	sec
	sbc	#48
;	bmi	no_plot
	cmp	#48
	bcs	no_plot

;PLOT    = $F800                 ;; PLOT AT Y,A

	jsr	PLOT

no_plot:
	dec	J
	bne	j_loop

done_j:

	lda	is1_smc+1
	clc
	adc	#41		; 1/6.28 = 0.16 =  0 0    1   0       1 0 0 0 = 0x28
	sta	is1_smc+1
	sta	is2_smc+1
	dec	I
	bne	i_loop
done_i:

;	sty	V
	inc	T

end:

	;=================
	; cycle colors

	ldy	#$0
	lda	#4
	sta	INH
cycle_color_loop:
	lda	(INL),Y
	tax
	lda	color_map,X
	sta	(INL),Y
	iny
	bne	cycle_color_loop

	; need to do this for pages 4-7

	inc	INH
	lda	INH
	cmp	#$8
	bne	cycle_color_loop

	beq	next_frame		; just out of range...


; original
.if 0
sines_base:
	.byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
	.byte $40,$41,$42,$42,$43,$44,$45,$46,$47,$48,$48,$49,$4A,$4B,$4C,$4C
	.byte $4D,$4E,$4E,$4F,$50,$50,$51,$52,$52,$53,$53,$54,$54,$55,$55,$55
	.byte $56,$56,$57,$57,$57,$58,$58,$58,$58,$58,$59,$59,$59,$59,$59,$59
	.byte $59
.endif

; half as many points

sines_base:
	.byte $30,$32,$34,$36,$38,$3A,$3C,$3E
	.byte $40,$42,$43,$45,$47,$48,$4A,$4C
	.byte $4D,$4E,$50,$51,$52,$53,$54,$55
	.byte $56,$57,$57,$58,$58,$59,$59,$59
	.byte $59


.if 0
sines_base_reverse:
	.byte $59
	.byte $59,$59,$59,$58, $58,$57,$57,$56
	.byte $55,$54,$53,$52, $51,$50,$4E,$4D
	.byte $4C,$4A,$48,$47, $45,$43,$42,$40
	.byte $3E,$3C,$3A,$38, $36,$34,$32,$30
.endif

.if 0
; 26 - x^2/64+2x
sines_base:
	.byte $2F,$30,$31,$33,$34,$35,$36,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$40
	.byte $41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4A,$4B,$4C,$4D,$4D,$4E
	.byte $4F,$4F,$50,$51,$51,$52,$52,$53,$53,$54,$54,$55,$55,$56,$56,$56
	.byte $57,$57,$57,$58,$58,$58,$58,$59,$59,$59,$59,$59,$59,$59,$59,$59
	.byte $59
.endif

.if 0
sines_base:
	.byte $1A,$1C,$1E,$20,$22,$24,$26,$28,$29,$2B,$2D,$2F,$30,$32,$33,$35
	.byte $36,$38,$39,$3B,$3C,$3E,$3F,$40,$41,$43,$44,$45,$46,$47,$48,$49
	.byte $4A,$4B,$4C,$4D,$4E,$4F,$50,$51,$51,$52,$53,$54,$54,$55,$55,$56
	.byte $56,$57,$57,$58,$58,$59,$59,$59,$59,$5A,$5A,$5A,$5A,$5A,$5A,$5A
	.byte $5A
.endif

; floor(s*cos((x-96)*PI*2/256.0)+48.5);

