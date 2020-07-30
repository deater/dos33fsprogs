
;===============================================
; level data for Bunker/Submarine level
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7

; SUB_BUNKER_ENTRY	-- entryway inside bunker
location0:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SUB_HALLWAY		; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	bunker_entry_e_lzsa		; east bg
	.word	bunker_entry_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	DIRECTION_W		; special exit
	.byte	15,24		; special x
	.byte	8,42		; special y
	.word	goto_selena-1	; special function

; SUB_HALLWAY	-- hallway to the sub room
location1:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SUB_ROOM		; east exit
	.byte	SUB_BUNKER_ENTRY	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	sub_hallway_e_lzsa		; east bg
	.word	sub_hallway_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SUB_ROOM		-- sub room
location2:
	.byte	SUB_HALLWAY		; north exit
	.byte	SUB_INSIDE_SUB		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_W	; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	subroom_n_lzsa	; north bg
	.word	subroom_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; SUB_INSIDE_SUB	-- inside the submarine
location3:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	SUB_BOOK_HALLWAY	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	inside_sub_e_lzsa		; east bg
	.word	inside_sub_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SUB_BOOK_HALLWAY	-- hallway to the book room
location4:
	.byte	SUB_INSIDE_SUB	; north exit
	.byte	SUB_BOOK_ROOM	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_hallway_n_lzsa		; north bg
	.word	book_hallway_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; SELENA_BOOK_ROOM		-- book room
location5:
	.byte	SUB_BOOK_HALLWAY	; north exit
	.byte	SUB_BOOK_CLOSED		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_table_n_lzsa	; north bg
	.word	book_table_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; SUB_BOOK_CLOSED		-- book
location6:
	.byte	$ff			; north exit
	.byte	SUB_BOOK_OPEN		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	book_mist_closed_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	$ff

; SUB_BOOK_OPEN		-- mist book open
location7:
	.byte	$ff			; north exit
	.byte	SUB_BOOK_ROOM		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	book_mist_open_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	DIRECTION_S
	.byte	24,32		; special x
	.byte	12,22		; special y
	.word	mist_link_book-1		; special function

