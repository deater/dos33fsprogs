;===============================================
; level data for Bridge
;===============================================

locations:
	.word location0,location1

; RIVEN_MID_BRIDGE	-- mid-bridge
location0:
	.byte	$FF	; north exit
	.byte	$ff		; south exit
	.byte	$E0	; new disk		; east exit
	.byte	RIVEN_FAR_BRIDGE		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	bridge_e_zx02	; east bg
	.word	bridge_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST	; bgs
	.byte	$ff		; special exit

; RIVEN_FAR_BRIDGE	-- far side of bridge
location1:
	.byte	$FF	; north exit
	.byte	$ff		; south exit
	.byte	RIVEN_MID_BRIDGE	; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	bridge_far_e_zx02	; east bg
	.word	bridge_far_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST	; bgs
	.byte	$ff		; special exit


