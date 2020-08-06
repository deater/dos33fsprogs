
;===============================================
; level data for Stoney Ship
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8, location9, location10,location11
	.word location12,location13,location14,location15
	.word location16,location17,location18,location19
	.word location20,location21,location22,location23
	.word location24,location25,location26,location27
	.word location28,location29,location30,location31
	.word location32,location33,location34,location35
	.word location36,location37,location38,location39
	.word location40,location41,location42,location43
	.word location44,location45,location46,location47
	.word location48

; STONEY_ARRIVAL			-- arrival at stoneship
location0:
	.byte	STONEY_DOORWAY1		; north exit
	.byte	STONEY_EXIT		; south exit
	.byte	STONEY_LIGHTHOUSE_PATH	; east exit
	.byte	STONEY_UMBRELLA_PATH	; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	arrival_n_lzsa			; north bg
	.word	arrival_s_lzsa			; south bg
	.word	arrival_e_lzsa			; east bg
	.word	arrival_w_lzsa			; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff

; STONEY_UMBRELLA_PATH			-- umbrella path
location1:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	STONEY_ARRIVAL		; east exit
	.byte	STONEY_UMBRELLA		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	umbrella_path_e_lzsa	; east bg
	.word	umbrella_path_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; STONEY_UMBRELLA			-- umbrella switch
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	STONEY_UMBRELLA_PATH	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	umbrella_e_lzsa		; east bg
	.word	umbrella_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte   DIRECTION_W     ; special exit
	.byte	13,26   ; special x
	.byte	18,24   ; special y
	.word	umbrella_buttons-1


; STONEY_LIGHTHOUSE_PATH			-- lighthouse path
location3:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	STONEY_LIGHTHOUSE_DOOR	; east exit
	.byte	STONEY_ARRIVAL		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	lighthouse_path_e_lzsa	; east bg
	.word	lighthouse_path_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; STONEY_LIGHTHOUSE_DOOR			-- lighthouse door
location4:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	STONEY_LIGHTHOUSE_INSIDE; east exit
	.byte	STONEY_LIGHTHOUSE_PATH	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	lighthouse_door_e_lzsa	; east bg
	.word	lighthouse_door_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; STONEY_LIGHTHOUSE_INSIDE		-- lighthouse inside
location5:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	STONEY_LIGHTHOUSE_UPSTAIRS; east exit
	.byte	STONEY_LIGHTHOUSE_DOOR	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	lighthouse_inside_n_lzsa	; north bg
	.word	$0000				; south bg
	.word	lighthouse_inside_e_lzsa	; east bg
	.word	lighthouse_inside_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST|BG_NORTH
	.byte	$ff

; STONEY_LIGHTHOUSE_UPSTAIRS		-- lighthouse upstairs
location6:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_LIGHTHOUSE_DOWNLADDER	; east exit
	.byte	STONEY_LIGHTHOUSE_BATTERY	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	lighthouse_upstairs_e_lzsa	; east bg
	.word	lighthouse_upstairs_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte   DIRECTION_W     ; special exit
	.byte	15,24   ; special x
	.byte	27,42   ; special y
	.word	handle_crank-1


; STONEY_LIGHTHOUSE_BATTERY		-- lighthouse battery
location7:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	STONEY_LIGHTHOUSE_UPSTAIRS	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	lighthouse_battery_w_lzsa	; west bg
	.byte	BG_WEST
	.byte	$ff

; STONEY_LIGHTHOUSE_DOWNLADDER		-- lighthouse down the ladder
location8:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_LIGHTHOUSE_INSIDE	; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	lighthouse_downladder_e_lzsa	; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	$ff

; STONEY_DOORWAY1		-- doorway1
location9:
	.byte	STONEY_LEFT_TUNNEL1		; north exit
	.byte	STONEY_ARRIVAL			; south exit
	.byte	STONEY_BRIDGE			; east exit
	.byte	STONEY_ARRIVAL			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	doorway1_n_lzsa		; north bg
	.word	doorway1_s_lzsa		; south bg
	.word	doorway1_e_lzsa		; east bg
	.word	doorway1_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST|BG_NORTH|BG_SOUTH
	.byte	$ff

; STONEY_BRIDGE		-- bridge between sections
location10:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_DOORWAY2			; east exit
	.byte	STONEY_DOORWAY1			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	bridge_e_lzsa		; east bg
	.word	bridge_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; STONEY_EXIT		-- exit door
