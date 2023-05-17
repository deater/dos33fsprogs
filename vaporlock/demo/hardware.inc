; soft-switches
; yes, I know these aren't necessary the "official" names

KEYBOARD	= $C000	; Read keypress+128
EIGHTYSTOREOFF	= $C000	; (write) turns off 80store
EIGHTYSTOREON	= $C001	; (write) page2 writes to AUX memory 

WRMAINRAM	= $C004	; (write)
WRAUXRAM	= $C005	; (write)

CLR80COL	= $C00C ; (write)
SET80COL	= $C00D ; (write)
CLRMOUSETET	= $C00E ; (write) disable moust text
SETMOUSETEXT	= $C00F	; (write) enable mouse text

KEYRESET	= $C010
VBLANK		= $C019	; *not* RDVBL (VBL signal low) (iie, opposite iigs)
RDVBLBAR	= $C019 ; iic

TBCOLOR		= $C022	; IIgs text foreground / background colors
CLOCKCTL	= $C034	; bits 0-3 are IIgs border color
NEWVIDEO	= $C029	; IIgs graphics modes
RDVBLMSK	= $C041 ; iic read vbl interrupt

SET_GR	= $C050
SET_TEXT= $C051
FULLGR	= $C052
TEXTGR	= $C053
PAGE1	= $C054
PAGE2	= $C055
LORES	= $C056
HIRES	= $C057
DISVBL		= $C05B ; (write) (iic) (ioudison) disable VBL interrupt
ENVBL		= $C05B ; (write) (iic) (ioudison) enable VBL interrupt
CLRAN3		= $C05E	; (write) in 80-col mode, enable double graphics
SETAN3		= $C05F	; (write) in 80-col mode, disable double graphics
PTRIG		= $C070 ; analog input reset / reset VBL interrupt (iic)
IOUDISON	= $C07E ; (write) disable IOU
IOUDISOFF	= $C07F ; (write) enable IOU

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

COUT		= $FDED
