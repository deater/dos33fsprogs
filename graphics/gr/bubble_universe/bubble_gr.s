; bubble universe -- Apple II Lores

; by Vince `deater` Weaver

; this version based on fast c64 code by serato_fig
;	as posted to the sizecoding discord
;	based on his TIC-80 variant

; originally was working off the BASIC code posted on the pouet forum
; original effect by yuruyrau on twitter

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
MASK    = $2E
COLOR   = $30



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


bubble_gr:

	;========================
	; setup lookup tables

	jsr	setup_sine_table

	;=======================
	; init graphics

	jsr	SETGR
;	jsr	HGR
;	jsr	HGR2

	;=======================
	; init variables

	; HGR leaves A at 0

	lda	#0
	sta	U
	sta	V
	sta	T



	;=========================
	;=========================
	; main loop
	;=========================
	;=========================

next_frame:
	lda	#$FF
	sta	COLOR

	; reset I*T

	lda	T
	sta	it1_smc+1
	sta	it2_smc+1

	; reset I*S

	lda	#0
	sta	is1_smc+1
	sta	is2_smc+1

num1_smc:
	lda	#24	; 40
	sta	I

i_loop:
num2_smc:
	lda	#24	; 200

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
	; HPLOT U+44,V+96

	; PLOT U+20,V+20

	;	U is centered at 96, to get to center of 280 screen add 44

	; U already in A

;	adc	#44							; 2
	lsr
	lsr
	tay								; 2

	; calculate Ypos
	lda	V
	lsr
	lsr

;HPLOT0		= $F457		; plot at (Y,X), (A)

;	ldy	#0

;	jsr	HPLOT0

;PLOT    = $F800                 ;; PLOT AT Y,A

	jsr	PLOT

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

.if 0
	lda	KEYPRESS
	bpl	flip_pages
	bit	KEYRESET
				; 0110 -> 0100
	and	#$5f		; to handle lowercase too...

	cmp	#'A'
	bne	check_z
	inc	num1_smc+1
	jmp	done_keys
check_z:
	cmp	#'Z'
	bne	check_j
	dec	num1_smc+1
	jmp	done_keys
check_j:
	cmp	#'J'
	bne	check_m
	inc	num2_smc+1
	jmp	done_keys
check_m:
	cmp	#'M'
	bne	done_keys
	dec	num2_smc+1
.endif
done_keys:

;flip_pages:
	; flip pages

	; if $20 (draw PAGE1) draw PAGE2, SHOW page1
	; if $40 (draw PAGE2) draw PAGE1, SHOW page2

;	lda	HGR_PAGE
;	eor	#$60
;	sta	HGR_PAGE

;	cmp	#$40
;	bne	flip2
;flip1:
;	bit	PAGE1
;	lda	#0
;	jsr	BKGND0
;	jsr	hgr_page2_clearscreen
;	jmp	next_frame
;flip2:
;	bit	PAGE2
;	lda	#0
;	jsr	BKGND0
;	jsr	hgr_page1_clearscreen

;	jsr	SETGR

	lda	#0
	ldy	#$0
clear_loop:
	sta	$400,Y
	sta	$500,Y
	sta	$600,Y
	sta	$700,Y
	dey
	bne	clear_loop


	jmp	next_frame


; floor(s*sin((x-96)*PI*2/256.0)+48.5);

; note: min=7, around 32
;       max=89 ($59), around 160
;	subtract 7, so 0...82?  halfway = 41 = $29 + 7 = $30
;       halfway= 6*16 = 96

sines	= $6c00
sines2	= $6d00
cosines = $6e00
cosines2= $6f00

	;===================================
	;
	;
	; final_sine[i]=quarter_sine[i];          // 0..64
	; final_sine[128-i]=quarter_sine[i];      // 64..128
	; final_sine[128+i]=0x60-quarter_sine[i]; // 128..192
	; final_sine[256-i]=0x60-quarter_sine[i]; // 192..256

setup_sine_table:

	ldy	#64
	ldx	#64
setup_sine_loop:

	lda	sines_base,Y
	sta	sines,Y
	sta	sines2,Y
	sta	sines,X
	sta	sines2,X

	lda	#$60
	sec
	sbc	sines_base,Y

	sta	sines+128,Y
	sta	sines2+128,Y
	sta	sines+128,X
	sta	sines2+128,X

	inx
	dey
	bpl	setup_sine_loop


	ldy	#0
cosine_loop:
	lda	sines+192,Y
	sta	cosines,Y
	sta	cosines2,Y
	iny
	bne	cosine_loop

	rts

sines_base:
	.byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
	.byte $40,$41,$42,$42,$43,$44,$45,$46,$47,$48,$48,$49,$4A,$4B,$4C,$4C
	.byte $4D,$4E,$4E,$4F,$50,$50,$51,$52,$52,$53,$53,$54,$54,$55,$55,$55
	.byte $56,$56,$57,$57,$57,$58,$58,$58,$58,$58,$59,$59,$59,$59,$59,$59
	.byte $59

; floor(s*cos((x-96)*PI*2/256.0)+48.5);

