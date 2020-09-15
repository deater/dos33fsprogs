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
	.byte	4				; num areas
	.byte	3

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
	.byte	4				; num areas
	.byte	3

		.byte	12,15	; x
		.byte	18,28	; y
		.word	lookout_string		; name
		.word	lookout_action-1	; action

		.byte	12,15	; x
		.byte	18,28	; y
		.word	path_string		; name
		.word	path_action-1		; action

		.byte	12,15	; x
		.byte	18,28	; y
		.word	stairs_string		; name
		.word	stairs_action-1		; action

; MONKEY_DOCK		-- dock
location2:
	.word	dock_lzsa			; background
	.byte	18,40				; walking range X
	.byte	16,48				; walking range Y
	.byte	4				; num areas
	.byte	3

		.byte	12,15	; x
		.byte	18,28	; y
		.word	lookout_string		; name
		.word	lookout_action-1	; action

		.byte	12,15	; x
		.byte	18,28	; y
		.word	path_string		; name
		.word	path_action-1		; action

		.byte	12,15	; x
		.byte	18,28	; y
		.word	stairs_string		; name
		.word	stairs_action-1		; action

; MONKEY_BAR		-- scumm bar
location3:
	.word	bar_lzsa			; background
	.byte	18,40				; walking range X
	.byte	16,48				; walking range Y
	.byte	4				; num areas
	.byte	3

		.byte	12,15	; x
		.byte	18,28	; y
		.word	lookout_string		; name
		.word	lookout_action-1	; action

		.byte	12,15	; x
		.byte	18,28	; y
		.word	path_string		; name
		.word	path_action-1		; action

		.byte	12,15	; x
		.byte	18,28	; y
		.word	stairs_string		; name
		.word	stairs_action-1		; action




string_data:
lookout_string:	.byte "LOOKOUT",0
path_string:	.byte "PATH",0
stairs_string:	.byte "STAIRS",0