location11:
	.byte	STONEY_ARRIVAL			; north exit
	.byte	STONEY_EXIT_AIRLOCK		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	exit_tunnel_n_lzsa	; north bg
	.word	exit_tunnel_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; STONEY_EXIT_AIRLOCK		-- exit door airlock
location12:
	.byte	STONEY_EXIT			; north exit
	.byte	STONEY_EXIT_AIRLOCK_OPEN	; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	exit_airlock_n_lzsa	; north bg
	.word	exit_airlock_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; STONEY_EXIT_AIRLOCK_OPEN	-- exit door airlock open
location13:
	.byte	$ff				; north exit
	.byte	STONEY_BOOK_STAIRS1		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	exit_airlock_open_s_lzsa	; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH
	.byte	$ff

; STONEY_BOOK_STAIRS1		-- exit door top of stairs
location14:
	.byte	STONEY_EXIT_AIRLOCK		; north exit
	.byte	STONEY_BOOK_STAIRS2		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_N	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_stairs1_n_lzsa	; north bg
	.word	book_stairs1_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; STONEY_BOOK_STAIRS2		-- stairs landing
location15:
	.byte	STONEY_BOOK_ROOM		; north exit
	.byte	STONEY_BOOK_STAIRS1		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_N	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_stairs2_n_lzsa	; north bg
	.word	book_stairs2_w_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; STONEY_BOOK_ROOM		-- table book room
location16:
	.byte	STONEY_BOOK_TABLE		; north exit
	.byte	STONEY_BOOK_STAIRS2		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_room_n_lzsa	; north bg
	.word	book_room_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; STONEY_BOOK_TABLE		-- table book
location17:
	.byte	STONEY_BOOK_TABLE_CLOSED	; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff			; west exit_dir
	.word	book_table_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff


; STONEY_BOOK_TABLE_CLOSED		-- table book closed
location18:
	.byte	STONEY_BOOK_TABLE_OPEN		; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff				; west exit_dir
	.word	book_table_closed_n_lzsa	; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH
	.byte	$ff

; STONEY_BOOK_TABLE_OPEN		-- table book open
location19:
	.byte	STONEY_BOOK_ROOM		; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff			; west exit_dir
	.word	book_table_open_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte   DIRECTION_N
	.byte	24,32		; special x
	.byte	12,22		; special y
	.word	mist_link_book-1	; special function

; STONEY_DOORWAY2		-- doorway on other half of ship
location20:
	.byte	STONEY_RIGHT_TUNNEL1		; north exit
	.byte	$ff				; south exit
	.byte	STONEY_TELESCOPE_PATH1		; east exit
	.byte	STONEY_BRIDGE			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	doorway2_n_lzsa		; north bg
	.word	doorway2_s_lzsa		; south bg
	.word	doorway2_e_lzsa		; east bg
	.word	doorway2_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff

; STONEY_TELSCOPE_PATH1		-- path to telescope
location21:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_TELESCOPE_PATH2		; east exit
	.byte	STONEY_DOORWAY2			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	telescope_path1_e_lzsa	; east bg
	.word	telescope_path1_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; STONEY_TELESCOPE_PATH2		-- path to telescope
location22:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_TELESCOPE_PATH3		; east exit
	.byte	STONEY_TELESCOPE_PATH1		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	telescope_path2_e_lzsa	; east bg
	.word	telescope_path2_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; STONEY_TELESCOPE_PATH3		-- path to telescope
location23:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_TELESCOPE		; east exit
	.byte	STONEY_TELESCOPE_PATH2		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	telescope_path3_w_lzsa	; east bg
	.word	telescope_path3_e_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; STONEY_TELESCOPE		-- telescope
location24:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	STONEY_TELESCOPE_PATH3		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E|DIRECTION_SPLIT	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	telescope_e_lzsa	; east bg
	.word	telescope_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte   DIRECTION_E     ; special exit
	.byte	16,25   ; special x
	.byte	10,20   ; special y
	.word	goto_telescope-1

; STONEY_TELESCOPE_VIEW		-- telescope
location25:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_TELESCOPE		; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	telescope_view_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte   DIRECTION_E     ; special exit
	.byte	10,30   ; special x
	.byte	16,40   ; special y
	.word	telescope_pan-1

; STONEY_LEFT_TUNNEL1		-- left tunnel to red room
location26:
	.byte	STONEY_LEFT_TUNNEL2		; north exit
	.byte	STONEY_DOORWAY1			; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	left_tunnel1_n_lzsa	; north bg
	.word	left_tunnel1_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; STONEY_LEFT_TUNNEL2		-- left tunnel to red room, with side
location27:
	.byte	STONEY_LEFT_AIRLOCK		; north exit
	.byte	STONEY_LEFT_TUNNEL1		; south exit
	.byte	$ff				; east exit
	.byte	STONEY_CRAWLWAY_LEFT		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	left_tunnel2_n_lzsa	; north bg
	.word	left_tunnel2_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	left_tunnel2_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_WEST
	.byte   DIRECTION_N
        .byte   11,18		; special x
        .byte   22,44		; special y
        .word   enter_crawlway_left-1 ; special function


; STONEY_LEFT_AIRLOCK		-- airlock to red room
location28:
	.byte	STONEY_LEFT_AIRLOCK_OPEN	; north exit
	.byte	STONEY_LEFT_TUNNEL2		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	left_airlock_n_lzsa	; north bg
	.word	left_airlock_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; STONEY_LEFT_AIRLOCK_OPEN	-- airlock to red room, open
location29:
	.byte	STONEY_RED_ROOM			; north exit
	.byte	STONEY_LEFT_TUNNEL2		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	left_airlock_open_n_lzsa	; north bg
	.word	left_airlock_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; STONEY_RED_ROOM	-- red room
location30:
	.byte	$ff				; north exit
	.byte	STONEY_LEFT_AIRLOCK		; south exit
	.byte	$ff				; east exit
	.byte	STONEY_RED_ROOM_DRESSER		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	red_room_n_lzsa		; north bg
	.word	red_room_s_lzsa		; south bg
	.word	red_room_e_lzsa		; east bg
	.word	red_room_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff

; STONEY_RED_ROOM_DRESSER	-- red room dresser
location31:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	STONEY_RED_DRESSER_OPEN		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	dresser_e_lzsa		; west bg
	.byte	BG_WEST
	.byte	$ff

; STONEY_RED_DRESSER_OPEN	-- red room dresser open
location32:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	STONEY_RED_ROOM			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	dresser_open_e_lzsa	; west bg
	.byte	BG_WEST
	.byte   DIRECTION_W
        .byte   14,21		; special x
        .byte   36,46		; special y
        .word   stoney_take_red_page-1 ; special function

; STONEY_CRAWLWAY_LEFT	-- left crawlway
location33:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_CRAWLWAY_ENTRANCE_LEFT	; east exit
	.byte	STONEY_COMPASS_ROOM_LEFT	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	crawlway_e_lzsa		; east bg
	.word	crawlway_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; STONEY_COMPASS_ROOM_LEFT	-- compass room from left
location34:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_CRAWLWAY_LEFT		; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	compass_room_e_lzsa	; east bg
	.word	compass_room_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte   DIRECTION_W
        .byte   12,40		; special x
        .byte   0,46		; special y
        .word   view_compass_left-1 ; special function

; STONEY_COMPASS_ROSE_LEFT	-- compass rose
location35:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	STONEY_COMPASS_ROOM_LEFT	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	compass_rose_w_lzsa	; west bg
	.byte	BG_WEST
	.byte   DIRECTION_W
        .byte   6,35		; special x
        .byte   0,46		; special y
        .word   view_compass_right-1 ; special function

; STONEY_RIGHT_TUNNEL1		-- right tunnel to blue room
location36:
	.byte	STONEY_RIGHT_TUNNEL2		; north exit
	.byte	STONEY_DOORWAY2			; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	right_tunnel1_n_lzsa	; north bg
	.word	right_tunnel1_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; STONEY_RIGHT_TUNNEL2		-- right tunnel to blue room, with side
location37:
	.byte	STONEY_RIGHT_AIRLOCK		; north exit
	.byte	STONEY_RIGHT_TUNNEL1		; south exit
	.byte	STONEY_CRAWLWAY_RIGHT		; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	right_tunnel2_n_lzsa	; north bg
	.word	right_tunnel2_s_lzsa	; south bg
	.word	right_tunnel2_w_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte   DIRECTION_N
        .byte   24,30		; special x
        .byte   22,44		; special y
        .word   enter_crawlway_right-1 ; special function

