; soft-switches
; yes, I know these aren't necessary the "official" names

KEYBOARD	=	$C000	; Read
EIGHTYSTOREOFF	=	$C000	; Write (turns off 80store)
EIGHTYSTOREON	=	$C001	; Write (page2 writes to AUX memory) 
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
CLRAN3	= $C05E		; in 80-col mode, enable double graphics
SETAN3	= $C05F		; in 80-col mode, disable double graphics
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
