; Tiny DSR

; 82 bytes -- original
; 77 bytes -- after some work (forgot to document)
; 75 bytes -- count down frame counter
; 73 bytes -- Y is 0 after HCLR
; 72 bytes -- shave byte off page flip code
; 70 bytes -- end by crashing to monitor
; 67 bytes -- replace frame count with rotate
; 64 bytes -- always increment scale

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
HGR_PAGE	=	$E6
HGR_SCALE	=	$E7
HGR_SHAPE_TABLE	=	$E8
HGR_SHAPE_TABLE2=	$E9
HGR_COLLISIONS	=	$EA

; soft-switch
PAGE1		=	$C054

; ROM calls
HGR2		=	$F3D8
HGR		=	$F3E2
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
RESTORE		=	$FF3F
WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us
HCLR    = $F3F2		; A=0, Y=0 after, X unchanged

OUR_ROT=$E0


.zeropage
.globalzp	rot_smc


; spinning dsr logo

dsr_spin:

	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	sty	HGR_SCALE	; 2	init scale to 0

	;=========================================
	; MAIN LOOP
	;=========================================

main_loop:
	inc	HGR_SCALE	; 2	; increment scale

	inc	rot_smc+1	; 2	; rotate
	inc	rot_smc+1	; 2


	;=======================
	; xdraw
	;=======================
xdraw:
	; setup X and Y co-ords

	ldy	#0		; XPOSH always 0 for us
	ldx	#110
	lda	#96
	jsr	HPOSN		; X= (y,x) Y=(a)
				; after, A=COLOR.BITS
				; Y = xoffset (140/7=20?)
				; X = remainder?

	jsr	HCLR		; A=0 and Y=0 after, X=unchanged

	ldx	#<shape_dsr	; point to our shape
;	ldy	#>shape_dsr	; this is always zero since in zero page

rot_smc:
	lda	#$0		; set rotation

	jsr	XDRAW0		; XDRAW 1 AT X,Y

flip_page:
	; flip draw page $20/$40
        lda     HGR_PAGE
        eor     #$60
        sta     HGR_PAGE

        ; flip page
        ; have $20/$40 want to map to C054/C055

        asl
        asl                     ; $20 -> C=1 $00
        asl                     ; $40 -> C=0 $00
	rol
        tax
        sta	PAGE1,X

	; A and X are 0/1 here

	; if rot_smc not 64 then loop

	bit	rot_smc+1	;	set V if bit 6 set
	bvc	main_loop	; 2


	; fall through at end and crash


shape_dsr:
.byte	$2d,$36,$ff,$3f
.byte	$24,$ad,$22,$24,$94,$21,$2c,$4d
.byte	$91,$3f,$36,$00
