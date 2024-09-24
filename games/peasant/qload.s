; Loader for Peasant's Quest

; Based on QLOAD by qkumba which loads raw tracks off of disks

; This particular version only supports using a single disk drive
;       (I have other versions that can look for disks across two drives)

; it also loads the QLOAD paramaters from disk separately


.include "zp.inc"

.include "hardware.inc"

;.include "common_defines.inc"

.include "qboot.inc"

qload_start:

.if FLOPPY=1
.include "qload_floppy.s"
.else
.include "qload_hd.s"
.endif

.align $100

which_disk_array:
	.byte 1,1,1,1		; VID_LOGO, TITLE, INTRO. COPY_CHECK
	.byte 2,2,2,2		; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte 3,3,1,3		; TROGDOR, ENDING, MUSIC, CLIFF_BASE
	.byte 1,1,1,3		; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte 3,3,3,3		; INSIDE, ARCHERY, MAP, CLIMB
	.byte 3			; HEIGHTS

	.byte 1,1,1		; SAVE1, SAVE2, SAVE3
	.byte $f		; disk detect

load_address_array:
	.byte $60,$60,$60,$60	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte $60,$60,$60,$60	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte $60,$60,$D0,$60	; TROGDOR, ENDING, MUSIC, CLIFF
	.byte $60,$D0,$20,$60	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte $60,$60,$60,$60	; INSIDE, ARCHERY, MAP, CLIMB
	.byte $60		; HEIGHTS

	.byte $BC,$BC,$BC	; SAVE1, SAVE2, SAVE3
	.byte $BC		; disk detect

track_array:
        .byte  4, 6, 9,1	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte 15,20,25,30	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte 15,19, 3,24	; TROGDOR, ENDING, MUSIC, CLIFF_BASE
	.byte 15,14,13,11	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte  7,3,1,26		; INSIDE, ARCHERY, MAP, CLIMB
	.byte 30		; HEIGHTS

	.byte  0, 0, 0		; SAVE1, SAVE2, SAVE3
	.byte  0		; disk detect

sector_array:
        .byte  0, 0, 0, 0	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte  0, 0, 0, 0	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte  0, 0, 0, 0	; TROGDOR, ENDING, MUSIC, CLIFF_BASE
	.byte  0, 0, 0, 0	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte  0, 0, 0, 0	; INSIDE, ARCHERY, MAP, CLIMB
	.byte  0		; HEIGHTS

	.byte  11,12,13		; SAVE1, SAVE2, SAVE3
	.byte  0		; disk detect

length_array:
        .byte  32, 50, 60, 20	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte  80, 88, 88, 80	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte  64, 80, 16, 32	; TROGDOR, ENDING, MUSIC, CLIFF_BASE
	.byte  16, 16, 16, 64	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte  64, 64, 32, 64	; INSIDE, ARCHERY, MAP, CLIMB
	.byte  48		; HEIGHTS

	.byte   1,1,1		; SAVE1, SAVE2, SAVE3
	.byte   1		; disk detect


load_file:
	jmp	load_file_internal

.include "qkumba_popwr.s"
.include "zx02_optim.s"
.include "hgr_font.s"
.include "draw_box.s"
.include "hgr_rectangle.s"
.include "hgr_1x28_sprite_mask.s"
.include "hgr_partial_save.s"
.include "hgr_input.s"
.include "hgr_tables.s"
.include "hgr_text_box.s"
.include "clear_bottom.s"
.include "hgr_hgr2.s"		; this one is maybe only needed once?
.include "gr_offsets.s"
.include "loadsave_menu.s"
.include "wait_keypress.s"
.include "random16.s"
.include "score.s"
.include "speaker_beeps.s"

peasant_text:
	.byte 25,2,"Peasant's Quest",0

qload_end:

;.assert (>qload_end - >qload_start) < $e , error, "loader too big"
.assert (>qload_end - >qload_start) < $15 , error, "loader too big"