; STONEY_RIGHT_AIRLOCK		-- airlock to blue room
location38:
	.byte	STONEY_RIGHT_AIRLOCK_OPEN	; north exit
	.byte	STONEY_RIGHT_TUNNEL2		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	right_airlock_n_lzsa	; north bg
	.word	right_airlock_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; STONEY_RIGHT_AIRLOCK_OPEN	-- airlock to blue room, open
location39:
	.byte	STONEY_BLUE_ROOM		; north exit
	.byte	STONEY_RIGHT_TUNNEL2		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	right_airlock_open_n_lzsa	; north bg
	.word	left_airlock_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; STONEY_BLUE_ROOM	-- blue room
location40:
	.byte	$ff				; north exit
	.byte	STONEY_RIGHT_AIRLOCK		; south exit
	.byte	STONEY_BLUE_MAPCASE		; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_room_n_lzsa		; north bg
	.word	blue_room_s_lzsa		; south bg
	.word	blue_room_e_lzsa		; east bg
	.word	blue_room_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte   DIRECTION_W
        .byte   17,24		; special x
        .byte   34,44		; special y
        .word   stoney_take_blue_page-1 ; special function

; STONEY_BLUE_MAPCASE	-- blue room mapcase
location41:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_BLUE_MAPCASE_OPEN	; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	map_case_closed_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff

; STONEY_BLUE_MAPCASE_OPEN	-- blue room mapcase open
location42:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_BLUE_ROOM		; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	map_case_open_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte   DIRECTION_E
        .byte   14,21		; special x
        .byte   32,42		; special y
        .word   stoney_half_message-1 ; special function

; STONEY_BLUE_HALFMESSAGE	-- blue room halfmessag
location43:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_BLUE_MAPCASE_OPEN	; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	left_letter_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff

; STONEY_CRAWLWAY_RIGHT	-- right crawlway
location44:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_COMPASS_ROOM_RIGHT	; east exit
	.byte	STONEY_CRAWLWAY_ENTRANCE_RIGHT	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	crawlway_w_lzsa		; east bg
	.word	crawlway_e_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; STONEY_COMPASS_ROOM_RIGHT	-- compass room from right
location45:
	.byte	$ff				; north exit
	.byte	STONEY_CRAWLWAY_RIGHT		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	compass_room_n_lzsa	; north bg
	.word	compass_room_e_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte   DIRECTION_N
        .byte   0,28		; special x
        .byte   0,46		; special y
        .word   view_compass_right-1 ; special function


; STONEY_COMPASS_ROSE_RIGHT	-- compass rose approached from right
location46:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	STONEY_COMPASS_ROOM_RIGHT	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	compass_rose_w_lzsa	; west bg
	.byte	BG_WEST
	.byte   DIRECTION_W
        .byte   6,35		; special x
        .byte   0,46		; special y
        .word   view_compass_right-1 ; special function


; STONEY_CRAWLWAY_ENTRANCE_LEFT		-- left_crawlway_entrance
location47:
	.byte	STONEY_LEFT_AIRLOCK		; north exit
	.byte	STONEY_LEFT_TUNNEL1		; south exit
	.byte	STONEY_LEFT_TUNNEL2		; east exit
	.byte	STONEY_CRAWLWAY_LEFT		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	left_tunnel2_n_lzsa	; north bg
	.word	left_tunnel2_s_lzsa	; south bg
	.word	crawlway_entrance_e_lzsa	; east bg
	.word	left_tunnel2_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_WEST|BG_EAST
	.byte   $ff

; STONEY_CRAWLWAY_ENTRANCE_RIGHT	-- right crawlway entrance
location48:
	.byte	STONEY_RIGHT_AIRLOCK		; north exit
	.byte	STONEY_RIGHT_TUNNEL1		; south exit
	.byte	STONEY_CRAWLWAY_RIGHT		; east exit
	.byte	STONEY_RIGHT_TUNNEL2		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	right_tunnel2_n_lzsa		; north bg
	.word	right_tunnel2_s_lzsa		; south bg
	.word	right_tunnel2_w_lzsa		; east bg
	.word	crawlway_entrance_e_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff
