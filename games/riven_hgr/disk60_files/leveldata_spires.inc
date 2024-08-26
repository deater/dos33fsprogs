;===============================================
; level data for spires
;===============================================

locations:
	.word location0

; RIVEN_SPIRES	-- spires
location0:
	.byte	$ff				; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	spires_n_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff
