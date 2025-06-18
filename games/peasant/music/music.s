; music, music

; by Vince `deater` Weaver	vince@deater.net

.include "../hardware.inc"
.include "../zp.inc"

;.include "qload.inc"

music_lib:

	nop		; urgh to keep interrupt_handler from starting at $C4
			; which broke auto-patcher

	; pt3 player
;	.include "../pt3_lib/pt3_lib_detect_model.s"
	.include "../pt3_lib/pt3_lib_core.s"
	.include "../pt3_lib/pt3_lib_init.s"
	.include "../pt3_lib/pt3_lib_mockingboard_setup.s"
	.include "../pt3_lib/interrupt_handler.s"
	.include "../pt3_lib/pt3_lib_mockingboard_detect.s"


; only load one music track, self modify to make other

.align $100
PT3_LOC:
peasant_pt3:
.incbin "peasant.pt3"

knight_zx02:
.incbin "../location_knight/graphics_knight/knight.zx02"
