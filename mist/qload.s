; Loader for MIST

.include "zp.inc"
.include "hardware.inc"

.include "common_defines.inc"

qload_start:

	; first time entry
	; start by loading title

	lda	#LOAD_TITLE		; load title
	sta	WHICH_LOAD

main_game_loop:
	jsr	load_file
	jmp	main_game_loop


which_disk:
	.byte '1'		; MIST_TITLE
	.byte '1'		; MIST
	.byte '3'		; MECHE
	.byte '3'		; SELENA
	.byte '1'		; OCTAGON
	.byte '1'		; VIEWER
	.byte '3'		; STONEY
	.byte '2'		; CHANNEL
	.byte '2'		; CABIN
	.byte '1'		; DENTIST
	.byte '2'		; ARBOR
	.byte '2'		; NIBEL
	.byte '1'		; SHIP
	.byte '2'		; GENERATOR
	.byte '1'		; D'NI
	.byte '3'		; SUB



	;===================================================
	;===================================================
	; file not found
	;===================================================
	;===================================================

file_not_found:

mlsmc07:lda	$c0e8		; turn off drive motor?

	jsr	TEXT
	jsr	HOME

	ldy	#0

	lda	#<error_string
	sta	OUTL
	lda	#>error_string
	sta	OUTH

quick_print:
	lda	(OUTL),Y
	beq	quick_print_done
	jsr	COUT1
	iny
	jmp	quick_print

quick_print_done:
;	rts

;	jsr	quick_print

fnf_keypress:
	lda	KEYPRESS
	bpl	fnf_keypress
	bit	KEYRESET

;	jmp	which_load_loop

; offset for disk number is 19
error_string:
.byte "PLEASE INSERT DISK 1, PRESS RETURN",0


opendir_filename:
	rts


load_new = $119D
load_address=$11CB
load_track=load_address+1
load_sector=load_address+2
load_length=load_address+3


	;====================================
	; loads file specified by WHICH_LOAD
	;====================================
load_file:
	ldx	WHICH_LOAD

	lda	load_address_array,X
	sta	load_address

	lda	track_array,X
	sta	load_track

	lda	sector_array,X
	sta	load_sector

	lda	length_array,X
	sta	load_length

	jmp	load_new


which_disk_array:
	.byte 1,1,3,3		; MIST_TITLE,MIST,MECHE,SELENA
	.byte 1,1,3,2		; OCTAGON,VIEWER,STONEY,CHANNEL
	.byte 2,1,2,2		; CABIN,DENTIST,ARBOR,NIBEL
	.byte 1,1,1,3		; SHIP,GENERATOR,D'NI,SUB

load_address_array:
        .byte $40,$20,$20,$20	; MIST_TITLE,MIST,MECHE,SELENA
	.byte $20,$20,$20,$20	; OCTAGON,VIEWER,STONEY,CHANNEL
	.byte $20,$20,$20,$20	; CABIN,DENTIST,ARBOR,NIBEL
	.byte $20,$20,$20,$20	; SHIP,GENERATOR,D'NI,SUB

track_array:
        .byte  2, 8, 1,11	; MIST_TITLE,MIST,MECHE,SELENA
	.byte 18,31,21, 1	; OCTAGON,VIEWER,STONEY,CHANNEL
	.byte 27,26,10,20	; CABIN,DENTIST,ARBOR,NIBEL
	.byte 30,32,28,31	; SHIP,GENERATOR,D'NI,SUB

sector_array:
        .byte  0, 0, 0, 0	; MIST_TITLE,MIST,MECHE,SELENA
	.byte  0, 8, 0, 0	; OCTAGON,VIEWER,STONEY,CHANNEL
	.byte  0, 0, 0, 0	; CABIN,DENTIST,ARBOR,NIBEL
	.byte  0,12, 0, 0	; SHIP,GENERATOR,D'NI,SUB

length_array:
        .byte  83,159,157,145	; MIST_TITLE,MIST,MECHE,SELENA
	.byte 128, 19,158,135	; OCTAGON,VIEWER,STONEY,CHANNEL
	.byte  61, 31,159,109	; CABIN,DENTIST,ARBOR,NIBEL
	.byte  20, 33, 27, 54	; SHIP,GENERATOR,D'NI,SUB

;	.include	"qkumba_popwr.s"



        .include        "audio.s"
	.include	"linking_noise.s"
        .include        "decompress_fast_v2.s"
        .include        "draw_pointer.s"
        .include        "end_level.s"
	.include        "gr_copy.s"
        .include        "gr_fast_clear.s"
        .include        "gr_offsets.s"
        .include        "gr_pageflip.s"
        .include        "gr_putsprite_crop.s"
        .include        "keyboard.s"
        .include        "text_print.s"
	.include	"loadstore.s"

        .include        "page_sprites.inc"
	.include        "common_sprites.inc"

qload_end:

.assert (<qload_end - <qload_start)>14, error, "loader too big"
