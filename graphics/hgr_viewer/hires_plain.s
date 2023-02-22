; Some nice hires images

.include "hires_main.s"

MAX_FILES = 14

filenames_low:
	.byte <gp_filename
	.byte <peddle_filename
	.byte <peddle3_filename
	.byte <forty5_filename
	.byte <forty5b_filename
	.byte <forty5z_filename
	.byte <zeb_filename
	.byte <fm2j_filename
	.byte <fmh3_filename
	.byte <fulu_filename
	.byte <fllg_filename
	.byte <fplv_filename
	.byte <fxeg_filename
	.byte <fmdi_filename

filenames_high:
	.byte >gp_filename
	.byte >peddle_filename
	.byte >peddle3_filename
	.byte >forty5_filename
	.byte >forty5b_filename
	.byte >forty5z_filename
	.byte >zeb_filename
	.byte >fm2j_filename
	.byte >fmh3_filename
	.byte >fulu_filename
	.byte >fllg_filename
	.byte >fplv_filename
	.byte >fxeg_filename
	.byte >fmdi_filename



; filename to open is 30-character Apple text:
gp_filename:	; .byte "GP.ZX02",0
	.byte 'G'|$80,'P'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

peddle_filename:	; .byte "PEDDLE.ZX02",0
	.byte 'P'|$80,'E'|$80,'D'|$80,'D'|$80,'L'|$80,'E'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

peddle3_filename:	; .byte "PEDDLE3.ZX02",0
	.byte 'P'|$80,'E'|$80,'D'|$80,'D'|$80,'L'|$80,'E'|$80,'3'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

forty5_filename:	; .byte "45.ZX02",0
	.byte 'F'|$80,'O'|$80,'R'|$80,'T'|$80,'Y'|$80,'5'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

forty5b_filename:	; .byte "45B2D.ZX02",0
	.byte 'F'|$80,'O'|$80,'R'|$80,'T'|$80,'Y'|$80,'5'|$80,'B'|$80,'2'|$80,'D'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

forty5z_filename:	; .byte "45Z.ZX02",0
	.byte 'F'|$80,'O'|$80,'R'|$80,'T'|$80,'Y'|$80,'5'|$80,'Z'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

zeb_filename:	; .byte "ZEB.ZX02",0
	.byte 'Z'|$80,'E'|$80,'B'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fm2j_filename:	; .byte "FM2J.ZX02",0
	.byte 'F'|$80,'M'|$80,'2'|$80,'J'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fmh3_filename:	; .byte "FMH3.ZX02",0
	.byte 'F'|$80,'M'|$80,'H'|$80,'3'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fulu_filename:	; .byte "FULU.ZX02",0
	.byte 'F'|$80,'U'|$80,'L'|$80,'U'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fllg_filename:	; .byte "FLLG.ZX02",0
	.byte 'F'|$80,'L'|$80,'L'|$80,'G'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fplv_filename:	; .byte "FPLV.ZX02",0
	.byte 'F'|$80,'P'|$80,'L'|$80,'V'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fxeg_filename:	; .byte "FXEG.ZX02",0
	.byte 'F'|$80,'X'|$80,'E'|$80,'G'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

fmdi_filename:	; .byte "FMDI.ZX02",0
	.byte 'F'|$80,'M'|$80,'D'|$80,'I'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00


