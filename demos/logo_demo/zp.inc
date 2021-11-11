; these need to be in zero page
; can we find a location that works?

PATTERN_L	= $06
PATTERN_H	= $07
ORNAMENT_L	= $08
ORNAMENT_H	= $09
SAMPLE_L	= $0A
SAMPLE_H	= $0B
MB_ADDR_L	= $0C
MB_ADDR_H	= $0D


; only used for title screen...
;TEMP            =       $FA
;TEMPY           =       $FB
;INL             =       $FC
;INH             =       $FD
;OUTL            =       $FE
;OUTH            =       $FF

; pre-defined applesoft vars

CH      = $24
CV      = $25
GBASL   = $26
GBASH   = $27
BASL    = $28
BASH    = $29

HGR_COLOR       = $E4

.if 0
VGI_BUFFER      = $F0
VGI_TYPE        = $F0
P0              = $F1
P1              = $F2
P2              = $F3
P3              = $F4
P4              = $F5
P5              = $F6
P6              = $F7
VGIL            = $F8
VGIH            = $F9

OUTL            = $FC
OUTH            = $FD

COLOR1          = $FE
COLOR2          = $FF

TEMP0           = $10
TEMP1           = $11
TEMP2           = $12
TEMP3           = $13
TEMP4           = $14
TEMP5           = $15
.endif

HGR_BITS        = $1C

