; Apple II Megademo

; by deater (Vince Weaver) <vince@deater.net>


.include "hardware.inc"


	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	PAGE0                   ; first graphics page
	bit	FULLGR			; full screen graphics
	bit	HIRES			; hires mode !!!
	bit	SET_GR			; graphics mode


	;===================
	; do nothing
	;===================
do_nothing:
	jmp	do_nothing


.align $1000

.incbin "c64.img"
