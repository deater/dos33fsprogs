;===============================================
; level data for Monkey
;===============================================

locations:
	.word location0,location1,location2,location3

; MONKEY_LOOKOUT	-- lookout tower
location0:
	.word	lookout_lzsa			; background
	.byte	18,40				; walking range X
	.byte	16,48				; walking range Y
	.byte	3				; num areas

		.byte	12,15	; x
		.byte	18,28	; y
		.word	lookout_string		; name
		.word	lookout_action-1	; action

		.byte	32,40	; x
		.byte	0,20	; y
		.word	path_string		; name
		.word	path_action-1		; action

		.byte	28,36	; x
		.byte	32,40	; y
		.word	stairs_string		; name
		.word	stairs_action-1		; action

; MONKEY_POSTER		-- house with poster
location1:
	.word	poster_lzsa			; background
	.byte	18,40				; walking range X
	.byte	16,48				; walking range Y
	.byte	2				; num areas

		.byte	0,5	; x
		.byte	0,40	; y
		.word	cliffside_string	; name
		.word	cliffside_action-1	; action

		.byte	26,30	; x
		.byte	22,32	; y
		.word	poster_string		; name
		.word	poster_action-1		; action

; MONKEY_DOCK		-- dock
location2:
	.word	dock_lzsa			; background
	.byte	18,40				; walking range X
	.byte	16,48				; walking range Y
	.byte	1				; num areas

		.byte	12,16	; x
		.byte	0,4	; y
		.word	moon_string		; name
		.word	moon_action-1	; action

; MONKEY_BAR		-- scumm bar
location3:
	.word	bar_lzsa			; background
	.byte	18,40				; walking range X
	.byte	16,48				; walking range Y
	.byte	1				; num areas

		.byte	9,14	; x
		.byte	20,32	; y
		.word	door_string		; name
		.word	door_action-1		; action


string_data:
lookout_string:	.byte 20,20,"LOOKOUT",0
path_string:	.byte 20,20,"PATH",0
stairs_string:	.byte 20,20,"STAIRS",0

cliffside_string:	.byte 20,20,"CLIFFSIDE",0
poster_string:	.byte 20,20,"POSTER",0

moon_string:	.byte 20,20,"MOON",0

door_string:	.byte 20,20,"DOOR",0
