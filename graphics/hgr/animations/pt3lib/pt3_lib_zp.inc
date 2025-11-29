;=================================
;=================================
; Zero Page Usage for PT3 Player
;=================================
;=================================

.if 0
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

IRQ_COUNTDOWN	= $8D

.endif

;==========================
; $70-$7F for PT3 Player
;==========================

AY_REGISTERS    = $E0
A_FINE_TONE     = $E0
A_COARSE_TONE   = $E1
B_FINE_TONE     = $E2
B_COARSE_TONE   = $E3
C_FINE_TONE     = $E4
C_COARSE_TONE   = $E5
NOISE           = $E6
ENABLE          = $E7
PT3_MIXER_VAL   = $e7
A_VOLUME        = $E8
B_VOLUME        = $E9
C_VOLUME        = $EA
ENVELOPE_FINE   = $EB
ENVELOPE_COARSE = $EC
ENVELOPE_SHAPE  = $ED
PATTERN_L       = $EE
PATTERN_H       = $EF

;============================
; $80-$8D rest of pt3_player
;============================

PT3_TEMP        = $F0
ORNAMENT_L      = $F1
ORNAMENT_H      = $F2
SAMPLE_L        = $F3
SAMPLE_H        = $F4
LOOP            = $F5
MB_VALUE        = $F6
MB_ADDR_L       = $F7
MB_ADDR_H       = $F8
DONE_PLAYING    = $F9
DONE_SONG       = $FA
APPLEII_MODEL   = $FB
SOUND_STATUS    = $FC
        SOUND_DISABLED  = $80
        SOUND_IN_LC     = $01 ; $01 sound effects in language card
        SOUND_MOCKINGBOARD = $02 ; mockingboard detected

IRQ_COUNTDOWN	= $FD
