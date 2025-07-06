; Loader for Peasant's Quest

; Based on QLOAD by qkumba which loads raw tracks off of disks

; This particular version only supports using a single disk drive
;       (I have other versions that can look for disks across two drives)

; it also loads the QLOAD paramaters from disk separately


.include "zp.inc"

.include "hardware.inc"

.include "common_defines.inc"

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
.byte 5,5,1,5		; TROGDOR, ENDING, MUSIC, CLIFF_BASE
.byte $FF,1,1,2		; GAME_OVER, INVENTORY, PARSE_INPUT, INSIDE_INN
.byte 4,$FF,5		; ARCHERY, MAP, CLIMB
.byte 5,5		; HEIGHTS, OUTER
.byte 3,3,2,2,2		; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT
.byte 3,3,2,2,2		; GARY, KERREK1, WELL, YELLOW_TREE, WATERFALL
.byte 3,3,2,2,2		; JHONKA, COTTAGE, LAKE_W, LAKE_E, OUTSIDE_INN
.byte 3,3,2,2,2		; NED, WAVY_TREE, KERREK2, LADY_COTTAGE, BURN_TREE
.byte 2,3,3		; INSIDE_LADY, INSIDE_NED, HIDDEN_GLEN
.byte 5,5		; OUTER2,OUTER3
.byte 2,$FF,5,5		; SAVE_DATA,PEASANT_SPRITES,CLIMB_SPRITES,OUTER_SPRITES
.byte $FF		; disk detect

load_address_array:
.byte $60,$60,$80,$60		; VID_LOGO, TITLE, INTRO, COPY_CHECK
.byte $40,$60,$D0,$40		; TROGDOR, ENDING, MUSIC, CLIFF_BASE
.byte $80,$D0,$60,$40		; GAME_OVER, INVENTORY, PARSE_INPUT, INSIDE_INN
.byte $60,$60,$80		; ARCHERY, MAP, CLIMB
.byte $40,$40			; HEIGHTS, OUTER
.byte $40,$40,$40,$40,$40	; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT
.byte $40,$40,$40,$40,$40	; GARY, KERREK1, WELL, YELLOW_TREE, WATERFALL
.byte $40,$40,$40,$40,$40	; JHONKA, COTTAGE, LAKE_W, LAKE_E, OUTSIDE_INN
.byte $40,$40,$40,$40,$40	; NED, WAVY_TREE, KERREK2, LADY_COTTAGE, BURN_TREE
.byte $40,$40,$40		; INSIDE_LADY, INSIDE_NED, HIDDEN_GLEN
.byte $40,$40			; OUTER2,OUTER3
.byte >load_buffer,>peasant_sprites_temp,>peasant_sprites_temp,>peasant_sprites_temp
				; SAVE_DATA,PEASANT_SPRITES,CLIMB_SPRITES,OUTER_SPRITES
.byte >load_buffer		; disk detect

track_array:
.byte  9,11,14,30	; VID_LOGO, TITLE, INTRO, COPY_CHECK
.byte 19,23, 7, 1	; TROGDOR, ENDING, MUSIC, CLIFF_BASE
.byte  4,19,18,11	; GAME_OVER, INVENTORY, PARSE_INPUT, INSIDE_INN
.byte  7, 5, 7		; ARCHERY, MAP, CLIMB
.byte 11,13		; HEIGHTS, OUTER
.byte 15, 9,29,19, 7	; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT
.byte 23, 7,31,17,15	; GARY, KERREK1, WELL, YELLOW_TREE, WATERFALL
.byte 17,11,27,21, 9	; JHONKA, COTTAGE, LAKE_W, LAKE_E, OUTSIDE_INN
.byte 19,13,33,23,13	; NED, WAVY_TREE, KERREK2, LADY_COTTAGE, BURN_TREE
.byte 25,21,25		; INSIDE_LADY, INSIDE_NED, HIDDEN_GLEN
.byte 15,17		; OUTER2, OUTER3
.byte  0, 3, 10, 3	; SAVE_DATA,PEASANT_SPRITES,CLIMB_SPRITES,OUTER_SPRITES
.byte  0		; disk detect

