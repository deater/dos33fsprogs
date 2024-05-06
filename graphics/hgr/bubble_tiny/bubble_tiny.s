; bubble universe -- Apple II Hires

; even more size optimized version

; by Vince `deater` Weaver

; this version based on fast c64 code by serato_fig
;	as posted to the sizecoding discord
;	based on his TIC-80 variant

; originally was working off the BASIC code posted on the pouet forum
; original effect by yuruyrau on twitter

;  534 bytes -- original tiny version
;  529 bytes -- back out self modifying U/V code (allows more compact tables)

; soft-switches

KEYPRESS	= $C000
KEYRESET	= $C010
PAGE1		= $C054
PAGE2		= $C055

; ROM routines

BKGND0		= $F3F4         ; clear current page to A
HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
HPLOT0		= $F457		; plot at (Y,X), (A)
;HCOLOR1	= $F6F0		; set HGR_COLOR to value in X
;COLORTBL	= $F6F6
;WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

; zero page

GBASL		= $26
GBASH		= $27


HPLOTYL		= $92

I		= $D0
J		= $D1
T		= $D7
U		= $D8
V		= $D9
IT		= $DA
IS		= $DB

HGR_PAGE	= $E6

INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF

; const

;NUM		= 32
;NUM		= 24

bubble:

	;========================
	; setup lookup tables

	jsr	hgr_make_tables

	jsr	hgr_clear_codegen

	jsr	setup_sine_table

	;=======================
	; init graphics

	jsr	HGR
	jsr	HGR2

	;=======================
	; init variables

	; HGR leaves A at 0

;	lda	#0
	sta	U
	sta	V
	sta	T


	;=========================
	;=========================
	; main loop
	;=========================
	;=========================

next_frame:

	; reset I*T

	lda	T
	sta	IT

	; reset I*S

	lda	#0		; Y should be 0 here?
	sta	IS

i_smc:
	lda	#24	; 40
	sta	I

i_loop:

j_smc:
	lda	#24	; 200
	sta	J

j_loop:

	; where S=41 (approximately 1/6.28)
	; calc:	a=i*s+v;
	; calc:	b=i+t+u;
	; 	u=sines[a]+sines[b];
	; 	v=cosines[a]+cosines[b];



	clc
	lda	IS
	adc	V
	tay

	clc
	lda	IT
	adc	U
	tax

	clc			; 2
	lda	cosines,Y	; 4+
	adc	cosines,X	; 4+
	sta	V

	; max value for both $60 so carry not set

	lda	sines,Y		; 4+
	adc	sines,X		; 4+
	sta	U		; 3

	;===========================================================
	; HPLOT U+44,V+96
	;	U is centered at 96, to get to center of 280 screen add 44

	; U already in A

	adc	#44							; 2
	tax								; 2

	; calculate Ypos
	ldy	V

	; "fast" hplot, Xpos in X, Ypos in A

	; Apple II hi-res is more-or-less 280x192
	;	two consecutive pixels on are white
	;	single pixels are colored based on palette
	;	we treat things as a monochrome display, on a color
	;	display odd/even pixels will have different colors

	; The Y memory offset is a horrible interleaved mess, so we use
	;	a lookup table we generated at start.  We also add in
	;	the proper value for page-flipping

	; Apple II hi-res is 7 pixels/byte, so we also pre-generate
	;	div and mod by 7 tables at start and use those
	;	instead of dividing by 7
	;	We cheat and don't worry about the X positions larger
	;	than 256 because our algorithm only goes up to 208

	lda	hposn_low,Y						; 4
	sta	GBASL							; 3
	lda	hposn_high,Y						; 4
	ora	HGR_PAGE						; 3
	sta	GBASH							; 3
; 21

	ldy	div7_table,X						; 4

	lda	mod7_table,X						; 4
	tax								; 2
; 31
	; get current 7-bit pixel range, OR in to set new pixel

	lda	(GBASL),Y						; 5
	ora	log_lookup,X						; 4
