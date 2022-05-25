; DSR Scroll Demo -- 256B Apple II Demo for Outline 2022

; by Vince `deater` Weaver / dSr

; 253 bytes -- initial implementation with no sound
; 251 bytes -- no phase
; 247 bytes -- move scale before so don't have to reload 0
; 243 bytes -- use BIT trick
; 242 bytes -- load frame into Y
; 240 bytes -- more BIT trick
; 239 bytes -- compare with BMI
; 263 bytes -- initially add sound
; 262 bytes -- make Y always 0 in xdraw
; 260 bytes -- ust BIT to determine phase
; 258 bytes -- no need to init PAGE at start
; 257 bytes -- remove a CLC as we know carry always set
; 256 bytes -- optimize phase now that we are setting 0/7 not 1/8
; 255 bytes -- optimize same area some more

; zero page locations
HGR_SHAPE	=	$1A
HGR_SHAPE2	=	$1B
HGR_BITS	=	$1C
GBASL		=	$26
GBASH		=	$27
A5H		=	$45
XREG		=	$46
YREG		=	$47

FRAME		=	$6D
PAGE		=	$6E
OUTL		=	$74
OUTH		=	$75

			; C0-CF should be clear
			; D0-DF?? D0-D5 = HGR scratch?
HGR_DX		=	$D0	; HGLIN
HGR_DX2		=	$D1	; HGLIN
HGR_DY		=	$D2	; HGLIN
HGR_QUADRANT	=	$D3
HGR_E		=	$D4
HGR_E2		=	$D5
HGR_X		=	$E0
HGR_X2		=	$E1
HGR_Y		=	$E2
HGR_COLOR	=	$E4
HGR_HORIZ	=	$E5
HGR_PAGE	=	$E6
HGR_SCALE	=	$E7
HGR_SHAPE_TABLE	=	$E8
HGR_SHAPE_TABLE2=	$E9
HGR_COLLISIONS	=	$EA


; soft-switch
SPEAKER		= $C030
SET_GR		= $C050
SET_TEXT	= $C051
FULLGR		= $C052
PAGE1		= $C054
PAGE2		= $C055
LORES		= $C056		; Enable LORES graphics
HIRES		= $C057		; Enable HIRES graphics

; ROM calls
HGR2		= $F3D8
HGR		= $F3E2
HCLR		= $F3F2		; A=0, Y=0 after, X unchanged
HPOSN		= $F411
XDRAW0		= $F65D
XDRAW1		= $F661
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
GBASCALC	= $F847		; Y in A, put addr in GBASL/GBASH
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us
RESTORE		= $FF3F


pattern1	= $d000		; location in memory to use as
				; background pixel pattern


	;========================================
	;========================================
	; actual start
	;========================================
	;========================================

dsr_scroll_intro:

	lda	#8
	sta	HGR_SCALE	; init scale to 8

	jsr	HGR2		; Hi-res, full screen
				; Y=0, A=0 after this call

	sta	FRAME
	sta	OUTL

	;=========================================
	; setup hi-res dsr on both pages
	;=========================================

hires_setup:

	; A is 0 here
	; Y is also 0 here
;	lda	#0		; non-rotate, on HGR PAGE2
	jsr	xdraw		;
	tay			; reset Y to 0

        lda     #$20		; switch drawing to HGR PAGE1
        sta     HGR_PAGE
	lda	#2		; rotate 2/64 of 360 degrees
	jsr	xdraw


	;===============================
	;===============================
	; main loop
	;===============================
	;===============================

	; A is zero due to call to xdraw

main_loop:
	; current page is in A at this point

	sta	PAGE

	asl		; make OUTH $4 or $8 depending on value in PAGE
			; which we have in A above or at end of loop
	asl		; C is 0
	adc	#4

	sta	OUTH

	;=======================
	; delay
	;=======================

	lda	#200
	jsr	play_sound

	;=======================
	; handle state
	;=======================
	; HI-RES WIGGLE		  0.. 63
	; LO-RES RIGHT SCROLL	 64..127
	; LO-RES DOWN  SCROLL	128..191
	; TEXT RIGHT SCROLL	192..255


	ldx	#0

	inc	FRAME

	lda	#$1F
	bit	FRAME			; puts bit 7 in N and bit 6 in V
	php				; save flags (zero is one we care)

	bpl	n_clear
	bvc	phase2
	bvs	phase3
n_clear:
	bvc	phase0
;	bvs	phase1

phase1:
	; LORES Vertical Scroll

	bit	LORES			; enable lo-res
	ldx	#7			; make vertical scroll

;	.byte	$24			; BIT trick to skip the txa
phase2:
	; LORES Horizontal Scroll

					; X is 7 or 0 here
;	txa				; make horizontal scroll (0)
;	lda	#0			; make horizontal scroll
	stx	pattern_dir_smc+1
	jmp	done_phase		; bra


