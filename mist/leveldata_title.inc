;===============================================
; level data for Title
;===============================================

locations:
	.word location0

; myst linking book
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	m_link_book_lzsa	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH	; only north bg
	.byte	DIRECTION_N	; special exit
	.byte	21,31		; special x
	.byte	10,24		; special y
	.word	mist_link_book-1		; special function


