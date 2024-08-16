;===============================================
; level data for chair level
;===============================================

locations:
	.word location0,location1,location2,location3
	.word location4,location5

; RIVEN_CHAIR2 -- scary chair even closer
location0:
	.byte	RIVEN_CHAIR3	; north exit
	.byte	LOAD_CHAIR<<4|RIVEN_CHAIR	; south exit
	.byte	RIVEN_PORTHOLE_L	; east exit
	.byte	RIVEN_PORTHOLE_R	; west exit
	.byte	DIRECTION_S	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.word	chair2_n_zx02	; north bg
	.word	chair2_s_zx02	; south bg
	.word	chair2_e_zx02	; east bg
	.word	chair2_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST	;
	.byte	$ff		; special exit

; RIVEN_CHAIR3 -- sitting in chair
location1:
	.byte	$ff		; north exit
	.byte	RIVEN_CHAIR2	; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	chair3_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$ff		; special exit

; RIVEN_PORTHOLE_L -- looking at temple
location2:
	.byte	$ff		; north exit
	.byte	RIVEN_CHAIR2	; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	porthole_l_closed_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$ff		; special exit

; RIVEN_PORTHOLE_R -- looking at blue? maglev?
location3:
	.byte	$ff		; north exit
	.byte	RIVEN_CHAIR2	; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	porthole_r_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$ff		; special exit

; RIVEN_CHAIR3_DOWN -- sitting in chair, imager down
location4:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	chair3_down_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$ff		; special exit


; RIVEN_CHAIR3_DOWN_FLIP -- sitting in chair, down, flipped
location5:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	chair3_down_flip_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$ff		; special exit

