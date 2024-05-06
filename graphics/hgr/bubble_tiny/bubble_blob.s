; bubble universe -- Apple II Hires

; even more size optimized version

; by Vince `deater` Weaver

; this version based on fast c64 code by serato_fig
;	as posted to the sizecoding discord
;	based on his TIC-80 variant

; originally was working off the BASIC code posted on the pouet forum
; original effect by yuruyrau on twitter

; for this code I always is 1

;  217 bytes -- original bubble_rom code
;  202 bytes -- remove unnecessary code if I==1
;  231 bytes -- add palette swap every 256 frames

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

; zero page

I		= $D0
J		= $D1
T		= $D7
U		= $D8
V		= $D9
IT		= $DA
IS		= $DB
FRAMEH		= $DC

HGR_PAGE	= $E6

OUTL		= $FC
OUTH		= $FD

;sines   = sines_base-$1A        ; overlaps some code
;sines2  = sines+$100            ; duplicate so we can index cosine into it
;cosines = sines+$c0

sines	= $6000
fifty_nines = sines+58
sines2	= sines+$100
cosines = sines+$c0

bubble_rom:

	;=============================
	; reconstruct sine base table
	;=============================
	; first part linear (26 bytes)
	;	have to adjust once for doubled $42
	; middle part copied from sine_data (32 bytes)
	; end part all $59 (7 bytes)

	; offset counts down from 31 to 0

	;	sines-6,Y = linear
	;	sines+26+offset = sines_data+offset
	;	sines+58+offset = $59

	ldy	#$1F		; offset
	ldx	#$48		; want to write $48 downto $30
				; with $42 doubled
looper:
	txa
	sta	sines-6,Y	;

	lda	sines_data,Y
	sta	sines+26,Y

	lda	#$59		; also write $59 off the top
	sta	fifty_nines,Y

	cpy	#$19		; we could save more bytes if we didn't
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

;i_smc:
;	lda	#1	; 40
;	sta	I

;i_loop:

j_smc:
	lda	#$80
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

	; HPLOT0 -- plot at (Y,X), (A)

	ldy	#0

	jsr	HPLOT0

	dec	J
	bne	j_loop

done_j:

;	clc
;	lda	IS
;	adc	#41		; 1/6.28 = 0.16 =  0 0    1   0       1 0 0 0 = 0x28
;	sta	IS
;	dec	I
;	bne	i_loop
done_i:

	inc	T

	bne	done_frame

	inc	FRAMEH

	lda	FRAMEH

	ror

	bcc	frame_odd
frame_even:
	ldx	#0
	jsr	HCOLOR1
	lda	#$ff
	bne	done_frame_related

frame_odd:
	ldx	#7
	jsr	HCOLOR1
	lda	#$0

done_frame_related:
	sta	bg_color_smc+1



done_frame:




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

	;=======================
	; clear screen
	;	note can be ~8192 cycles faster at expense of few bytes
	;	if we use self-modifying code instead of indirect-Y

;	lda	HGR_PAGE
	sta	OUTH

	ldy	#$0

clear_loop_fix:

bg_color_smc:
	lda	#$00		; set color to black

	; assume OUTL starts at 0 from clearing earlier
clear_loop:
	sta	(OUTL),Y
	iny
	bne	clear_loop

	inc	OUTH
	lda	OUTH
	and	#$1f
	bne	clear_loop_fix
	beq	next_frame	; bra

; need 26 bytes of destroyable area?
; alternately, need code to copy 26 bytes

; 26 bytes to gen
; 32 bytes of base
;  7 59s

;       .byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
;       .byte $40,$41,$42
;old_sines_base:
;       .byte $42,$43,$44,$45,$46,$47,$48,

sines_data:
;sines_base:
        .byte $48,$49,$4A,$4B,$4C,$4C
        .byte $4D,$4E,$4E,$4F,$50,$50,$51,$52,$52,$53,$53,$54,$54,$55,$55,$55
        .byte $56,$56,$57,$57,$57,$58,$58,$58,$58,$58
;fifty_nines:
;       .byte $59,$59,$59,$59,$59,$59
;       .byte $59

; floor(s*cos((x-96)*PI*2/256.0)+48.5);
