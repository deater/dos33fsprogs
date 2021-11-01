; SAVE1 -- ??

.include "zp.inc"

; want to load this to address $90

;
.byte LOAD_PEASANT2	; WHICH_LOAD	= 	$90
.byte 10		; PEASANT_X	=	$91
.byte 100		; PEASANT_Y	=	$92
.byte PEASANT_DIR_UP	; PEASANT_DIR	=	$93
.byte 0			; MAP_X		=	$94
.byte 1			; MAP_Y		=	$95
.byte LOCATION_HAY_BALE	; MAP_LOCATION	=	$96
.byte $00		; GAME_STATE_0	=	$97
.byte $00		; GAME_STATE_1	=	$98
.byte $00		; GAME_STATE_2	=	$99
.byte $00		; NED_STATUS	=	$9A
.byte $00		; BUSH_STATUS	=	$9B
.byte $00		; KERREK_STATE	=	$9C
.byte $00		; ARROW_SCORE	=	$9D
.byte $01		; SCORE_HUNDREDS=	$9E
.byte $09		; SCORE_TENSONES=	$9F
.byte $00		; INVENTORY_1	=	$A0
.byte $00		; INVENTORY_2	=	$A1
.byte $00		; INVENTORY_3	=	$A2
.byte $00		; INVENTORY_1_GONE =	$A3
.byte $00		; INVENTORY_2_GONE_=	$A4
.byte $00		; INVENTORY_3_GONE =	$A5