;	eor	log_lookup,X						; 4
	sta	(GBASL),Y						; 6
; 46

	dec	J
	bne	j_loop

done_j:
	clc
	lda	IS
	adc	#41		; 1/6.28 = 0.16 =  0 0    1   0       1 0 0 0 = 0x28
	sta	IS
	dec	I
	bne	i_loop
done_i:
	inc	T

end:

	lda	KEYPRESS
	bpl	flip_pages
	bit	KEYRESET
				; 0110 -> 0100
	and	#$5f		; to handle lowercase too...

	cmp	#'A'
	bne	check_z
	inc	i_smc+1
	jmp	done_keys
check_z:
	cmp	#'Z'
	bne	check_j
	dec	i_smc+1
	jmp	done_keys
check_j:
	cmp	#'J'
	bne	check_m
	inc	j_smc+1
	jmp	done_keys
check_m:
	cmp	#'M'
	bne	done_keys
	dec	j_smc+1

done_keys:

flip_pages:
	; flip pages

	; if $20 (draw PAGE1) draw PAGE2, SHOW page1
	; if $40 (draw PAGE2) draw PAGE1, SHOW page2

	lda	HGR_PAGE
	eor	#$60
	sta	HGR_PAGE

	cmp	#$40
	bne	flip2
flip1:
	bit	PAGE1
	lda	#0
	jsr	hgr_page2_clearscreen
	jmp	next_frame
flip2:
	bit	PAGE2
	lda	#0
	jsr	hgr_page1_clearscreen
	jmp	next_frame


div7_table	= $6800
mod7_table	= $6900
hposn_high	= $6a00
hposn_low	= $6b00


hgr_make_tables:

	;=====================
	; make /7 %7 tables
	;=====================

hgr_make_7_tables:

	lda	#0
	tax
	tay
div7_loop:
	sta	div7_table,Y
mod7_smc:
	stx	mod7_table

	inx
	cpx	#7
	bne	div7_not7

	clc
	adc	#1
	ldx	#0

div7_not7:
	inc	mod7_smc+1	; assume on page boundary
	iny
	bne	div7_loop


	; Hposn table

; hposn_low, hposn_high will each be filled with $C0 bytes
; based on routine by John Brooks
; posted on comp.sys.apple2 on 2018-07-11
; https://groups.google.com/d/msg/comp.sys.apple2/v2HOfHOmeNQ/zD76fJg_BAAJ
; clobbers A,X
; preserves Y

; vmw note: version I was using based on applesoft HPOSN was ~64 bytes
;	this one is 37 bytes

build_hposn_tables:
	ldx	#0
btmi:
	txa
	and	#$F8
	bpl	btpl1
	ora	#5
btpl1:
	asl
	bpl	btpl2
	ora	#5
btpl2:
	asl
	asl
	sta	hposn_low, X
	txa
	and	#7
	rol
	asl	hposn_low, X
	rol
;	ora	#$20
	sta	hposn_high, X
	inx
	cpx	#$C0
	bne	btmi

	rts

	; which of 7 pixels to draw
	; note high bit is set to pick blue/orange palette
	; clear to get purple/green instead
log_lookup:
	.byte $81,$82,$84,$88,$90,$A0,$C0,$80

	; the current "fast" code expects to be aligned on boundary
	; also have to double things up as the code can go up to 255 off
	;	end for speed reasons


; floor(s*sin((x-96)*PI*2/256.0)+48.5);


.include "hgr_clear_codegen.s"


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

