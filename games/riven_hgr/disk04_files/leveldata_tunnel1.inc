;===============================================
; level data for Tunnel1
;===============================================

locations:
	.word location0,location1

; RIVEN_TUNNEL1	-- just across bridge
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	RIVEN_TUNNEL2			; east exit
	.byte	LOAD_BRIDGE2<<4|RIVEN_BRIDGE2		; west exit
	.byte	$ff		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	tunnel1_e_zx02	; east bg
	.word	tunnel1_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; RIVEN_TUNNEL2	-- next tunnel segment
location1:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	LOAD_TUNNEL3<<4|RIVEN_TUNNEL3		; east exit
	.byte	RIVEN_TUNNEL1	; west exit
	.byte	$ff		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	tunnel2_e_zx02	; east bg
	.word	tunnel2_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

