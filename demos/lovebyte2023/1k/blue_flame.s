; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Lovebyte 2023


; TODO:
;       line border?
;       DEMO OVER message, zooming from angle?

;	COOL_PATTERN? (140)
;	WEB?  (140)
;	BOXES (68) ???
;	SIER/SIERFAST (140)
;	MIRROR (140)
;	THICK_LINES (88)
;	RAINBOW SQUARES (106)
;	THICK (113) ***
;	WIRES (91)
;	STAGGERED (60)
;	STATIC_COLUMN (44) ***

.include "zp.inc"
.include "hardware.inc"


blue_flame:

	; clear both pages of graphics
	jsr	HGR
	jsr	HGR2

	; A and Y are 0 now?

	;===================
	; music Player Setup

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"



	cli				; enable music

	jsr	do_letters

	jsr	flames

end:
	jmp	end

.include "flame.s"
.include "letters.s"
.include "interrupt_handler.s"
.include "mockingboard_constants.s"

; music
.include	"SmallLove2.s"


