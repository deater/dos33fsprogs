;===============================================
; level data for Arbor trees
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8, location9, location10,location11
	.word location12,location13,location14,location15
	.word location16,location17,location18,location19
	.word location20,location21,location22,location23

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
	.byte	ARBOR_SWITCH_BRIDGE1	; south exit
	.byte	ARBOR_BRIDGE4		; east exit
	.byte	ARBOR_LONGSHACK1	; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	longshack2_n_lzsa	; north bg
	.word	longshack2_s_lzsa	; south bg
	.word	longshack2_e_lzsa	; east bg
	.word	longshack2_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff

; ARBOR_SWITCH_BRIDGE1		-- first bridge leading to switch
location11:
	.byte	ARBOR_LONGSHACK2	; north exit
	.byte	ARBOR_SWITCH_HUT1	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	switch_bridge1_n_lzsa	; north bg
	.word	switch_bridge1_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; ARBOR_SWITCH_HUT1		-- first hut on way to switch
location12:
	.byte	ARBOR_SWITCH_BRIDGE1	; north exit
	.byte	$ff			; south exit
	.byte	ARBOR_SWITCH_BRIDGE2	; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	switch_hut1_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	switch_hut1_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_EAST
	.byte	$ff

; ARBOR_SWITCH_BRIDGE2		-- second bridge on way to switch
location13:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	ARBOR_SWITCH_HUT	; east exit
	.byte	ARBOR_SWITCH_HUT1	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	switch_bridge2_e_lzsa	; east bg
	.word	switch_bridge2_w_lzsa	; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff

; ARBOR_SWITCH_HUT		-- hut with hard-to-find switch
location14:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	ARBOR_SWITCH_BRIDGE2	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	switch_hut_closed_s_lzsa; south bg
	.word	$0000			; east bg
	.word	switch_hut_w_lzsa	; west bg
	.byte	BG_WEST|BG_SOUTH
	.byte	DIRECTION_S	; special exit
	.byte	16,22		; special x
	.byte	28,40		; special y
	.word	hut_handle-1	; special function

; ARBOR_BRIDGE4		-- bridge out of the longshack
location15:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	ARBOR_HUT2		; east exit
	.byte	ARBOR_LONGSHACK2	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	bridge4_e_lzsa		; east bg
	.word	bridge4_w_lzsa		; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff

; ARBOR_HUT2		-- next hut
location16:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	ARBOR_HUT2_INSIDE	; east exit
	.byte	ARBOR_BRIDGE4		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	hut2_e_lzsa		; east bg
	.word	hut2_w_lzsa		; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff

; ARBOR_HUT2_INSIDE		-- inside next hut
location17:
	.byte	$ff			; north exit
	.byte	ARBOR_BRIDGE5		; south exit
	.byte	$ff			; east exit
	.byte	ARBOR_HUT2		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	hut2_inside_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	hut2_inside_w_lzsa	; west bg
	.byte	BG_WEST|BG_SOUTH
	.byte	$ff

; ARBOR_BRIDGE5			-- next bridge
location18:
	.byte	ARBOR_HUT2_INSIDE	; north exit
	.byte	ARBOR_LONGSHACK3	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_W	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	bridge5_n_lzsa		; north bg
	.word	bridge5_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; ARBOR_LONGSHACK3		-- next longshack
location19:
	.byte	ARBOR_BRIDGE5		; north exit
	.byte	ARBOR_BRIDGE6		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	longshack3_n_lzsa	; north bg
	.word	longshack3_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; ARBOR_BRIDGE6		-- the next bridge
location20:
	.byte	ARBOR_LONGSHACK3	; north exit
	.byte	ARBOR_SHACK2		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	bridge6_n_lzsa	; north bg
	.word	bridge6_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; ARBOR_SHACK2		-- the shack before the elevator
location21:
	.byte	ARBOR_LONGSHACK3	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	ARBOR_BRIDGE7		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	shack2_n_lzsa		; north bg
	.word	shack2_s_lzsa		; south bg
	.word	shack2_e_lzsa		; east bg
	.word	shack2_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff

; ARBOR_BRIDGE7		-- the bridge before the doors
location22:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	ARBOR_SHACK2		; east exit
	.byte	ARBOR_DOORS		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	bridge7_e_lzsa		; east bg
	.word	bridge7_closed_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; ARBOR_DOORS		-- doors to the stair and elevator
location23:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	ARBOR_BRIDGE7		; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	doors_e_lzsa		; east bg
	.word	doors_closed_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff



