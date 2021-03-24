; Ootw Checkpoint2 intro movie

ootw_c2_intro:
	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	bit	KEYRESET
	;===========================
	; Setup pages (is this necessary?)

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE

	lda     #<intro2_sequence
	sta     INTRO_LOOPL
	lda	#>intro2_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

done_intro2:
	rts


;========================
; Gently swinging cage

; remeber, we can auto-increment by oring timeout with 128

intro2_sequence:
	.byte	255
	.word	cage_01_lzsa
	.byte	25
	.word	cage_01_lzsa
	.byte	25
	.word	cage_02_lzsa
	.byte	25
	.word	cage_03_lzsa
	.byte	25
	.word	cage_04_lzsa
	.byte	75
	.word	cage_03_lzsa
	.byte	25
	.word	cage_02_lzsa
	.byte	25
	.word	cage_01_lzsa
	.byte	75
	.word	cage_02_lzsa
	.byte	25
	.word	cage_03_lzsa
;	.byte	25
;	.word	cage_03_lzsa

;======================
; eyes opening

	.byte	255
	.word	eyes_bg_lzsa
	.byte	25
	.word	eyes_01_lzsa
	.byte	25
	.word	eyes_02_lzsa
	.byte	25
	.word	eyes_03_lzsa
	.byte	25
	.word	eyes_02_lzsa
	.byte	25
	.word	eyes_01_lzsa
	.byte	100
	.word	eyes_02_lzsa
	.byte	15
	.word	eyes_03_lzsa
	.byte	15
	.word	eyes_04_lzsa
	.byte	15
	.word	eyes_05_lzsa
	.byte	40
	.word	eyes_04_lzsa
	.byte	40
	.word	eyes_03_lzsa
	.byte	40
	.word	eyes_02_lzsa
	.byte	40
	.word	eyes_01_lzsa
	.byte	80
	.word	eyes_03_lzsa
	.byte	15
	.word	eyes_04_lzsa
	.byte	15
	.word	eyes_05_lzsa
	.byte	15
	.word	eyes_bg_lzsa

;=================
; focusing on friend

	.byte	100
	.word	friend_02_lzsa
	.byte	25
	.word	friend_03_lzsa
	.byte	25
	.word	friend_04_lzsa
	.byte	25
	.word	friend_03_lzsa
	.byte	25
	.word	friend_02_lzsa
	.byte	25
	.word	friend_03_lzsa
	.byte	25
	.word	friend_04_lzsa
	.byte	25
	.word	friend_05_lzsa
	.byte	40
	.word	friend_06_lzsa
	.byte	40
	.word	friend_05_lzsa
	.byte	40
	.word	friend_05_lzsa

	.byte	0


