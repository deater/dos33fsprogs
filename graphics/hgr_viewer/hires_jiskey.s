; VMW Productions HIRES viewer
;
; by deater (Vince Weaver) <vince@deater.net>

.include "hires_main.s"

MAX_FILES = 6

filenames_high:
	.byte >grl_filename
	.byte >witch_filename
	.byte >mona_filename
	.byte >gw_filename
	.byte >skull_filename
	.byte >uw_filename

filenames_low:
	.byte <grl_filename
	.byte <witch_filename
	.byte <mona_filename
	.byte <gw_filename
	.byte <skull_filename
	.byte <uw_filename

; filename to open is 30-character Apple text:
grl_filename:	; .byte "GRL.ZX02",0
	.byte 'G'|$80,'R'|$80,'L'|$80,'.'|$80,'Z'|$80,'X'|$80
	.byte '0'|$80,'2'|$80,$00

witch_filename:	; .byte "WITCH.ZX02",0
	.byte 'W'|$80,'I'|$80,'T'|$80,'C'|$80,'H'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

mona_filename:	; .byte "MONA.ZX02",0
	.byte 'M'|$80,'O'|$80,'N'|$80,'A'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

gw_filename:	; .byte "GW.ZX02",0
	.byte 'G'|$80,'W'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

skull_filename:	; .byte "SKULL.ZX02",0
	.byte 'S'|$80,'K'|$80,'U'|$80,'L'|$80,'L'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

uw_filename:	; .byte "UW.ZX02",0
	.byte 'U'|$80,'W'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00


