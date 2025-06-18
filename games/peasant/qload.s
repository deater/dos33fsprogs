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
.byte $FF,1,1,3		; GAME_OVER, INVENTORY, PARSE_INPUT, INN
.byte 4,$FF,5		; ARCHERY, MAP, CLIMB
.byte 5,5		; HEIGHTS, OUTER
.byte 2,2,2,2,2		; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT
.byte 2,2,2,2,2		; GARY, KERREK1, WELL, YELLOW_TREE, WATERFALL
.byte 3,3,3,3,3		; JHONKA, COTTAGE, LAKE_W, LAKE_E, OUTSIDE_INN
.byte 3,3,3,3,3		; NED, WAVY_TREE, KERREK2, LADY_COTTAGE, BURN_TREE
.byte 4,4,4		; INSIDE_LADY, INSIDE_NED, HIDDEN_GLEN
.byte 1,$FF,1		; SAVE_DATA, PEASANT_SPRITES, ?
.byte $FF		; disk detect

load_address_array:
.byte $60,$60,$80,$60		; VID_LOGO, TITLE, INTRO, COPY_CHECK
.byte $60,$60,$D0,$40		; TROGDOR, ENDING, MUSIC, CLIFF_BASE
.byte $60,$D0,$20,$60		; GAME_OVER, INVENTORY, PARSE_INPUT, INN
.byte $60,$60,$60		; ARCHERY, MAP, CLIMB
.byte $40,$40			; HEIGHTS, OUTER
.byte $40,$40,$40,$40,$40	; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT
.byte $40,$40,$40,$40,$40	; GARY, KERREK1, WELL, YELLOW_TREE, WATERFALL
.byte $40,$40,$40,$40,$40	; JHONKA, COTTAGE, LAKE_W, LAKE_E, OUTSIDE_INN
.byte $40,$40,$40,$40,$40	; NED, WAVY_TREE, KERREK2, LADY_COTTAGE, BURN_TREE
.byte $40,$40,$40		; INSIDE_LADY, INSIDE_NED, HIDDEN_GLEN
.byte >load_buffer,>peasant_sprites_temp,$40	; SAVE_DATA,PEASANT_SPRITES , ?
.byte >load_buffer		; disk detect

track_array:
.byte  8,10,13,30	; VID_LOGO, TITLE, INTRO, COPY_CHECK
.byte 19,23, 7, 1	; TROGDOR, ENDING, MUSIC, CLIFF_BASE
.byte  4,18,17,16	; GAME_OVER, INVENTORY, PARSE_INPUT, INSIDE_INN
.byte  7, 5, 7		; ARCHERY, MAP, CLIMB
.byte 11,15		; HEIGHTS, OUTER
.byte 20,22,24,26,28	; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT
.byte 10,12,14,16,18	; GARY, KERREK1, WELL, YELLOW_TREE, WATERFALL
.byte 10,12,14,16,18	; JHONKA, COTTAGE, LAKE_W, LAKE_E, OUTSIDE_INN
.byte 20,22,24,26,28	; NED, WAVY_TREE, KERREK2, LADY_COTTAGE, BURN_TREE
.byte 18,20,22		; INSIDE_LADY, INSIDE_NED, HIDDEN_GLEN
.byte  0, 3, 0		; SAVE_DATA, PEASANT_SPRITES, ?
.byte  0		; disk detect

sector_array:
.byte  0, 0, 0, 0	; VID_LOGO, TITLE, INTRO, COPY_CHECK
.byte  0, 0, 0, 0	; TROGDOR, ENDING, MUSIC, CLIFF_BASE
.byte  0, 0, 0, 0	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
.byte  0, 0, 0		; ARCHERY, MAP, CLIMB
.byte  0, 0		; HEIGHTS, OUTER
.byte  0, 0, 0, 0, 0	; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT
.byte  0, 0, 0, 0, 0	; GARY, KERREK1, WELL, YELLOW_TREE, WATERFALL
.byte  0, 0, 0, 0, 0	; JHONKA, COTTAGE, LAKE_W, LAKE_E, OUTSIDE_INN
.byte  0, 0, 0, 0, 0	; NED, WAVY_TREE, KERREK2, LADY_COTTAGE, BURN_TREE
.byte  0, 0, 0		; INSIDE_LADY, INSIDE_NED, HIDDEN_GLEN
.byte  12,0,0		; SAVE_DATA, PEASANT_SPRITES, ?
.byte  0		; disk detect

length_array:
.byte  32, 48, 60, 20	; VID_LOGO, TITLE, INTRO, COPY_CHECK
.byte  64, 80, 16, 32	; TROGDOR, ENDING, MUSIC, CLIFF_BASE
.byte  16, 16, 16, 64	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
.byte  64, 32, 64	; ARCHERY, MAP, CLIMB
.byte  32,32		; HEIGHTS, OUTER
.byte  32,32,32,32,32 	; HAYSTACK, PUDDLE, BROTHERS, RIVER, KNIGHT
.byte  32,32,32,32,32	; GARY, KERREK1, WELL, YELLOW_TREE, WATERFALL
.byte  32,32,32,32,32	; JHONKA, COTTAGE, LAKE_W, LAKE_E, OUTSIDE_INN
.byte  32,32,32,32,32	; NED, WAVY_TREE, KERREK2, LADY_COTTAGE, BURN_TREE
.byte  32,32,32		; INSIDE_LADY, INSIDE_NED, HIDDEN_GLEN
.byte   1,16,1		; SAVE_DATA, PEASANT_SPRITES , ?
.byte   1		; disk detect


load_file:
	jmp	load_file_internal

.include "qkumba_popwr.s"
.include "zx02_optim.s"
.include "hgr_routines/hgr_font.s"
.include "hgr_routines/hgr_draw_box.s"
.include "hgr_routines/hgr_rectangle.s"
;.include "hgr_routines/hgr_1x28_sprite_mask.s"
;.include "hgr_routines/hgr_partial_save.s"
.include "hgr_routines/hgr_input.s"
.include "hgr_routines/hgr_tables.s"
.include "hgr_routines/hgr_text_box.s"
.include "clear_bottom.s"
.include "hgr_routines/hgr_clearscreen.s"	; maybe only for title?
.include "gr_offsets.s"
.include "loadsave_menu.s"
.include "wait_keypress.s"
.include "random8.s"
.include "score.s"
.include "redbook_sound.s"
.include "hgr_routines/hgr_page_flip.s"
.include "wait.s"
.include "load_peasant_sprites.s"

peasant_text:
	.byte 25,2,"Peasant's Quest",0

qload_end:

;.assert (>qload_end - >qload_start) < $e , error, "loader too big"
.assert (>qload_end - >qload_start) < $15 , error, "loader too big"
