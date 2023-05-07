;; ZX0 addresses

ZX0_src         = $00
ZX0_dst         = $02
offset          = $04
bitr            = $06
pntr            = $07
WHICH_LOAD      = $09
CURRENT_DISK    = $0A




	adrlo	=	$26	; constant from boot prom
	adrhi	=	$27	; constant from boot prom
	tmpsec	=	$3c	; constant from boot prom
	reqsec	=	$3d	; constant from boot prom
	sizelo	=	$44
	sizehi	=	$45
	secsize	=	$46

	INL	=	$EE
	INH	=	$EF

	ldsizel =       $f0
	ldsizeh =       $f1

	namlo   =       $fb
	namhi   =       $fc
	step    =       $fd     ; state for stepper motor
	tmptrk  =       $fe     ; temporary copy of current track
	phase   =       $ff     ; current phase for /seek

	

	TEMPY	=	$fa

	OUTL	=	$fe	; for picking filename
	OUTH	=	$ff



