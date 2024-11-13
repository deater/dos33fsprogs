	; erase a list of boxes

erase_frame:
	lda	#<frame02_delete
	sta	INL
	lda	#>frame02_delete
	sta	INH

	ldy	#0
	sty	ERASE_OFFSET
next_box:

	ldy	ERASE_OFFSET
	lda	(INL),Y
	iny
	cmp	#$FE
	beq	erase_frame_done
	cmp	#$FF
	beq	erase_frame_totally_done
	sta	efo_x1_smc+1

	lda	(INL),Y
	sta	efo_x2_smc+1
	iny
	lda	(INL),Y
	sta	efo_y1_smc+1
	iny
	lda	(INL),Y
	sta	efo_y2_smc+1
	iny
	sty	ERASE_OFFSET

efo_y1_smc:
	ldx	#$dd
erase_frame_outer_loop:
	lda	hposn_low,X
	sta	OUTL
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	OUTH

efo_x1_smc:
	ldy	#$dd
	lda	#$00
erase_frame_inner_loop:
	sta	(OUTL),Y
	iny
efo_x2_smc:
	cpy	#$dd
	bne	erase_frame_inner_loop

	inx
efo_y2_smc:
	cpx	#$dd
	bne	erase_frame_outer_loop	; off by one
	beq	next_box		; bra

erase_frame_done:
	sty	ERASE_OFFSET

	lda	#4
	jsr	wait_ticks
;	jsr	wait_until_keypress

	jmp	next_box

erase_frame_totally_done:

	rts



; for frame 02
frame02_delete:
.byte 17,22,100,122	; 119,100 -> 153,121
.byte 20,23,122,129	; 140,122 -> 160,128
.byte 21,23,129,154	; 147,129 -> 160,153
.byte $FE
frame03_delete:
.byte 20,22,129,161	; 140,129 -> 153,160
.byte $FE
frame04_delete:
.byte 17,20,125,173	; 119,125 -> 139,172
.byte $FE
frame05_delete:
.byte 14,18,113,175	; 98,114 -> 125,174
.byte $FE
frame06_delete:
.byte 12,14,108,140	; 84,108 -> 97,139
.byte 14,15,109,112	; 98,109 -> 104,111
.byte 10,15,140,175	; 70,140 -> 104,174
.byte $FE
frame07_delete:
.byte  5,12,110,169	; 35,110 -> 83,168
.byte  8,12,105,111	; 56,105 -> 83,110
.byte  8,11,101,106	; 56,101 -> 76,105
.byte  9,10,101,106	; 63,100 -> 69,105
.byte 10,11, 96,106	; 70,96  -> 76,105
.byte $FE
frame08_delete:
.byte  4,11, 92,132	; 28,92 -> 76,131
.byte  4,10, 72, 93	; 28,72 -> 69,92
.byte  4, 9, 70, 73	; 28,70 -> 62,72
.byte  4, 8, 67, 71	; 28,67 -> 55,70
.byte  4, 6, 63, 68	; 28,63 -> 41,67
.byte  4, 5, 60, 64	; 28,60 -> 34,63
.byte $FE
frame09_delete:
.byte  8, 9, 21, 26	; 56,21 -> 62,25
.byte  5,10, 25, 43	; 35,25 -> 69,42
.byte  4,11, 42, 70	; 28,42 -> 76,69
.byte  9,11, 69, 73	; 63,69 -> 76,72
.byte $FE
frame10_delete:
.byte  9,16, 13, 56	; 63,13 -> 111,55
.byte 16,17, 14, 21	; 112,14 -> 118,20
.byte 12,13, 55, 58	; 84,55 -> 90,57
.byte $FE
frame11_delete:
.byte 16,23, 14, 61	; 112,14 -> 160,60
.byte 17,23, 60, 92	; 119,60 -> 160,91
.byte $FF