phase0:
	; HIRES on GRAPHICS on
	bit	HIRES
	.byte	$24			; BIT trick to skip the inx
phase3:
	; TEXT ON
	inx				; point to SET_TEXT rather than SET_GR
	lda	SET_GR,X		; set mode

done_phase:
	plp			; restore flags
	bne	not_zero

was_zero:

	; update pointer to "random" background color

	inc	pattern_smc+2

	ldy	#135
boop_loop:
	lda	#8
	jsr	play_sound

	lda	#9
	jsr	play_sound

	dey
	bne	boop_loop

not_zero:



	;============================
	; draw an interleaved line
full_loop:
	ldx	#3

line_loop:
	ldy	#119

screen_loop:

	tya			; extrapolate X from Y
;	and	#$7		; could be bigger?
;	tax

pattern_smc:
	lda	pattern1,Y

inner_loop_smc:

	sta	(OUTL),Y

	dey
	bpl	screen_loop

	;=================================
	; move to next pattern

scroll_pattern:
	clc
	lda	pattern_smc+1
	adc	#8
	and	#$1f
	sta	pattern_smc+1

	; move to next line by adding $80
	;  we save a byte by using EOR instead

	lda	OUTL
	eor	#$80			; add $80
	sta	OUTL

	bne	line_loop

	; we overflowed, so increment OUTH

	inc	OUTH

;	lda	OUTH			; check if at end
;	and	#$3
;	bne	line_loop

	dex
	bpl	line_loop


done_bg:

	;=======================================
	; done drawing frame
	;=======================================
bit	$C030

	;======================
	; draw bitmap

	ldx	#7
boxloop:
	txa
	jsr	GBASCALC		; calc address of X
					; note we center to middle of screen
					; by noting the middle 8 lines
					; are offset by $28 from first 8 lines

	; GBASL is in A at this point

	clc
	adc	#12+$28
	sta	GBASL		; center x-coord and y-coord at same time


	lda	PAGE		; want to add 0 or 4 (not 0 or 1)
	asl
	asl			; this sets C to 0
	adc	GBASH
	sta	GBASH


	ldy	#15
draw_line_loop:

	lda	bitmap2,X	; get low bit of bitmap2 into carry
	lsr

	lda	#$00		; black is default color

	ror	bitmap,X	; 16-bit rotate (in memory)
	ror	bitmap2,X

	bcc	its_black

	lda	#$ff
its_black:
	sta	(GBASL),Y		; partway down screen

	dey
	bpl	draw_line_loop

	dex
	bpl	boxloop


	;=========================
	; scroll one line
	;=========================
	; if +1 then horizontal
	; if +8 then vertical

	; our current bitmap top line is all FFs
	; so we know carry will be set here

;	clc
	lda	pattern_smc+1
pattern_dir_smc:
	adc	#$8
	sta	pattern_smc+1


	; switch page
flip_page:

	lda	PAGE

	tax
	ldy	PAGE1,X			; flip page

	eor	#$1

;	bpl	main_loop		; bra

	jmp	main_loop


	;=======================
	; xdraw
	;=======================
	; rotation in A
	; Y should be 0 on entry
xdraw:
	pha			; save rotation
	; setup X and Y co-ords

;	ldy	#0		; XPOSH always 0 for us
	ldx	#140
	lda	#80		; 96 would be halfway?
	jsr	HPOSN		; X= (y,x) Y=(a)
				; after, A=COLOR.BITS
				; Y = xoffset (140/7=20?)
				; X = remainder?

	jsr	HCLR		; A=0 and Y=0 after, X=unchanged

	ldx	#<shape_dsr	; point to our shape
	ldy	#>shape_dsr	;

	pla			; restore rotation

	jmp	XDRAW0		; XDRAW 1 AT X,Y
				; A is zero at end

				; tail call

	;=============================
	; play_sound
	;=============================
play_sound:
	bit	$C030
	jmp	WAIT


; updated desire logo thanks to Jade/HMD

;012|456|012|456|
;@@@@@@@@@@@@@@@@'
;@   @@    @   @@'
;@@@  @@@@@@@@  @'
;@ @  @    @   @@'
;@ @  @@@  @@@  @'
;@    @    @ @  @'
;@@@@@@@@@@@@@@@@'
;

bitmap:
	.byte $FF ;,$FF
	.byte $8C ;,$23
	.byte $E7 ;,$F9
	.byte $A4 ;,$23
	.byte $A7 ;,$39
	.byte $84 ;,$29
	.byte $FF ;,$FF
	.byte $00 ;,$00

bitmap2:
	.byte $FF
	.byte $23
	.byte $F9
	.byte $23
	.byte $39
	.byte $29
	.byte $FF
	.byte $00

shape_dsr:
.byte	$2d,$36,$ff,$3f
.byte	$24,$ad,$22,$24,$94,$21,$2c,$4d
.byte	$91,$3f,$36,$00
