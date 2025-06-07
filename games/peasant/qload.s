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
	.byte 2,2,3,3		; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte 5,5,1,5		; TROGDOR, ENDING, MUSIC, CLIFF_BASE
	.byte 1,1,1,3		; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte 4,4,4,5		; INSIDE, ARCHERY, MAP, CLIMB
	.byte 5,5		; HEIGHTS, OUTER
	.byte 2,2,2,2,2		; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT

	.byte 1,1,1		; SAVE_DATA, ?, ?
	.byte $f		; disk detect

load_address_array:
	.byte $60,$60,$60,$60	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte $60,$60,$60,$60	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte $60,$60,$D0,$60	; TROGDOR, ENDING, MUSIC, CLIFF
	.byte $60,$D0,$20,$60	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte $60,$60,$60,$60	; INSIDE, ARCHERY, MAP, CLIMB
	.byte $60,$60		; HEIGHTS, OUTER
	.byte $60,$60,$60,$60,$40	; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT

	.byte $BC,$BC,$BC	; SAVE_DATA,? , ?
	.byte $BC		; disk detect

track_array:
        .byte  4, 6, 9,1	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte 15,20,25,30	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte 15,19, 3, 1	; TROGDOR, ENDING, MUSIC, CLIFF_BASE
	.byte 15,14,13,11	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte  7, 3, 1, 3	; INSIDE, ARCHERY, MAP, CLIMB
	.byte  7,11		; HEIGHTS, OUTER
	.byte 20,22,24,26,28	; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT

	.byte  0, 0, 0		; SAVE_DATA, ?, ?
	.byte  0		; disk detect

sector_array:
        .byte  0, 0, 0, 0	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte  0, 0, 0, 0	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte  0, 0, 0, 0	; TROGDOR, ENDING, MUSIC, CLIFF_BASE
	.byte  0, 0, 0, 0	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte  0, 0, 0, 0	; INSIDE, ARCHERY, MAP, CLIMB
	.byte  0, 0		; HEIGHTS, OUTER
	.byte  0, 0, 0, 0, 0	; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT

	.byte  12,0,0		; SAVE_DATA, ?, ?
	.byte  0		; disk detect

length_array:
        .byte  32, 50, 60, 20	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte  80, 88, 88, 80	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte  64, 80, 16, 32	; TROGDOR, ENDING, MUSIC, CLIFF_BASE
	.byte  16, 16, 16, 64	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte  64, 64, 32, 64	; INSIDE, ARCHERY, MAP, CLIMB
	.byte  64,64		; HEIGHTS, OUTER
	.byte  32,32,32,32,32 	; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT

	.byte   1,1,1		; SAVE_DATA, ? , ?
	.byte   1		; disk detect


load_file:
	jmp	load_file_internal

.include "qkumba_popwr.s"
.include "zx02_optim.s"
.include "hgr_routines/hgr_font.s"
.include "draw_box.s"
.include "hgr_routines/hgr_rectangle.s"
.include "hgr_routines/hgr_1x28_sprite_mask.s"
.include "hgr_routines/hgr_partial_save.s"
.include "hgr_routines/hgr_input.s"
.include "hgr_routines/hgr_tables.s"
.include "hgr_routines/hgr_text_box.s"
.include "clear_bottom.s"
.include "hgr_routines/hgr_hgr2.s"		; this one is maybe only needed once?
.include "gr_offsets.s"
.include "loadsave_menu.s"
.include "wait_keypress.s"
.include "random8.s"
.include "score.s"
;.include "speaker_beeps.s"
.include "redbook_sound.s"

peasant_text:
	.byte 25,2,"Peasant's Quest",0

qload_end:

;.assert (>qload_end - >qload_start) < $e , error, "loader too big"
.assert (>qload_end - >qload_start) < $15 , error, "loader too big"
