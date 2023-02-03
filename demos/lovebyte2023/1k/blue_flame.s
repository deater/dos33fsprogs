; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Lovebyte 2023

;  920 bytes -- (compressed) have letters/flame/music more or less going
;  914 bytes -- fallthrough into the flames code
;  887 bytes -- BF using compact zx02 code, inlined
; 1007 bytes -- merge in sier_parallax

; TODO:
;       line border?
;       DEMO OVER message, zooming from angle?

;	hgr/parallax/BOXES (68) ???

;	COOL_PATTERN? (140)
;	WEB?  (140)

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

	sty	FRAME			; init frame.  Maybe only H important?
	sty	FRAMEH


	;===================
	; music Player Setup

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"

	cli				; enable music

	.include "sier.s"

	jsr	do_letters

	; fallthrough into flames

;	jsr	flames
;
;end:
;	jmp	end


.include "flame.s"

.include "letters.s"

.include "interrupt_handler.s"
.include "mockingboard_constants.s"

; music
.include	"SmallLove2.s"

