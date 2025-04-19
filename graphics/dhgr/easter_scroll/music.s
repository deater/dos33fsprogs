; Some spring music

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"
;.include "qload.inc"
.include "common_defines.inc"

memcpy_routines:
        .include "aux_memcopy.s"
	.include "copy_400.s"
	.include "zx02_optim.s"
	.include "vertical_scroll_down.s"
	.include "slow_copy.s"

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

.align $100
PT3_LOC:
.incbin "music/ivan_roschin_spring_2001.pt3"
