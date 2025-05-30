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

; only load one music track, self modify to make other

title_graphic:
       .incbin "graphics/title1.hgr.zx02"

.align $100
PT3_LOC:
;.incbin "music/mA2E_3.pt3"
.incbin "music/Alex Winston - Scroll Block (2024) (Deadline 2024).pt3"
