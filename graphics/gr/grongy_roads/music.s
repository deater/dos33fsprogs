; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"
;.include "qload.inc"
.include "common_defines.inc"


routines:
	.include "gr_page_flip.s"
	.include "draw_road.s"
	.include "copy_400.s"
	.include "zx02_optim.s"


music_lib:

PT3_ENABLE_APPLE_IIC = 1

	nop		; urgh to keep interrupt_handler from starting at $C4
			; which broke auto-patcher

	; pt3 player
;	.include "pt3_lib_detect_model.s"
	.include "pt3_lib_core.s"
	.include "pt3_lib_init.s"
	.include "pt3_lib_mockingboard_setup.s"
	.include "interrupt_handler.s"
	.include "pt3_lib_mockingboard_detect.s"

road21_zx02:
	.incbin "./grongy/road021.zx02"
road22_zx02:
	.incbin "./grongy/road022.zx02"
road23_zx02:
	.incbin "./grongy/road023.zx02"
road24_zx02:
	.incbin "./grongy/road024.zx02"


; only load one music track, self modify to make other

.align $100
PT3_LOC:
.incbin "music/mA2E_3.pt3"
