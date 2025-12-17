; Music player for animations

; by Vince `deater` Weaver	vince@deater.net

.include "../hardware.inc"
.include "zp.inc"
;.include "qload.inc"
.include "common_defines.inc"

music_lib:

PT3_ENABLE_APPLE_IIC = 1

			; urgh to keep interrupt_handler from starting at $C4
			; which broke auto-patcher

	; pt3 player
;	.include "../pt3lib/pt3_lib_detect_model.s"
	.include "../pt3lib/pt3_lib_mockingboard_patch.s"
	.include "../pt3lib/pt3_lib_core.s"
	.include "../pt3lib/pt3_lib_init.s"
	.include "../pt3lib/pt3_lib_mockingboard_setup.s"
	.include "../pt3lib/interrupt_handler.s"
	.include "../pt3lib/pt3_lib_mockingboard_detect.s"



; only load one music track, self modify to make other

.align $100
PT3_LOC:
.incbin "music/alex_rostov_intro_theme.pt3"
