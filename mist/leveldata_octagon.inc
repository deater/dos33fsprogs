
;===============================================
; level data for the Octagon Temple on Mist
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5

; OCTAGON_TEMPLE_DOORWAY	-- temple doorway
location0:
	.byte	OCTAGON_TEMPLE_CENTER	; north exit
;	.byte	9		; south exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	temple_door_n_lzsa	; north bg
	.word	temple_door_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH	; north and south
	.byte	$ff		; special exit


; OCTAGON_TEMPLE_CENTER		-- temple inside
location1:
	.byte	$ff			; north exit
	.byte	OCTAGON_TEMPLE_DOORWAY	; south exit
	.byte	OCTAGON_FIREPLACE	; east exit
	.byte	OCTAGON_RED_BOOKSHELF	; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	temple_center_n_lzsa	; north bg
	.word	temple_center_s_lzsa	; south bg
	.word	temple_center_e_lzsa	; east bg
	.word	temple_center_w_lzsa	; west bg
	.byte	BG_NORTH|BG_WEST|BG_SOUTH|BG_EAST	; all directions
	.byte	$ff		; special exit

; OCTAGON_RED_BOOK_SHELF	-- red book shelf
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	OCTAGON_TEMPLE_CENTER	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	red_book_shelf_lzsa	; west bg
	.byte	BG_WEST		; west
	.byte	DIRECTION_N	; special exit
	.byte	16,25		; special x
	.byte	16,32		; special y
	.word	red_book-1	; special function

; OCTAGON_FIREPLACE		-- fireplace
location3:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	OCTAGON_IN_FIREPLACE	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_W	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	fireplace_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff		; special exit

; OCTAGON_IN_FIREPLACE		-- in fireplace
location4:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	OCTAGON_TEMPLE_CENTER	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	in_fireplace_w_lzsa	; west bg
	.byte	BG_WEST		; west
	.byte	$ff		; special exit

; OCTAGON_CEILING		-- ceiling of temple
location5:
	.byte	OCTAGON_TEMPLE_CENTER	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	temple_center_up_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff
