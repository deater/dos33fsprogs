;===============================================
; level data for D'NI
;===============================================

locations:
	.word location0, location1, location2, location3

; DNI_ARRIVAL	-- deep underneath New Mexico
location0:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	dni_n_lzsa			; north bg
	.word	dni_s_lzsa			; south bg
	.word	dni_e_lzsa			; east bg
	.word	dni_w_lzsa			; west bg
	.byte	BG_EAST|BG_WEST|BG_SOUTH|BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	10,24	; special x
	.byte	18,38	; special y
	.word   visit_atrus-1      ; special function

; DNI_DESK	-- Atrus' desk
location1:
	.byte	$ff			; north exit
	.byte	DNI_ARRIVAL		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	dni_desk_n_lzsa			; north bg
	.word	dni_desk_s_lzsa			; south bg
	.word	$0000				; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	13,27	; special x
	.byte	6,40	; special y
	.word   poke_atrus-1	; special function

; DNI_MIST_BOOK	-- mist book closed
location2:
	.byte	DNI_MIST_BOOK_OPEN	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	dni_desk_book_closed_n_lzsa	; north bg
	.word	dni_desk_s_lzsa			; south bg
	.word	$0000				; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff		; special exit

; DNI_MIST_BOOK_OPEN	-- mist book open
location3:
	.byte	DNI_DESK		; north exit
	.byte	DNI_ARRIVAL		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	dni_desk_book_open_n_lzsa	; north bg
	.word	dni_desk_s_lzsa			; south bg
	.word	$0000				; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	21,31	; special x
	.byte	10,24	; special y
	.word   mist_link_book-1	; special function