.if 0
sines:
	.byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
	.byte $40,$41,$42,$42,$43,$44,$45,$46,$47,$48,$48,$49,$4A,$4B,$4C,$4C
	.byte $4D,$4E,$4E,$4F,$50,$50,$51,$52,$52,$53,$53,$54,$54,$55,$55,$55
	.byte $56,$56,$57,$57,$57,$58,$58,$58,$58,$58,$59,$59,$59,$59,$59,$59

	.byte $59,$59,$59,$59,$59,$59,$59,$58,$58,$58,$58,$58,$57,$57,$57,$56
	.byte $56,$55,$55,$55,$54,$54,$53,$53,$52,$52,$51,$50,$50,$4F,$4E,$4E
	.byte $4D,$4C,$4C,$4B,$4A,$49,$48,$48,$47,$46,$45,$44,$43,$42,$42,$41
	.byte $40,$3F,$3E,$3D,$3C,$3B,$3A,$39,$38,$37,$36,$35,$34,$33,$32,$31

	.byte $30,$2F,$2E,$2D,$2C,$2B,$2A,$29,$28,$27,$26,$25,$24,$23,$22,$21
	.byte $20,$1F,$1E,$1E,$1D,$1C,$1B,$1A,$19,$18,$18,$17,$16,$15,$14,$14
; original start
	.byte $13,$12,$12,$11,$10,$10,$0F,$0E,$0E,$0D,$0D,$0C,$0C,$0B,$0B,$0B
	.byte $0A,$0A,$09,$09,$09,$08,$08,$08,$08,$08,$07,$07,$07,$07,$07,$07

	.byte $07,$07,$07,$07,$07,$07,$07,$08,$08,$08,$08,$08,$09,$09,$09,$0A
	.byte $0A,$0B,$0B,$0B,$0C,$0C,$0D,$0D,$0E,$0E,$0F,$10,$10,$11,$12,$12
	.byte $13,$14,$14,$15,$16,$17,$18,$18,$19,$1A,$1B,$1C,$1D,$1E,$1E,$1F
	.byte $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F

sines2:
	.byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
	.byte $40,$41,$42,$42,$43,$44,$45,$46,$47,$48,$48,$49,$4A,$4B,$4C,$4C
	.byte $4D,$4E,$4E,$4F,$50,$50,$51,$52,$52,$53,$53,$54,$54,$55,$55,$55
	.byte $56,$56,$57,$57,$57,$58,$58,$58,$58,$58,$59,$59,$59,$59,$59,$59

	.byte $59,$59,$59,$59,$59,$59,$59,$58,$58,$58,$58,$58,$57,$57,$57,$56
	.byte $56,$55,$55,$55,$54,$54,$53,$53,$52,$52,$51,$50,$50,$4F,$4E,$4E
	.byte $4D,$4C,$4C,$4B,$4A,$49,$48,$48,$47,$46,$45,$44,$43,$42,$42,$41
	.byte $40,$3F,$3E,$3D,$3C,$3B,$3A,$39,$38,$37,$36,$35,$34,$33,$32,$31

	.byte $30,$2F,$2E,$2D,$2C,$2B,$2A,$29,$28,$27,$26,$25,$24,$23,$22,$21
	.byte $20,$1F,$1E,$1E,$1D,$1C,$1B,$1A,$19,$18,$18,$17,$16,$15,$14,$14

	.byte $13,$12,$12,$11,$10,$10,$0F,$0E,$0E,$0D,$0D,$0C,$0C,$0B,$0B,$0B
	.byte $0A,$0A,$09,$09,$09,$08,$08,$08,$08,$08,$07,$07,$07,$07,$07,$07

	.byte $07,$07,$07,$07,$07,$07,$07,$08,$08,$08,$08,$08,$09,$09,$09,$0A
	.byte $0A,$0B,$0B,$0B,$0C,$0C,$0D,$0D,$0E,$0E,$0F,$10,$10,$11,$12,$12
	.byte $13,$14,$14,$15,$16,$17,$18,$18,$19,$1A,$1B,$1C,$1D,$1E,$1E,$1F
	.byte $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F


; floor(s*cos((x-96)*PI*2/256.0)+48.5);

cosines:

