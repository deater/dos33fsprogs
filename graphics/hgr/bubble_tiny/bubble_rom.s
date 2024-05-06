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
;  492 bytes -- hook up compact sine generation
;  445 bytes -- strip out keyboard code
;  208 bytes -- use ROM routines
;  203 bytes -- optimize page flip

; soft-switches

KEYPRESS	= $C000
KEYRESET	= $C010
PAGE1		= $C054
PAGE2		= $C055

; ROM routines

BKGNDZ		= $F3F2		; clear current page to 0
BKGND0		= $F3F4		; clear current page to A
HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
HPLOT0		= $F457		; plot at (Y,X), (A)
HCOLOR1		= $F6F0		; set HGR_COLOR to value in X
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

OUTL		= $FC
OUTH		= $FD

sines   = sines_base-$1A        ; overlaps some code
sines2  = sines+$100            ; duplicate so we can index cosine into it
cosines = sines+$c0

bubble:

	;==========================
	; setup lookup tables
	;==========================
;	jsr	hgr_make_tables

;	jsr	hgr_clear_codegen


	;=========================
	; reconstruct sine base
	;=========================
	; generate the linear $30..$42 part
	; and also string of $59 on end
	;       removes 26 bytes from table
	;       at expense of 16+4 bytes of code
	;               (4 from jsr/rts of moving over-writable table code)

	ldy	#$19		; offset
	ldx	#$48		; want to write $48 downto $30
				; with $42 doubled
looper:
	txa
	sta	sines,Y		; sines+12 .... sines

	lda	#$59		; also write $59 off the top
	sta	fifty_nines,Y

	cpy	#$13		; we could save more bytes if we didn't
	beq	skipper		; bother trying to be exact
	dex
skipper:
	dey
	bpl	looper


	;==========================
	; make sine/cosine tables
	;==========================

	; floor(s*sin((x-96)*PI*2/256.0)+48.5);

	;===================================
	; final_sine[i]=quarter_sine[i];          // 0..64
	; final_sine[128-i]=quarter_sine[i];      // 64..128
	; final_sine[128+i]=0x60-quarter_sine[i]; // 128..192
	; final_sine[256-i]=0x60-quarter_sine[i]; // 192..256

setup_sine_table:
	ldx	#64
	ldy	#64
setup_sine_loop:

	lda	sines,X

;	sta	sines,X
	sta	sines,Y

	lda	#$60
	sec
	sbc	sines,X

	sta	sines+128,X
	sta	sines+128,Y

	iny
	dex
	bpl	setup_sine_loop


	;=======================
	; init variables

	; HGR leaves A at 0

;	lda	#0
;	sta	U
;	sta	V
;	sta	T


	;=======================
	; init variables
	;=======================
	; wipe all of zero page but $FF

	; in theory we only need to clear/copy $00..$C0
	;       but not sure how to use to our advantage

        inx             ; X=0
        ldy     #0      ; Y=0
init_loop:
;       sta     a:$D0,X         ; force 16-bit so doesn't wrap
                                ; because I guess it's bad to wipe zero page?
                                ; maybe it isn't?

        sty     $D0,X           ; clear zero page

        lda     sines,X         ; duplicate sine table for cosine use
        sta     sines2,X

        dex
        bne     init_loop

	;=======================
	; init graphics

	jsr	HGR		; why both?
	jsr	HGR2

	ldx	#7
	jsr	HCOLOR1

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
	lda	#1	; 40
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
	lda	V

; HPLOT0         = $F457         ; plot at (Y,X), (A)

	ldy	#0

	jsr	HPLOT0

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
	sta	PAGE1
	beq	done_flip

flip2:
	sta	PAGE2
done_flip:


;	lda	HGR_PAGE
	sta	OUTH
clear_loop_fix:
	lda	#$00
	tay
	; assume INL starts at 0 from clearing earlier
clear_loop:
	sta	(OUTL),Y
	iny
	bne	clear_loop

	inc	OUTH
	lda	OUTH
	and	#$1f
	bne	clear_loop_fix

;	jsr	BKGNDZ		; clear screen to black

	beq	next_frame	; bra




;.include "hgr_clear_codegen.s"


.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00


; need 26 bytes of destroyable area?
; alternately, need code to copy 26 bytes

;       .byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
;       .byte $40,$41,$42
;old_sines_base:
;       .byte $42,$43,$44,$45,$46,$47,$48,
sines_base:
        .byte $48,$49,$4A,$4B,$4C,$4C
        .byte $4D,$4E,$4E,$4F,$50,$50,$51,$52,$52,$53,$53,$54,$54,$55,$55,$55
        .byte $56,$56,$57,$57,$57,$58,$58,$58,$58,$58
fifty_nines:
;       .byte $59,$59,$59,$59,$59,$59
;       .byte $59

; floor(s*cos((x-96)*PI*2/256.0)+48.5);
