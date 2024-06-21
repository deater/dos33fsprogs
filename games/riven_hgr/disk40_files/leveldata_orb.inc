;===============================================
; level data for 1st Orb
;===============================================

locations:
	.word location0


; technically in the actual game you can look south/west to slightly
; different backgrounds, but for various reasons we're going to just
; back out when given the chance

; RIVEN_ORB1  -- first orb
location0:
	.byte	LOAD_OUTSIDE<<4|RIVEN_OUTSIDE_PLAZA		; north exit
	.byte	$FF		; south exit
	.byte	$FF		; east exit
	.byte	$FF		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	orb_n_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	15,23		; special x
	.byte	64,118		; special y
	.word	orb_clicked-1	; special function

