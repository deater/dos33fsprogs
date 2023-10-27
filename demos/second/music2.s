; music, music

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

;.include "qload.inc"


memcpy_routines:
	.include "aux_memcopy.s"

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
;.incbin "music/z00m_unreal2_part1.pt3"
;.incbin "music/z00m_unreal2_part2.pt3"
.incbin "music/second_3d.pt3"