; sine[64]
	.byte $59,$59,$59,$59,$59,$59,$59,$58,$58,$58,$58,$58,$57,$57,$57,$56
	.byte $56,$55,$55,$55,$54,$54,$53,$53,$52,$52,$51,$50,$50,$4F,$4E,$4E
	.byte $4D,$4C,$4C,$4B,$4A,$49,$48,$48,$47,$46,$45,$44,$43,$42,$42,$41
	.byte $40,$3F,$3E,$3D,$3C,$3B,$3A,$39,$38,$37,$36,$35,$34,$33,$32,$31
; sine[128]
	.byte $30,$2F,$2E,$2D,$2C,$2B,$2A,$29,$28,$27,$26,$25,$24,$23,$22,$21
	.byte $20,$1F,$1E,$1E,$1D,$1C,$1B,$1A,$19,$18,$18,$17,$16,$15,$14,$14
	.byte $13,$12,$12,$11,$10,$10,$0F,$0E,$0E,$0D,$0D,$0C,$0C,$0B,$0B,$0B
	.byte $0A,$0A,$09,$09,$09,$08,$08,$08,$08,$08,$07,$07,$07,$07,$07,$07
; sine[192]
	.byte $07,$07,$07,$07,$07,$07,$07,$08,$08,$08,$08,$08,$09,$09,$09,$0A
	.byte $0A,$0B,$0B,$0B,$0C,$0C,$0D,$0D,$0E,$0E,$0F,$10,$10,$11,$12,$12
	.byte $13,$14,$14,$15,$16,$17,$18,$18,$19,$1A,$1B,$1C,$1D,$1E,$1E,$1F
	.byte $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F
; sine[0]
	.byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
	.byte $40,$41,$42,$42,$43,$44,$45,$46,$47,$48,$48,$49,$4A,$4B,$4C,$4C
	.byte $4D,$4E,$4E,$4F,$50,$50,$51,$52,$52,$53,$53,$54,$54,$55,$55,$55
	.byte $56,$56,$57,$57,$57,$58,$58,$58,$58,$58,$59,$59,$59,$59,$59,$59


cosines2:
	.byte $59,$59,$59,$59,$59,$59,$59,$58,$58,$58,$58,$58,$57,$57,$57,$56
	.byte $56,$55,$55,$55,$54,$54,$53,$53,$52,$52,$51,$50,$50,$4F,$4E,$4E
	.byte $4D,$4C,$4C,$4B,$4A,$49,$48,$48,$47,$46,$45,$44,$43,$42,$42,$41
	.byte $40,$3F,$3E,$3D,$3C,$3B,$3A,$39,$38,$37,$36,$35,$34,$33,$32,$31
	.byte $30,$2F,$2E,$2D,$2C,$2B,$2A,$29,$28,$27,$26,$25,$24,$23,$22,$21
	.byte $20,$1F,$1E,$1E,$1D,$1C,$1B,$1A,$19,$18,$18,$17,$16,$15,$14,$14
	.byte $13,$12,$12,$11,$10,$10,$0F,$0E,$0E,$0D,$0D,$0C,$0C,$0B,$0B,$0B
	.byte $0A,$0A,$09,$09,$09,$08,$08,$08,$08,$08,$07,$07,$07,$07,$07,$07
	.byte $07,$07,$07,$07,$07,$07,$07,$08,$08,$08,$08,$08,$09,$09,$09,$0A
	.byte $0A,$0B,$0B,$0B,$0C,$0C,$0D,$0D,$0E,$0E,$0F,$10,$10,$11,$12,$12

	.byte $13,$14,$14,$15,$16,$17,$18,$18,$19,$1A,$1B,$1C,$1D,$1E,$1E,$1F
	.byte $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F
	.byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
	.byte $40,$41,$42,$42,$43,$44,$45,$46,$47,$48,$48,$49,$4A,$4B,$4C,$4C
	.byte $4D,$4E,$4E,$4F,$50,$50,$51,$52,$52,$53,$53,$54,$54,$55,$55,$55
	.byte $56,$56,$57,$57,$57,$58,$58,$58,$58,$58,$59,$59,$59,$59,$59,$59
.endif
