; soft-switches
; yes, I know these aren't necessary the "official" names

EIGHTYSTORE	=	$C001
CLR80COL	=	$C00C
SET80COL	=	$C00D

TBCOLOR		=	$C022	; IIgs text foreground / background colors
CLOCKCTL	=	$C034	; bits 0-3 are IIgs border color
NEWVIDEO	=	$C029	; IIgs graphics modes

SET_GR	= $C050
SET_TEXT= $C051
FULLGR	= $C052
TEXTGR	= $C053
PAGE1	= $C054
PAGE2	= $C055
LORES	= $C056
HIRES	= $C057
CLRAN3	= $C05E
SETAN3	= $C05F
VBLANK	= $C019		; *not* RDVBL (VBL signal low)

; ROM routines
SETCOL  = $F864		; COLOR=A*17
SETGR	= $FB40
VLINE	= $F828		; VLINE A,$2D at Y
HGR	= $F3E2
HPOSN	= $F411
HPLOT0  = $F457		; plot at (Y,X), (A)
HGLIN	= $F53A		; line to (X,A),(Y)

ROM_TEXT2COPY	= $F962		; iigs
ROM_MACHINEID	= $FBB3		; iigs
