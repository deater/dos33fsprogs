;===============================================
; level data for Nibel clouds
;===============================================

locations:
	.word location0, location1, location2, location3

; NIBEL_IN_ELEV2_TOP_CLOSED	-- inside elevator2 at top, door closed
location0:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	NIBEL_IN_ELEV2_TOP_OPEN	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	elevator2_closed_top_lzsa	; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	28,34		; special x
	.byte	28,36		; special y
	.word	elevator2_handle-1	; special function

; NIBEL_IN_ELEV2_TOP_OPEN	-- inside elevator2 at top, door open
location1:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	NIBEL_OUTSIDE_ELEV2_CLOSED	; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	elevator2_open_top_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	10,17		; special x
	.byte	6,46		; special y
	.word	elevator2_close_door-1	; special function

; NIBEL_OUTSIDE_ELEV2_OPEN	-- outside of elevator2 at top, door open
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	NIBEL_IN_ELEV2_TOP_OPEN	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_E	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	outside_elevator2_e_lzsa	; east bg
	.word	outside_elevator2_open_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; NIBEL_OUTSIDE_ELEV2_CLOSED	-- outside of elevator2 at top, door closed
location3:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	NIBEL_OUTSIDE_ELEV2_OPEN	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	outside_elevator2_e_lzsa	; east bg
	.word	outside_elevator2_closed_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

