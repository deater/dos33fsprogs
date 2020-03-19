
;===============================================
; level data for Meche level
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5

; MECHE_INSIDE_GEAR		-- Inside gear on Mist
location0:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_CLOSED_BOOK	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	departure_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff		; special exit


; MECHE_CLOSED_BOOK		-- closed book
location1:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_OPEN_BOOK		; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	meche_book_closed_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff		; special exit

; MECHE_OPEN_BOOK		-- open book
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_INSIDE_GEAR	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	meche_book_open_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	21,31		; special x
	.byte	10,24		; special y
	.word	meche_link_book-1		; special function


; MECHE_ARRIVAL			-- arrival
location3:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MECHE_ENTRANCE		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	arrival_w_lzsa		; west bg
	.byte	BG_WEST
	.byte	$ff		; special exit

; MECHE_ENTRANCE		-- entrance
location4:
	.byte	MECHE_FORT_VIEW		; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MECHE_ARRIVAL		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	entrance_n_lzsa		; north bg
	.word	entrance_s_lzsa		; south bg
	.word	entrance_e_lzsa		; east bg
	.word	entrance_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff		; special exit

; MECHE_FORT_VIEW		-- fort view
location5:
	.byte	MECHE_FORT_VIEW		; north exit
	.byte	MECHE_ENTRANCE		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_S	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	fort_view_n_lzsa	; north bg
	.word	fort_view_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

