; Don't Tell Valve

; by Vince `deater` Weaver / DsR

; zero page locations
GBASL		=	$26
GBASH		=	$27
HGR_SCALE	=	$E7
HGR_ROTATION	=	$F9

ZP=$80
offset          = ZP+0
ZX0_src         = ZP+2
ZX0_dst         = ZP+4
bitr            = ZP+6
pntr            = ZP+7


; ROM locations
HGR2		=	$F3D8
HGR		=	$F3E2
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
HPLOT0		=	$F457

dont:

	jsr	HGR		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call


	lda	#<scene
	sta	zx_src_l+1
	lda	#>scene
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp


ending:
	jmp	ending

.include "zx02_optim.s"

scene:
.incbin "graphics/scene.hgr.zx02"
