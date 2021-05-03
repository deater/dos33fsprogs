; Finish this

; also, lo-res possible?

; zero page

HGR_DX          =       $D0     ; HGLIN
HGR_DX2         =       $D1     ; HGLIN
HGR_DY          =       $D2     ; HGLIN
HGR_QUADRANT    =       $D3
HGR_E           =       $D4
HGR_E2          =       $D5
HGR_X           =       $E0
HGR_X2          =       $E1
HGR_Y           =       $E2
HGR_COLOR       =       $E4
HGR_HORIZ       =       $E5
HGR_PAGE	=	$E6
HGR_SCALE       =       $E7
HGR_SHAPE_TABLE =       $E8
HGR_SHAPE_TABLE2=       $E9
HGR_COLLISIONS  =       $EA
HGR_ROTATION    =       $F9

; Soft Switches
PAGE0           =       $C054
PAGE1           =       $C055

; ROM calls
HGR2		=	$F3D8
HGR		=	$F3E2
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
WAIT		=	$FCA8                 ; delay 1/2(26+27A+5A^2) us
RESTORE		=	$FF3F


nyan:

;6ROT=0:SCALE=5:P=49236:HGR:HGR2:GOSUB8:Q=1:POKE230,32:GOSUB8

	jsr	HGR
	jsr	HGR2		; Hi-res, full screen           ; 3
				; Y=0, A=0 after this call

	lda	#5		; scale=5
	sta	HGR_SCALE

	jsr	eight

	; Q=1 (draw to next page)

	; move hgr page from $40 to $20
	lda	#$20
	sta	HGR_PAGE

	jsr	eight

seven:
	bit	PAGE0

	lda	#100
	jsr	WAIT

	bit	PAGE1


	lda	#100
	jsr	WAIT

	jmp	seven

eight:

        ; A and Y are 0 here.
        ; X is left behind by the boot process?

        ldy	#0
	ldx	#134
	lda	#102

        jsr     HPOSN           ; set screen position to X= (y,x) Y=(a)
                                ; saves X,Y,A to zero page
                                ; after Y= orig X/7
                                ; A and X are ??


	ldx     #<nyan_shape	; point to bottom byte of shape address
        ldy	#>nyan_shape	; point to top byte of shape address

        ; ROT in A

        ; this will be 0 2nd time through loop, arbitrary otherwise
	lda	#0              ; ROT=0
	jsr	XDRAW0          ; XDRAW 1 AT X,Y
                                ; Both A and X are 0 at exit
                                ; Z flag set on exit
                                ; Y varies


;8C=5:Y=80:XDRAW1AT134,102+Q*2:GOSUB9:C=1:GOSUB9:C=6:GOSUB9:C=2

nine:

;9HCOLOR=C:FORZ=YTOY+5:FORX=0TO13:Q=NOTQ:HPLOTX*8,Z+QTOX*8+7,Z+Q:NEXTX,Z:Y=Z

	rts



nyan_shape:
	.byte "$,.,6>???$$--5",0