sector_array:
.byte  0, 0, 0, 0	; VID_LOGO, TITLE, INTRO, COPY_CHECK
.byte  0, 0, 0, 0	; TROGDOR, ENDING, MUSIC, CLIFF_BASE
.byte  0, 0, 0, 0	; GAME_OVER, INVENTORY, PARSE_INPUT, INSIDE_INN
.byte  0, 0, 0		; ARCHERY, MAP, CLIMB
.byte  0, 0		; HEIGHTS, OUTER
.byte  0, 0, 0, 0, 0	; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT
.byte  0, 0, 0, 0, 0	; GARY, KERREK1, WELL, YELLOW_TREE, WATERFALL
.byte  0, 0, 0, 0, 0	; JHONKA, COTTAGE, LAKE_W, LAKE_E, OUTSIDE_INN
.byte  0, 0, 0, 0, 0	; NED, WAVY_TREE, KERREK2, LADY_COTTAGE, BURN_TREE
.byte  0, 0, 0		; INSIDE_LADY, INSIDE_NED, HIDDEN_GLEN
.byte  0, 0		; OUTER2,OUTER3
.byte  12,0,0,0		; SAVE_DATA, PEASANT_SPRITES,CLIMB_SPRITES,OUTER_SPRITES
.byte  0		; disk detect

length_array:
.byte  32, 48, 48, 20	; VID_LOGO, TITLE, INTRO, COPY_CHECK
.byte  32, 80, 24, 32	; TROGDOR, ENDING, MUSIC, CLIFF_BASE
.byte  16, 16, 16, 32	; GAME_OVER, INVENTORY, PARSE_INPUT, INSIDE_INN
.byte  64, 32, 48	; ARCHERY, MAP, CLIMB
.byte  32,32		; HEIGHTS, OUTER
.byte  32,32,32,32,32 	; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT
.byte  32,32,32,32,32	; GARY, KERREK1, WELL, YELLOW_TREE, WATERFALL
.byte  32,32,32,32,32	; JHONKA, COTTAGE, LAKE_W, LAKE_E, OUTSIDE_INN
.byte  32,32,32,32,32	; NED, WAVY_TREE, KERREK2, LADY_COTTAGE, BURN_TREE
.byte  32,32,32		; INSIDE_LADY, INSIDE_NED, HIDDEN_GLEN
.byte  32,32		; OUTER2, OUTER3
.byte   1,16,16,16	; SAVE_DATA,PEASANT_SPRITES,CLIMB_SPRITES,OUTER_SPRITES
.byte   1		; disk detect	; 46


load_file:
	jmp	load_file_internal

.include "qkumba_popwr.s"
.include "zx02_optim.s"
.include "hgr_routines/hgr_font.s"
.include "hgr_routines/hgr_draw_box.s"
.include "hgr_routines/hgr_rectangle.s"
.include "hgr_routines/hgr_input.s"
.include "hgr_routines/hgr_tables.s"
.include "hgr_routines/hgr_text_box.s"
.include "clear_bottom.s"
.include "hgr_routines/hgr_clearscreen.s"	; maybe only for title?
.include "gr_offsets.s"
.include "loadsave/loadsave_menu.s"
.include "wait_keypress.s"
.include "random8.s"
.include "score.s"
.include "redbook_sound.s"
.include "hgr_routines/hgr_page_flip.s"
.include "wait.s"
.include "load_peasant_sprites.s"
.include "hgr_routines/hgr_copy_faster.s"

peasant_text:
	.byte 25,2,"Peasant's Quest",0

qload_end:

;.assert (>qload_end - >qload_start) < $e , error, "loader too big"
.assert (>qload_end - >qload_start) < $15 , error, "loader too big"
