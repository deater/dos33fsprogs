;===============================================
; level data for Arbor trees
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6

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
	.byte	$ff		; north exit
	.byte	ARBOR_HUT1	; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	bridge2_n_lzsa		; north bg
	.word	bridge2_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff
