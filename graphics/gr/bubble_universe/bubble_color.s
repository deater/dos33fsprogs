
; good settings:
;	num1_smc+1 = $0D
;	num2_smc+1 = $18

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
	bit	FULLGR
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
;	lsr
;	lsr
	sbc	#48
	tay								; 2
	bmi	no_plot
	cpy	#40
	bcs	no_plot

	; calculate Ypos
	lda	V
	sbc	#48
	bmi	no_plot
	cmp	#48
	bcs	no_plot
;	lsr
;	lsr

;HPLOT0		= $F457		; plot at (Y,X), (A)

;	ldy	#0

;	jsr	HPLOT0

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

.if 1
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

flip_pages:
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

.if 1
;	lda	#0
	ldy	#$0
clear_loop:
	ldx	$400,Y
	lda	color_map,X
	sta	$400,Y

	ldx	$500,Y
	lda	color_map,X
	sta	$500,Y

	ldx	$600,Y
	lda	color_map,X
	sta	$600,Y

	ldx	$700,Y
	lda	color_map,X
	sta	$700,Y
	dey
	bne	clear_loop
.endif

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

.if 0
color_map:
       ; 00  10  20  30  40  50  60  70  80  90  A0  B0  C0  D0  E0  F0
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;0
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;1
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;2
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;3
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;4
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;5
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;6
.byte	$05,$05,$05,$05,$05,$05,$05,$55,$05,$05,$05,$05,$05,$05,$05,$75	;7
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;8
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;9
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;A
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;B
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;C
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;D
.byte	$00,$00,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$70	;E
.byte	$07,$07,$07,$07,$07,$07,$07,$57,$07,$07,$07,$07,$07,$07,$07,$77	;F
.endif

color_map:
       ; 00  10  20  30  40  50  60  70  80  90  A0  B0  C0  D0  E0  F0
.byte	$00,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0	;0
.byte	$00,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0	;1
.byte	$01,$01,$11,$21,$31,$41,$51,$61,$71,$81,$91,$A1,$B1,$C1,$D0,$E1	;2
.byte	$02,$02,$12,$22,$32,$42,$52,$62,$72,$82,$92,$A2,$B2,$C2,$D2,$E2	;3
.byte	$03,$03,$13,$23,$33,$43,$53,$63,$73,$83,$93,$A3,$B3,$C3,$D3,$E3	;4
.byte	$04,$04,$14,$24,$34,$44,$54,$64,$74,$84,$94,$A4,$B4,$C4,$D4,$E4	;5
.byte	$05,$05,$15,$25,$35,$45,$55,$65,$75,$85,$95,$A5,$B5,$C5,$D5,$E5	;6
.byte	$06,$06,$16,$26,$36,$46,$56,$66,$76,$86,$96,$A6,$B6,$C6,$D6,$E6	;7
.byte	$07,$07,$17,$27,$37,$47,$57,$67,$77,$87,$97,$A7,$B7,$C7,$D7,$E7	;8
.byte	$08,$08,$18,$28,$38,$48,$58,$68,$78,$88,$98,$A8,$B8,$C8,$D8,$E8	;9
.byte	$09,$09,$19,$29,$39,$49,$59,$69,$79,$89,$99,$A9,$B9,$C9,$D9,$E9	;A
.byte	$0A,$0A,$1A,$2A,$3A,$4A,$5A,$6A,$7A,$8A,$9A,$AA,$BA,$CA,$DA,$EA	;B
.byte	$0B,$0B,$1B,$2B,$3B,$4B,$5B,$6B,$7B,$8B,$9B,$AB,$BB,$CB,$DB,$EB	;C
.byte	$0C,$0C,$1C,$2C,$3C,$4C,$5C,$6C,$7C,$8C,$9C,$AC,$BC,$CC,$DC,$EC	;D
.byte	$0D,$0D,$1D,$2D,$3D,$4D,$5D,$6D,$7D,$8D,$9D,$AD,$BD,$CD,$DD,$ED	;E
.byte	$0E,$0E,$1E,$2E,$3E,$4E,$5E,$6E,$7E,$8E,$9E,$AE,$BE,$CE,$DE,$EE	;F


