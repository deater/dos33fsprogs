
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
	.word location40,location41,location42


; STONEY_SHIP_STERN		-- back of the ship
location0:
	.byte	STONEY_SHIP_BOW		; north exit
	.byte	STONEY_SHIP_DOOR_CLOSED	; south exit
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

; STONY_SHIP_BOW		-- bow of the ship
location1:
	.byte	$ff			; north exit
	.byte	STONEY_SHIP_STERN	; south exit
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

; STONEY_SHIP_DOOR_CLOSED		-- ship cabin door
location2:
	.byte	STONEY_SHIP_BOW		; north exit
	.byte	STONEY_SHIP_DOOR_OPEN	; south exit
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

; STONEY_SHIP_DOOR_OPEN			-- ship cabin door open
location3:
	.byte	STONEY_SHIP_BOW		; north exit
	.byte	STONEY_SHIP_CHAIR	; south exit
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

; STONEY_SHIP_CHAIR			-- chair in the cabin
location4:
	.byte	STONEY_SHIP_STERN	; north exit
	.byte	STONEY_SHIP_BOOK_CLOSED	; south exit
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

; STONEY_SHIP_BOOK_CLOSED		-- stoney linking book, closed
location5:
	.byte	$ff			; north exit
	.byte	STONEY_SHIP_BOOK_OPEN	; south exit
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

; STONEY_SHIP_BOOK_OPEN			-- stoney linking book, open
location6:
	.byte	$ff			; north exit
	.byte	STONEY_SHIP_CHAIR	; south exit
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

; STONEY_ARRIVAL			-- arrival at stoneship
location7:
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
location8:
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
location9:
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
	.byte	$ff

; STONEY_LIGHTHOUSE_PATH			-- lighthouse path
location10:
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
location11:
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
location12:
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
location13:
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
	.byte	$ff

; STONEY_LIGHTHOUSE_BATTERY		-- lighthouse battery
location14:
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
location15:
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
location16:
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
location17:
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
location18:
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
location19:
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
location20:
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
location21:
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
location22:
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
location23:
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
location24:
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
location25:
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
location26:
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
location27:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_TELESCOPE_PATH1		; east exit
	.byte	STONEY_BRIDGE			; west exit
	.byte	$ff		; north exit_dir
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
location28:
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
location29:
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
location30:
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
location31:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_TELESCOPE_VIEW		; east exit
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
	.byte	$ff

; STONEY_TELESCOPE_VIEW		-- telescope
location32:
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
	.byte	$ff

; STONEY_LEFT_TUNNEL1		-- left tunnel to red room
location33:
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
location34:
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
	.byte	$ff

; STONEY_LEFT_AIRLOCK		-- airlock to red room
location35:
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
location36:
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
location37:
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
location38:
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
location39:
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
location40:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_LEFT_TUNNEL2		; east exit
	.byte	STONEY_COMPASS_ROOM		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	crawlway_e_lzsa		; east bg
	.word	crawlway_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; STONEY_COMPASS_ROOM	-- compass room
location41:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	STONEY_CRAWLWAY_LEFT		; east exit
	.byte	STONEY_COMPASS_ROSE		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	compass_room_e_lzsa	; east bg
	.word	compass_room_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; STONEY_COMPASS_ROSE	-- compass rose
location42:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	STONEY_COMPASS_ROOM		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	compass_rose_w_lzsa	; west bg
	.byte	BG_WEST
	.byte	$ff
