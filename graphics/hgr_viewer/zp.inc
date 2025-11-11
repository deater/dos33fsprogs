
JS_BUTTON_STATE	=	$03
JOYSTICK_ENABLED=	$04
SOUND_STATUS	=	$05
	SOUND_DISABLED  = $80
	SOUND_IN_LC     = $01		; sound in language card
	SOUND_MOCKINGBOARD = $02	; mockingboard detected
	SOUND_SSI263    = $04		; SSI-263 speech chip detected
MOCKINGBOARD_SLOT	= $06
DISP_PAGE	= $07			; only in videlectrix intro?
DRAW_PAGE	= $08
NIBCOUNT	= $09
;CURRENT_DRIVE	= $0A
;DRIVE1_DISK	= $0B
;DRIVE2_DISK	= $0C
;DRIVE1_TRACK	= $0D
;DRIVE2_TRACK	= $0E

SPRITE_TEMP	= $10	; ?
MASK_TEMP	= $11
TEMP		= $12

TEMP0   = $10
TEMP1   = $11
TEMP2   = $12
TEMP3   = $13
TEMP4   = $14
TEMP5   = $15
COUNT	= TEMP5


; zx02 code
offset	= $10
offseth	= $11
ZX0_src	= $12
ZX0_dst	= $14
ZX0_srch= $15
bitr	= $16
pntr	= $17
pntrh	= $18

; electric duet
FREQ1          =       $10
FREQ2          =       $11
DURATION       =       $12
INSTRUMENT1    =       $13
INSTRUMENT2    =       $14
MADDRL         =       $15
MADDRH         =       $16


HGR_BITS		= $1C

CH			= $24
CV			= $25

GBASL			= $26
GBASH			= $27

adrlo   =       $26     ; constant from boot prom
adrhi   =       $27     ; constant from boot prom

BASL			= $28
BASH			= $29
MASK			= $2E

MASK0			= $2F   ; used by priority code in bg_mask
MASK1			= $30
MASK2			= $31
MASK3			= $32
MASK4			= $33
MASK5			= $34
MASK6			= $35

PEASANT_PRIORITY	= $36
MASK_COUNTDOWN		= $37
KEY_OFFSET		= $38

tmpsec  =       $3c     ; constant from boot prom
reqsec  =       $3d     ; constant from boot prom


; this is the structure for a ProDOS smartport command, at least
; for a read (command=1)


	COMMAND	= $42		; ProDOS constant
	UNIT	= $43		; ProDOS constant
	ADRLO	= $44		; ProDOS constant
	ADRHI	= $45		; ProDOS constant
	BLOKLO	= $46		; ProDOS constant
	BLOKHI	= $47		; ProDOS constant


sizelo  =       $44
sizehi  =       $45
secsize =       $46

SEEDL = $4E
SEEDH = $4F

LOC4E          =       $4E	; electric duet
COUNT256       =       $4F


DRAW_PAGE_SAVE	= $5F

CURSOR_X	= $64
CURSOR_Y	= $65
FRAME		= $66


SPEECH_PTRL    = $70
SPEECH_PTRH    = $71

; pt3 player registers
AY_REGISTERS    = $70
A_FINE_TONE     = $70
A_COARSE_TONE   = $71
B_FINE_TONE     = $72
B_COARSE_TONE   = $73
C_FINE_TONE     = $74
C_COARSE_TONE   = $75
NOISE           = $76
ENABLE          = $77
PT3_MIXER_VAL   = $77
A_VOLUME        = $78
B_VOLUME        = $79
C_VOLUME        = $7A
ENVELOPE_FINE   = $7B
ENVELOPE_COARSE = $7C
ENVELOPE_SHAPE  = $7D
PATTERN_L       = $7E
PATTERN_H       = $7F


; rest of pt3_player
PT3_TEMP        = $80
ORNAMENT_L      = $81
ORNAMENT_H      = $82
SAMPLE_L        = $83
SAMPLE_H        = $84
LOOP            = $85
MB_VALUE        = $86
MB_ADDR_L       = $87
MB_ADDR_H       = $88
DONE_PLAYING    = $89
DONE_SONG       = $8A
APPLEII_MODEL	= $8B


ldsizel =       $90
ldsizeh =       $91
namlo   =       $9b
namhi   =       $9c
step    =       $9d     ; state for stepper motor
tmptrk  =       $9e     ; temporary copy of current track
phase   =       $9f     ; current phase for /seek

INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF




 



