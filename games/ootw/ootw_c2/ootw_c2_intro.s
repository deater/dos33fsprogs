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
	.word	cage_01_rle
	.byte	25
	.word	cage_01_rle
	.byte	25
	.word	cage_02_rle
	.byte	25
	.word	cage_03_rle
	.byte	25
	.word	cage_04_rle
	.byte	75
	.word	cage_03_rle
	.byte	25
	.word	cage_02_rle
	.byte	25
	.word	cage_01_rle
	.byte	75
	.word	cage_02_rle
	.byte	25
	.word	cage_03_rle
;	.byte	25
;	.word	cage_03_rle

;======================
; eyes opening

	.byte	255
	.word	eyes_bg_rle
	.byte	25
	.word	eyes_01_rle
	.byte	25
	.word	eyes_02_rle
	.byte	25
	.word	eyes_03_rle
	.byte	25
	.word	eyes_02_rle
	.byte	25
	.word	eyes_01_rle
	.byte	100
	.word	eyes_02_rle
	.byte	15
	.word	eyes_03_rle
	.byte	15
	.word	eyes_04_rle
	.byte	15
	.word	eyes_05_rle
	.byte	40
	.word	eyes_04_rle
	.byte	40
	.word	eyes_03_rle
	.byte	40
	.word	eyes_02_rle
	.byte	40
	.word	eyes_01_rle
	.byte	80
	.word	eyes_03_rle
	.byte	15
	.word	eyes_04_rle
	.byte	15
	.word	eyes_05_rle
	.byte	15
	.word	eyes_bg_rle

;=================
; focusing on friend

	.byte	100
	.word	friend_02_rle
	.byte	25
	.word	friend_03_rle
	.byte	25
	.word	friend_04_rle
	.byte	25
	.word	friend_03_rle
	.byte	25
	.word	friend_02_rle
	.byte	25
	.word	friend_03_rle
	.byte	25
	.word	friend_04_rle
	.byte	25
	.word	friend_05_rle
	.byte	40
	.word	friend_06_rle
	.byte	40
	.word	friend_05_rle
	.byte	40
	.word	friend_05_rle

	.byte	0


