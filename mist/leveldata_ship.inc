
;===============================================
; level data for the ship on Mist Island
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6


; SHIP_STERN		-- back of the ship
location0:
	.byte	SHIP_BOW		; north exit
	.byte	SHIP_DOOR_CLOSED	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	ship_entry_n_lzsa	; north bg
	.word	ship_entry_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff
;	.byte	DIRECTION_E	; special exit
;	.byte	12,25		; special x
;	.byte	26,46		; special y
;	.word	controls_pressed-1		; special function

; SHIP_BOW		-- bow of the ship
location1:
	.byte	$ff			; north exit
	.byte	SHIP_STERN	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	ship_bow_go_n_lzsa		; north bg
	.word	ship_bow_s_lzsa			; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH | BG_SOUTH
	.byte	DIRECTION_N		; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	back_to_mist-1	; special function

; SHIP_DOOR_CLOSED		-- ship cabin door
location2:
	.byte	SHIP_BOW		; north exit
	.byte	SHIP_DOOR_OPEN		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	ship_entry_n_lzsa		; north bg
	.word	ship_door_closed_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff		; special exit

; SHIP_DOOR_OPEN			-- ship cabin door open
location3:
	.byte	SHIP_BOW		; north exit
	.byte	SHIP_CHAIR		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	ship_entry_n_lzsa		; north bg
	.word	ship_door_open_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff		; special exit

; SHIP_CHAIR			-- chair in the cabin
location4:
	.byte	SHIP_STERN		; north exit
	.byte	SHIP_BOOK_CLOSED	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_chair_n_lzsa		; north bg
	.word	book_chair_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff		; special exit

; SHIP_BOOK_CLOSED		-- stoney linking book, closed
location5:
	.byte	$ff			; north exit
	.byte	SHIP_BOOK_OPEN		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	book_chair_closed_s_lzsa	; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH
	.byte	$ff		; special exit

; SHIP_BOOK_OPEN			-- stoney linking book, open
location6:
	.byte	$ff			; north exit
	.byte	SHIP_CHAIR		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	book_chair_open_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH
	.byte   DIRECTION_S     ; special exit
	.byte	21,31   ; special x
	.byte	10,24   ; special y
	.word	stoney_link_book-1



