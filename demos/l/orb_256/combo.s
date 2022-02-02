; combo -- Apple II Hires

; 280 bytes -- initial combo
; 276 bytes -- shave some bytes
; 275 bytes -- common HLINRL function (thought it would save more)
; 271 bytes -- optimize circle draw code
; 268 bytes -- circle code now <128 so use bne instead of jmp
; 266 bytes -- use X to index in zero page
; 263 bytes -- more circle optimization

; zero page

GBASL		= $26
GBASH		= $27
; D0+ used by HGR routines
HGR_COLOR	= $E4
HGR_PAGE	= $E6


YRUN            = $F0
XRUN            = $F1
Y1              = $F2
X1              = $F3
COLOR           = $F4

COUNT		= $F6

XX		= $F7
MINUSXX		= $F8
YY		= $F9
MINUSYY		= $FA
D		= $FB
R		= $FC
DADD		= $FD
FRAME		= $FF

; soft-switches

KEYPRESS	= $C000
KEYRESET	= $C010

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
HPOSN          = $F411
HPLOT0		= $F457		; plot at (Y,X), (A)
HLINRL		= $F530		; line to (X,A), (Y)
HCOLOR1		= $F6F0		; set HGR_COLOR to value in X
COLORTBL	= $F6F6
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
NEXTCOL		= $F85F		; COLOR=COLOR+3
SETCOL		= $F864		; COLOR=A
SETGR		= $FB40		; set graphics and clear LO-RES screen
BELL2		= $FBE4
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us


combo:

	lda	#$20
	sta	FRAME

	jsr	HGR2		; after, A=0, Y=0



	.include "orb.s"

	.include "staggered.s"
	.include "boxes.s"


	; sadly this only saves a byte
combo_hlinrl:
	ldy	#0
	ldx	#0
	jmp	HLINRL          ; plot relative (X,A), (Y)


even_lookup:
.byte   $D7,$DD,$F5,$D5, $D5,$D5,$D5,$D5
odd_lookup:
.byte   $AA,$AA,$AA,$AB, $AB,$AE,$BA,$EA

