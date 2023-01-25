; Rotating Gears (Tiny)

; by Vince `deater` Weaver

; 110 bytes -- original
; 106 bytes -- move to zero page
; 104 bytes -- use smaller_smc
; 103 bytes -- use which_smc

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

gears_tiny:

	;============================
	; scene 1
	;============================

	jsr	HGR		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	lda	#8
	sta	HGR_SCALE

;	sty	SMALLER		; init to 0

	jsr	draw_scene

	;===================
	; scene2
	;===================

	jsr	HGR2		; set to hires PAGE2, full screen
				; Y=0, A=0 after


	lda	#<gear2_table	; draw alternate gear
	sta	which_smc+1

	jsr	draw_scene


	;===================
	; rotate forever
	;===================
	; just page flipping with a delay

rotate_it:
	bit	PAGE1
	lda	#255
	jsr	WAIT

	bit	PAGE2
	lda	#255
	jsr	WAIT

	beq	rotate_it		; bra


	;=========================
	; draw scene
	;=========================
	; Y must be 0 at entry

draw_scene:

				; Y is zero from HGR
	ldx	#110
	lda	#10
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??
	ldy	#32
	jsr	draw_gear

	ldy	#0
	ldx	#235
	lda	#100
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??


;	inc	SMALLER
	inc	smaller_smc+1

	ldy	#16
	jsr	draw_gear

;	dec	SMALLER
	dec	smaller_smc+1

	rts

	;===============================
	;===============================
	;===============================
	;===============================
draw_gear:
	sty	ROTATION
gear1_loop:

	inc	rot_smc+1
	inc	rot_smc+1

smaller_smc:
	lda	#0
	beq	not_smaller

	inc	rot_smc+1
	inc	rot_smc+1

not_smaller:

which_smc:
	ldx	#<gear1_table	; point to bottom byte of shape address
	ldy	#>gear1_table	; point to top byte of shape address

	; ROT in A

	; this will be 0 2nd time through loop, arbitrary otherwise
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

