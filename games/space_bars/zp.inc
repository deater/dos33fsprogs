; Zero Page
FRAMEBUFFER	= $00	; $00 - $0F

; zx02 code
offset		= $10
offseth		= $11
ZX0_src		= $12
ZX0_dst		= $14
ZX0_srch	= $15
bitr		= $16
pntr		= $17
pntrh		= $18

WHICH_LOAD	= $19
CURRENT_DISK	= $1A


CH		= $24
CV		= $25
GBASL		= $26
GBASH		= $27
BASL		= $28
BASH		= $29
MASK		= $2E
COLOR		= $30

FRAME		= $60
FRAMEH		= $61
BLARGH		= $69

;==========================
; $70-$7F for PT3 Player
;==========================

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

;============================
; $80-$8D rest of pt3_player
;============================

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
APPLEII_MODEL   = $8B
SOUND_STATUS    = $8C
        SOUND_DISABLED  = $80
        SOUND_IN_LC     = $01 ; $01 sound effects in language card
        SOUND_MOCKINGBOARD = $02 ; mockingboard detected

GREEN0		= $90
GREEN1		= $91
GREEN2		= $92
GREEN3		= $93
GREEN4		= $94
ZERO		= $95
GAME_OVER	= $96
ZPOS		= $97
IRQ_COUNTDOWN   = $98
SECOND_COUNTDOWN= $99

SPRITE_XPOS	= $E0
SPRITE_YPOS	= $E1
RANDOM_PTR	= $E2
ASTEROID_X	= $E3
ASTEROID_Y	= $E4
ASTEROID_SUBX	= $E5
ASTEROID_EXPLODE= $E6
FIRE_X		= $E7
FIRE_Y		= $E8

YADD		= $E9
BLAST1		= $EA
BLAST2		= $EB
FIRE		= $EC
LEVEL_DONE	= $ED
DRAW_PAGE	= $EE

LASTKEY		= $F1
PADDLE_STATUS	= $F2
XPOS		= $F3
YPOS		= $F4

WHICH		= $F5
ASTEROID_SPEED	= $F6

TEMP		= $FA
TEMPY		= $FB
INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF

