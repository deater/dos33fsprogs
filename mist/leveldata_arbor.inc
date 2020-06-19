;===============================================
; level data for Arbor trees
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8, location9, location10


; ARBOR_INSIDE_ELEV1		-- arrival in elevator1
location0:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	ARBOR_INSIDE_ELEV1_OPEN	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	inside_elevator1_closed_w_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	26,34		; special x
	.byte	28,36		; special y
	.word	elev1_handle-1	; special function

; ARBOR_INSIDE_ELEV1_OPEN	-- arrival in elevator1, door open
location1:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	ARBOR_ARRIVAL_CLOSED	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	inside_elevator1_open_w_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	10,17		; special x
	.byte	6,46		; special y
	.word	elev1_close_door-1	; special function

; ARBOR_ARRIVAL_CLOSED		-- just outside elevator, closed
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	ARBOR_ARRIVAL_OPEN	; east exit
	.byte	ARBOR_BRIDGE1		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	arrival_e_lzsa		; east bg
	.word	arrival_w_lzsa		; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff

; ARBOR_ARRIVAL_OPEN		-- just outside elevator, open
location3:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	ARBOR_INSIDE_ELEV1_OPEN	; east exit
	.byte	ARBOR_BRIDGE1		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_W	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	arrival_open_e_lzsa	; east bg
	.word	arrival_w_lzsa		; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff

; ARBOR_BRIDGE1		-- first bridge
location4:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	ARBOR_ARRIVAL_CLOSED	; east exit
	.byte	ARBOR_HUT1		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	bridge1_e_lzsa		; east bg
	.word	bridge1_w_lzsa		; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff

; ARBOR_HUT1		-- first hut
location5:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	ARBOR_BRIDGE1	; east exit
	.byte	ARBOR_BRIDGE2	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	hut1_e_lzsa		; east bg
	.word	hut1_w_lzsa		; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff

; ARBOR_BRIDGE2		-- second bridge
location6:
	.byte	ARBOR_SHACK1	; north exit
	.byte	ARBOR_HUT1	; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	bridge2_n_lzsa		; north bg
	.word	bridge2_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; ARBOR_SHACK1		-- first shack
location7:
	.byte	$ff		; north exit
	.byte	ARBOR_BRIDGE2	; south exit
	.byte	ARBOR_BRIDGE3	; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	shack1_n_lzsa		; north bg
	.word	shack1_s_lzsa		; south bg
	.word	shack1_e_lzsa		; east bg
	.word	shack1_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff

; ARBOR_BRIDGE3		-- third bridge
location8:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	ARBOR_LONGSHACK1	; east exit
	.byte	ARBOR_SHACK1		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	bridge3_e_lzsa		; east bg
	.word	bridge3_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; ARBOR_LONGSHACK1		-- extra long shack
location9:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	ARBOR_LONGSHACK2	; east exit
	.byte	ARBOR_BRIDGE3		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	longshack1_e_lzsa	; east bg
	.word	longshack1_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; ARBOR_LONGSHACK2		-- extra long shack part 2
location10:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	ARBOR_LONGSHACK1	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	longshack2_n_lzsa	; north bg
	.word	longshack2_s_lzsa	; south bg
	.word	longshack2_e_lzsa	; east bg
	.word	longshack2_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff

