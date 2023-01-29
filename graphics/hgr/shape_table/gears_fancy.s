; Rotating Gears (Fancy)
; 128 bytes (124 bytes + 4 byte header)

; by Vince `deater` Weaver / dsr

; Lovebyte 2023

;  95 bytes -- previous code
;  99 bytes -- add clicking
; 124 bytes -- add escapement (was originally trying for logo, but oh well)

; zero page locations
HGR_SHAPE	=	$1A
HGR_SHAPE2	=	$1B
HGR_BITS	=	$1C
GBASL		=	$26
GBASH		=	$27
A5H		=	$45
XREG		=	$46
YREG		=	$47
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
HGR_SCALE	=	$E7
HGR_SHAPE_TABLE	=	$E8
HGR_SHAPE_TABLE2=	$E9
HGR_COLLISIONS	=	$EA

ROTATION	=	$FA
;SMALLER		=	$FB
CURRENT_ROT	=	$FF

; Soft Switches
PAGE1   = $C054 ; Page1
PAGE2   = $C055 ; Page2


; ROM calls
HGR2		=	$F3D8
HGR		=	$F3E2
HPOSN		=	$F411
DRAW0		=	$F601
XDRAW0		=	$F65D
XDRAW1		=	$F661
WAIT		=	$FCA8                 ;; delay 1/2(26+27A+5A^2) us
RESTORE		=	$FF3F

.zeropage
.globalzp rot_smc
.globalzp smaller_smc
.globalzp which_smc
.globalzp dsr_rot_smc

gears_tiny:

	;============================
	; scene 1
	;============================

	jsr	HGR		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	lda	#8
	sta	HGR_SCALE

	jsr	draw_scene

	;===================
	; scene2
	;===================

	jsr	HGR2		; set to hires PAGE2, full screen
				; Y=0, A=0 after


	lda	#<gear2_table	; draw alternate gear
	sta	which_smc+1
	sta	dsr_rot_smc+1

	jsr	draw_scene


	;===================
	; rotate forever
	;===================
	; just page flipping with a delay

rotate_it:
	ldx	#0
	jsr	flip_and_wait

	inx
	jsr	flip_and_wait

	beq	rotate_it		; bra

	;=========================
	; flip and wait
	;=========================
flip_and_wait:
	lda	PAGE1,X		; flip page
	bit	$C030		; make click
	lda	#255		; wait a bit
	jmp	WAIT


	;=========================
	; draw scene
	;=========================
	; Y must be 0 at entry

draw_scene:
	ldx	#180
	lda	#10
	jsr	HPOSN

dsr_rot_smc:
	lda	#0
	ldx	#<shape_dsr
	ldy	#>shape_dsr
	jsr	XDRAW0

				; Y is zero from HGR/HGR2
	ldy	#0
	ldx	#110
	lda	#10
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??

	ldy	#32		; Y = steps to draw
	lda	#2		; A = rotation increment
	jsr	draw_gear
				; A and X zero on return


	tay			; set Y to 0
	ldx	#235
	lda	#100
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??

	ldy	#16		; only 16 repeats
	lda	#4		; A = rotation increment

	; fall through

	;===============================
	;===============================
	;===============================
	;===============================
draw_gear:
	sty	ROTATION	; set number of rotations
	sta	smaller_smc+1	; set rotation increment

gear1_loop:

	clc
	lda	rot_smc+1
smaller_smc:
	adc	#2
	sta	rot_smc+1

not_smaller:

which_smc:
	ldx	#<gear1_table	; point to bottom byte of shape address
	ldy	#>gear1_table	; point to top byte of shape address
				; this is always 0 if in zero page

rot_smc:
	lda	#1		; ROT=1 at first

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	dec	ROTATION
	bne	gear1_loop
	rts


gear1_table:
.byte	$25,$35,$00		; 37,53,0
gear2_table:
.byte	$2c,$2e,$00		; 44,46,0


shape_dsr:
.byte   $2d,$36,$ff,$3f
;.byte   $24,$ad,$22,$24,$94,$21,$2c,$4d
;.byte   $91,$3f,$36
.byte	$00

