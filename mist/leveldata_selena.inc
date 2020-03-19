
;===============================================
; level data for Selena level
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8, location9, location10

; Inside Ship
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	1		; east exit
	.byte	2		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	(DIRECTION_E|DIRECTION_ONLY_POINT)	; east exit_dir
	.byte	(DIRECTION_W|DIRECTION_ONLY_POINT)	; west exit_dir
	.word	spaceship_inside_mist_n_lzsa	; north bg
	.word	$0000				; south bg
	.word	spaceship_inside_e_lzsa		; east bg
	.word	spaceship_inside_w_lzsa		; west bg
	.byte	BG_WEST | BG_EAST | BG_NORTH
	.byte	DIRECTION_N		; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	back_to_mist-1	; special function

; controls
location1:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	0		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	controls_e_lzsa		; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	12,25		; special x
	.byte	26,46		; special y
	.word	controls_pressed-1		; special function


; electric organ
location2:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	0		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	organ_w_lzsa		; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	7,31		; special x
	.byte	24,34		; special y
	.word	organ_pressed-1		; special function


; walkway1
location3:
	.byte	5		; north exit
	.byte	4		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	walkway1_n_lzsa		; north bg
	.word	walkway1_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff

; spaceship door
location4:
	.byte	$ff		; north exit
	.byte	3		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_N	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	spaceship_door_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	$ff

; walkway4
location5:
	.byte	6		; north exit
	.byte	3		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	walkway4_n_lzsa		; north bg
	.word	walkway4_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; bunker
location6:
	.byte	$ff		; north exit
	.byte	5		; south exit
	.byte	7		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	bunker_n_lzsa		; north bg
	.word	bunker_s_lzsa		; south bg
	.word	bunker_e_lzsa		; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte	$ff

; sub room
location7:
	.byte	$ff		; north exit
	.byte	8		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	subroom_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$ff

; book room
location8:
	.byte	$ff		; north exit
	.byte	9		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	book_table_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	$ff

; book
location9:
	.byte	$ff		; north exit
	.byte	10		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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

; mist book open
location10:
	.byte	$ff		; north exit
	.byte	8		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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

