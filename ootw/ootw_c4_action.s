; Ootw Checkpoint4 -- Foreground Action Sequence



;=================
;=================
; action sequence
;=================
;=================
; A has the sequence step+1

action_sequence:

	tax		; it's actually one higher
	dex

	lda	FRAMEL			; slow it down a bit
	and	#$3
	bne	not_done_action

	inc	ACTION_COUNT
	lda	ACTION_COUNT
	cmp	#69
	bne	not_done_action

	lda	#0
	sta	ACTION_COUNT

	rts

not_done_action:
	; draw both lines in the hlin
	lda	#$00
	sta	hlin_mask_smc+1

;	ldx	#65
	lda	action_list_lo,x
	sta	ac_jump
	lda     action_list_hi,x
	sta     ac_jump+1
	jmp     (ac_jump)

; Avoid $FF jump table bug on 6502
.align 2
ac_jump:
	.word   $0000
.align 1



action_list_lo:
	.byte	<action_frame1
	.byte	<action_frame2
	.byte	<action_frame3
	.byte	<action_frame4
	.byte	<action_frame5
	.byte	<action_frame6
	.byte	<action_frame7
	.byte	<action_frame8
	.byte	<action_frame9
	.byte	<action_frame10
	.byte	<action_frame11
	.byte	<action_frame12
	.byte	<action_frame13
	.byte	<action_frame14
	.byte	<action_frame15
	.byte	<action_frame16
	.byte	<action_frame17
	.byte	<action_frame18
	.byte	<action_frame19
	.byte	<action_frame20
	.byte	<action_frame21
	.byte	<action_frame22
	.byte	<action_frame23
	.byte	<action_frame24
	.byte	<action_frame25
	.byte	<action_frame26
	.byte	<action_frame27
	.byte	<action_frame28
	.byte	<action_frame29
	.byte	<action_frame30
	.byte	<action_frame31
	.byte	<action_frame32
	.byte	<action_frame33
	.byte	<action_frame34
	.byte	<action_frame35
	.byte	<action_frame36
	.byte	<action_frame37
	.byte	<action_frame38
	.byte	<action_frame39
	.byte	<action_frame40
	.byte	<action_frame41
	.byte	<action_frame42
	.byte	<action_frame43
	.byte	<action_frame44
	.byte	<action_frame45
	.byte	<action_frame46
	.byte	<action_frame47
	.byte	<action_frame48
	.byte	<action_frame49
	.byte	<action_frame50
	.byte	<action_frame51
	.byte	<action_frame52
	.byte	<action_frame53
	.byte	<action_frame54
	.byte	<action_frame55
	.byte	<action_frame56
	.byte	<action_frame57
	.byte	<action_frame58
	.byte	<action_frame59
	.byte	<action_frame60
	.byte	<action_frame61
	.byte	<action_frame62
	.byte	<action_frame63
	.byte	<action_frame64
	.byte	<action_frame65
	.byte	<action_frame66
	.byte	<action_frame67
	.byte	<action_frame68

action_list_hi:
	.byte	>action_frame1
	.byte	>action_frame2
	.byte	>action_frame3
	.byte	>action_frame4
	.byte	>action_frame5
	.byte	>action_frame6
	.byte	>action_frame7
	.byte	>action_frame8
	.byte	>action_frame9
	.byte	>action_frame10
	.byte	>action_frame11
	.byte	>action_frame12
	.byte	>action_frame13
	.byte	>action_frame14
	.byte	>action_frame15
	.byte	>action_frame16
	.byte	>action_frame17
	.byte	>action_frame18
	.byte	>action_frame19
	.byte	>action_frame20
	.byte	>action_frame21
	.byte	>action_frame22
	.byte	>action_frame23
	.byte	>action_frame24
	.byte	>action_frame25
	.byte	>action_frame26
	.byte	>action_frame27
	.byte	>action_frame28
	.byte	>action_frame29
	.byte	>action_frame30
	.byte	>action_frame31
	.byte	>action_frame32
	.byte	>action_frame33
	.byte	>action_frame34
	.byte	>action_frame35
	.byte	>action_frame36
	.byte	>action_frame37
	.byte	>action_frame38
	.byte	>action_frame39
	.byte	>action_frame40
	.byte	>action_frame41
	.byte	>action_frame42
	.byte	>action_frame43
	.byte	>action_frame44
	.byte	>action_frame45
	.byte	>action_frame46
	.byte	>action_frame47
	.byte	>action_frame48
	.byte	>action_frame49
	.byte	>action_frame50
	.byte	>action_frame51
	.byte	>action_frame52
	.byte	>action_frame53
	.byte	>action_frame54
	.byte	>action_frame55
	.byte	>action_frame56
	.byte	>action_frame57
	.byte	>action_frame58
	.byte	>action_frame59
	.byte	>action_frame60
	.byte	>action_frame61
	.byte	>action_frame62
	.byte	>action_frame63
	.byte	>action_frame64
	.byte	>action_frame65
	.byte	>action_frame66
	.byte	>action_frame67
	.byte	>action_frame68

;========
; frame1: (76)
; 	hlin color: $31/$13: 0,20 at 40,42
action_frame1:
	ldy	#40
	lda	#$31
	sta	hlin_color_smc+1
	jmp	action_left_laser


;=============
; frame2: (77)
; 	hlin color: $31/$13: 0,39 at 40,42
;	PINK!

action_frame2:
	ldy	#40
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_full_laser
	jmp	make_pink

;=============
; frame3: (78)
; 	hlin color: $31/$13: 20,39 at 40,42
; 	hlin color: $1A/$A1  0,19 at  40,42

action_frame3:
	ldy	#40
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_right_laser
	ldy	#40
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jmp	action_left_laser

;=============
; frame4: (79)
; 	hlin color: $1A/A1:  20,39 at 40,42
action_frame4:
	ldy	#40
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jmp	action_right_laser


;=============
; frame5: (80)
;	nothing for 5 frames
action_frame5:
action_frame6:
action_frame7:
action_frame8:
action_frame9:
	rts


;==============
; frame10: (81)
; 	hlin color: $31/$13: 0,20 at 22,24
action_frame10:
	ldy	#22
	lda	#$31
	sta	hlin_color_smc+1
	jmp	action_left_laser

;=============
; frame11: (82)
; 	hlin color: $31/13: 0,39 at 22,24
;	pink colors!
action_frame11:
	ldy	#22
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_full_laser
	jmp	make_pink


;=============
; frame12: (83)
; 	hlin color: $31/$13: 20,39 at 22,24
; 	hlin color: $1A/$A1:  4,19 at 22,24	; top
; 	hlin color: $31/$13:  0,20 at 30,32	; bottom
action_frame12:
	ldy	#22
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_right_laser

	ldy	#30
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_left_laser

	ldy	#22
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jsr	action_left_offset_laser



;=============
; frame13: (84)
; 	hlin color: $1A/$A1: 20,39 at 22,24	; top
; 	hlin color: $3B/$B3:  0,39 at 30,32	; bottom
action_frame13:
	ldy	#30
	lda	#$3B
	sta	hlin_color_smc+1
	jsr	action_full_laser

	ldy	#22
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jmp	action_right_laser


;==============
; frame14: (85)
; 	hlin color: $31/$13: 20,39 at 30,32
; 	hlin color: $1A/$A1:  4,19 at 30,32
action_frame14:
	ldy	#30
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_right_laser

	ldy	#30
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jmp	action_left_offset_laser


;==============
; frame15: (86)
; 	hlin color: $1A/A1:  20,39 at 30,32
;	friend, eye@2,28 (-12,-4)
action_frame15:
	ldy	#30
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jsr	action_right_laser

	ldx	#246
	ldy	#24
	jmp	action_draw_friend


;==============
; frame16: (87)
;	friend, eye@8,29 (-12,-4)
action_frame16:
	ldx	#252
	ldy	#24
	jmp	action_draw_friend


;==============
; frame17: (88)
; 	hlin color: $31,13:  0,20 at 28,30
;	friend, eye@10,30 (-12, -4)
action_frame17:
	ldy	#28
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_left_laser

	ldx	#254
	ldy	#26
	jmp	action_draw_friend

;==============
; frame18: (89)
; 	hlin color: $31,13:  0,39 at 28,30
;	friend, eye@14,30	(-12, -4)
;	pink colors!  eyes red???
action_frame18:

	ldy	#28
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_full_laser

	ldx	#2
	ldy	#26
	jsr	action_draw_friend

	jmp	make_pink

;==============
; frame19: (90)
; 	hlin color: $31/13: 20,39 at 28,30
; 	hlin color: $1A/A1:  4,19 at 28,30
;	friend, eye@20,28 (-12,-4)
action_frame19:
	ldy	#28
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_right_laser

	ldy	#28
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jsr	action_left_offset_laser

	ldx	#8
	ldy	#24
	jmp	action_draw_friend

;==============
; frame20: (91)
; 	hlin color: $31/13:  0,20 at 32,34
;	friend, eye@24,30	(-12,-4)
action_frame20:

	ldy	#32
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_left_laser

	ldx	#12
	ldy	#26
	jmp	action_draw_friend

;==============
; frame21: (92)
; 	hlin color: $3B/B3:  0,39 at 32,34
;	friend, eye@29,30	(-12,-4)
action_frame21:

	ldy	#32
	lda	#$3B
	sta	hlin_color_smc+1
	jsr	action_full_laser

	ldx	#17
	ldy	#26
	jmp	action_draw_friend

;==============
; frame22: (93)
; 	hlin color: $31/13: 20,39 at 32,34
; 	hlin color: $1A/A1:  4,19 at 32,34	; top
; 	hlin color: $31/13:  0,20 at 34,36	; bottom
;	friend, eye@33,29	(-12,-4)
action_frame22:
	ldy	#32
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_right_laser

	ldy	#34
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_left_laser

	ldy	#32
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jsr	action_left_offset_laser

	ldx	#21
	ldy	#24
	jmp	action_draw_friend

;==============
; frame23: (94)
;	friend, eye@38,28	(-12,-4)
; 	hlin color: $31,13:  0,39 at 34,36 ; OVER FRIEND
;	PINK!
action_frame23:

	ldx	#26
	ldy	#24
	jsr	action_draw_friend

	ldy	#34
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_full_laser

	jmp	make_pink

;==============
; frame24: (95)
;	friend, eye@43,28 (-12,-4)
; 	hlin color: $31/13: 20,39 at 34,36
; 	hlin color: $A1/1A:  4,19 at 34,36	;  OVER FRIEND
action_frame24:
	ldx	#31
	ldy	#24
	jsr	action_draw_friend

	ldy	#34
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_right_laser

	ldy	#34
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jmp	action_left_offset_laser


;==============
; frame25: (96)
;	friend, eye@48,28 (-12,-4)
; 	hlin color: $1A/A1: 20,39 at 34,36	; OVER FRIEND
action_frame25:
	ldx	#36
	ldy	#24
	jsr	action_draw_friend

	ldy	#34
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jmp	action_right_laser

;=======================
; frame26: wait 5 frames
action_frame26:
action_frame27:
action_frame28:
action_frame29:
action_frame30:
	rts

;==============
; frame31: (97)
; 	hlin color: $31:  0,20 at 24,26

action_frame31:
	ldy	#24
	lda	#$31
	sta	hlin_color_smc+1
	jmp	action_left_laser

;==============
; frame32: (98)
; 	hlin color: $31/13:  0,39 at 24,26
;	PINK!
action_frame32:
	ldy	#24
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_full_laser

	jmp	make_pink

;==============
; frame33: (99)
; 	hlin color: $31/13 20,39 at 24,26
; 	hlin color: $1A/A1:  4,19 at 24,26
action_frame33:
	ldy	#24
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_right_laser

	ldy	#24
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jmp	action_left_offset_laser

;===============
; frame34: (100)
; 	hlin color: $1A/A1: 20,39 at 24,26
action_frame34:
	ldy	#24
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jmp	action_right_laser

;=======================
; frame35: wait 5 frames
action_frame35:
action_frame36:
action_frame37:
action_frame38:
action_frame39:
	rts

;===============
; frame40: (101)
; 	hlin color: $31/13:  0,20 at 26,28
action_frame40:
	ldy	#26
	lda	#$31
	sta	hlin_color_smc+1
	jmp	action_left_laser


;===============
; frame41: (102)
; 	hlin color: $31/13:  0,39 at 26,28
action_frame41:
	ldy	#26
	lda	#$31
	sta	hlin_color_smc+1
	jmp	action_full_laser

;===============
; frame42: (103)
; 	hlin color: $31/13: 20,39 at 26,28
; 	hlin color: $1A/A1:  4,19 at 26,28
; 	hlin color: $31/13:  0,20 at 28,30	; bottom
action_frame42:
	ldy	#26
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_right_laser

	ldy	#28
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_left_laser

	ldy	#26
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jmp	action_left_offset_laser

;===============
; frame43: (104)
; 	hlin color: $1A/A1: 20,39 at 26,28
; 	hlin color: $31/13:  0,39 at 28,30

action_frame43:
	ldy	#28
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_full_laser

	ldy	#26
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jsr	action_right_laser

	jmp	make_pink

;==============
; frame44: (105)
; 	hlin color: $31/13: 20,39 at 28,30
; 	hlin color: $1A/A1:  4,19 at 28,30

action_frame44:
	ldy	#28
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_right_laser

	ldy	#28
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jmp	action_left_offset_laser

;==============
; frame45: (106)
; 	hlin color: $31/13:  0,20 at 32,34
action_frame45:
	ldy	#32
	lda	#$31
	sta	hlin_color_smc+1
	jmp	action_left_laser

;==============
; frame46: (107)
; 	hlin color: $3B/B3:  0,39 at 32,34

action_frame46:
	ldy	#32
	lda	#$B3
	sta	hlin_color_smc+1
	jmp	action_full_laser

;==============
; frame47: (108)
; 	hlin color: $31/13: 20,39 at 32,34
; 	hlin color: $1A/A1:  4,19 at 32,34
; 	hlin color: $31/13:  0,20 at 22,24	; bottom
action_frame47:
	ldy	#32
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_right_laser

	ldy	#22
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_left_laser

	ldy	#32
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jmp	action_left_offset_laser



;==============
; frame48: (109)
; 	hlin color: $1A/A1: 20,39 at 32,34
; 	hlin color: $31/13:  0,39 at 22,24
;	PINK!
action_frame48:
	ldy	#22
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_full_laser

	ldy	#32
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jsr	action_right_laser

	jmp	make_pink

;==============
; frame49: (110)
; 	hlin color: $31/13: 20,39 at 22,24
; 	hlin color: $1A/A1:  4,19 at 22,24
action_frame49:
	ldy	#22
	lda	#$31
	sta	hlin_color_smc+1
	jsr	action_right_laser

	ldy	#22
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jmp	action_left_offset_laser

;==============
; frame50: (111)
; 	hlin color: $1A/A1: 20,39 at 22,24
;	alien_eye@2,28	(-12, -4)
action_frame50:
	ldy	#22
	lda	#$10
	sta	hlin_color_smc+1
	lda	#$0f
	sta	hlin_mask_smc+1
	jsr	action_right_laser

	ldx	#246
	ldy	#24
	jmp	action_draw_alien1

;==============
; frame51: (112)
;	alien_eye@6,28 (-12,-4)
action_frame51:
	ldx	#250
	ldy	#24
	jmp	action_draw_alien1

;==============
; frame52: (113)
;	alien_eye@10,30	(-12, -4)
action_frame52:
	ldx	#254
	ldy	#24
	jmp	action_draw_alien1

;==============
; frame53: (114)
;	alien_eye@14,30 (-12, -4)
;	alien_eye2@2,28 (-12, -2)
action_frame53:
	ldx	#2
	ldy	#26
	jsr	action_draw_alien1

	ldx	#246
	ldy	#26
	jmp	action_draw_alien2

;==============
; frame54: (115)
;	alien_eye@20,28 (-12,-4)
;	alien_eye@6,28	(-12,-2)
action_frame54:
	ldx	#8
	ldy	#24
	jsr	action_draw_alien1

	ldx	#250
	ldy	#26
	jmp	action_draw_alien2

;==============
; frame55: (116)
;	alien_eye@24,30	(-12,-4)
;	alien_eye@10,30	(-12,-2)
action_frame55:
	ldx	#12
	ldy	#26
	jsr	action_draw_alien1

	ldx	#254
	ldy	#28
	jmp	action_draw_alien2


;==============
; frame56: (117)
;	alien_eye@28,30	(-12,-4)
;	alien_eye@15,30	(-12,-2)
action_frame56:
	ldx	#16
	ldy	#26
	jsr	action_draw_alien1

	ldx	#3
	ldy	#28
	jmp	action_draw_alien2

;==============
; frame57: (118)
;	alien_eye@32,30	(-12,-4)
;	alien_eye@20,30	(-12,-2)
action_frame57:
	ldx	#20
	ldy	#26
	jsr	action_draw_alien1

	ldx	#8
	ldy	#28
	jmp	action_draw_alien2

;==============
; frame58: (119)
;	alien_eye@38,28 (-12,-4)
;	alien_eye@25,30 (-12,-2)
;	alien_eye@2,28	(-12,-4)
action_frame58:
	ldx	#26
	ldy	#24
	jsr	action_draw_alien1

	ldx	#13
	ldy	#28
	jsr	action_draw_alien2

	ldx	#246
	ldy	#24
	jmp	action_draw_alien1


;==============
; frame59: (120)
;	alien_eye@43,28	(-12,-4)
;	alien_eye@29,30	(-12,-2)
;	alien_eye@6,28	(-12,-4)
action_frame59:
	ldx	#31
	ldy	#24
	jsr	action_draw_alien1

	ldx	#17
	ldy	#28
	jsr	action_draw_alien2

	ldx	#250
	ldy	#24
	jmp	action_draw_alien1

;==============
; frame60: (121)
;	alien_eye@48,28 (-12,-4)
;	alien_eye@33,30 (-12,-2)
;	alien_eye@10,30 (-12,-4)
action_frame60:
	ldx	#36
	ldy	#24
	jsr	action_draw_alien1

	ldx	#21
	ldy	#28
	jsr	action_draw_alien2

	ldx	#254
	ldy	#26
	jmp	action_draw_alien1

;==============
; frame61: (122)
;	alien_eye@38,28	(-12,-2)
;	alien_eye@15,30	(-12,-4)
action_frame61:
	ldx	#26
	ldy	#26
	jsr	action_draw_alien2

	ldx	#3
	ldy	#26
	jmp	action_draw_alien1

;==============
; frame62: (123)
;	alien_eye@43,28	(-12,-2)
;	alien_eye@20,28	(-12,-4)
action_frame62:
	ldx	#31
	ldy	#26
	jsr	action_draw_alien2

	ldx	#8
	ldy	#24
	jmp	action_draw_alien1

;==============
; frame63: (124)
;	alien_eye@48,28	(-12,-2)
;	alien_eye@24,28	(-12,-4)
action_frame63:
	ldx	#36
	ldy	#26
	jsr	action_draw_alien2

	ldx	#12
	ldy	#24
	jmp	action_draw_alien1

;==============
; frame64: (125)
;	alien_eye@28,30	(-12,-4)
action_frame64:
	ldx	#16
	ldy	#26
	jmp	action_draw_alien1


;==============
; frame65: (126)
;	alien_eye@32,30	(-12,-4)
action_frame65:
	ldx	#20
	ldy	#26
	jmp	action_draw_alien1

;==============
; frame66: (127)
;	alien_eye@38,28	(-12,-4)
action_frame66:
	ldx	#26
	ldy	#24
	jmp	action_draw_alien1

;==============
; frame67: (128)
;	alien_eye@43,28	(-12,-4)
action_frame67:
	ldx	#31
	ldy	#24
	jmp	action_draw_alien1

;==============
; frame68: (129)
;	alien_eye@48,28	(-12,-4)
action_frame68:
	ldx	#36
	ldy	#24
	jmp	action_draw_alien1

	;================================
	;================================
	; action left laser
	;================================
	;================================
	; Y is ypos
	; color in hlin_color_smc+1
	; draw from 0 to 20
action_left_laser:

	sty	TEMPY
	ldx	#20
	lda	#0
	jsr	hlin

	; rotate color and mask, draw Y+2 lower


	; rotate color

	lda	hlin_color_smc+1

	; swap nybbles
	asl
        adc	#$80
        rol
        asl
        adc	#$80
        rol

	sta	hlin_color_smc+1

	; rotate mask

	lda	hlin_mask_smc+1

	; swap nybbles
	asl
        adc	#$80
        rol
        asl
        adc	#$80
        rol

	sta	hlin_mask_smc+1


	ldy	TEMPY
	iny
	iny
	lda	#0
	ldx	#20

	jmp	hlin

	;================================
	;================================
	; action left offset laser
	;================================
	;================================
	; Y is ypos
	; color in hlin_color_smc+1
	; draw from 4 to 20
action_left_offset_laser:

	sty	TEMPY
	ldx	#16
	lda	#4
	jsr	hlin

	; rotate color and mask, draw Y+2 lower


	; rotate color

	lda	hlin_color_smc+1

	; swap nybbles
	asl
        adc	#$80
        rol
        asl
        adc	#$80
        rol

	sta	hlin_color_smc+1

	; rotate mask

	lda	hlin_mask_smc+1

	; swap nybbles
	asl
        adc	#$80
        rol
        asl
        adc	#$80
        rol

	sta	hlin_mask_smc+1


	ldy	TEMPY
	iny
	iny
	lda	#4
	ldx	#16

	jmp	hlin


	;================================
	;================================
	; action full laser
	;================================
	;================================
	; Y is ypos
	; color in hlin_color_smc+1
action_full_laser:

; 	hlin color: $31: 0,39 at 40

	sty	TEMPY
	ldx	#39
	lda	#0
	jsr	hlin

;	hlin color: $13: 0,39 at 42

	lda	hlin_color_smc+1

	; swap nybbles
	asl
        adc	#$80
        rol
        asl
        adc	#$80
        rol

	sta	hlin_color_smc+1

	ldy	TEMPY
	iny
	iny
	lda	#0
	ldx	#39

	jmp	hlin



	;================================
	;================================
	; action right laser
	;================================
	;================================
	; Y is ypos
	; color in hlin_color_smc+1
	; draws from 20-39 at Y
	; then rotates color/mask and draws at Y+2
action_right_laser:

	; draw initial
	sty	TEMPY
	ldx	#19
	lda	#20
	jsr	hlin

	; rotate color

	lda	hlin_color_smc+1

	; swap nybbles
	asl
        adc	#$80
        rol
        asl
        adc	#$80
        rol

	sta	hlin_color_smc+1

	; rotate mask

	lda	hlin_mask_smc+1

	; swap nybbles
	asl
        adc	#$80
        rol
        asl
        adc	#$80
        rol

	sta	hlin_mask_smc+1


	ldy	TEMPY
	iny
	iny
	lda	#20
	ldx	#19

	jmp	hlin



	;=========================
	;=========================
	; action_draw_friend
	;=========================
	;=========================
action_draw_friend:
	stx	XPOS
	sty	YPOS
	lda	#<action_friend_sprite
	sta	INL
	lda	#>action_friend_sprite
	sta	INH
	jmp	put_sprite_crop

	;=========================
	;=========================
	; action_draw_alien1
	;=========================
	;=========================
action_draw_alien1:
	stx	XPOS
	sty	YPOS
	lda	#<action_alien1_sprite
	sta	INL
	lda	#>action_alien1_sprite
	sta	INH
	jmp	put_sprite_crop

	;=========================
	;=========================
	; action_draw_alien2
	;=========================
	;=========================
action_draw_alien2:
	stx	XPOS
	sty	YPOS
	lda	#<action_alien2_sprite
	sta	INL
	lda	#>action_alien2_sprite
	sta	INH
	jmp	put_sprite_crop






action_friend_sprite:
	.byte 12,14	; eye@12,5
	.byte $AA,$AA,$AA,$AA,$AA,$6A,$6A,$6A,$6A,$6A,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$66,$66,$6F,$FF,$FF,$F6,$66,$6A
	.byte $AA,$AA,$AA,$AA,$66,$66,$66,$66,$66,$ff,$ff,$26
	.byte $AA,$AA,$AA,$0A,$06,$06,$66,$66,$66,$66,$6f,$66
	.byte $AA,$AA,$0A,$00,$00,$00,$00,$00,$66,$66,$66,$66
	.byte $AA,$0A,$00,$00,$60,$60,$00,$00,$00,$66,$66,$A6
	.byte $0A,$00,$60,$66,$FF,$FF,$F6,$00,$00,$66,$A6,$AA
	.byte $00,$00,$66,$66,$66,$FF,$6F,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$66,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$66,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$06,$00,$00,$00,$AA,$AA
	.byte $00,$00,$00,$66,$66,$66,$00,$00,$00,$00,$AA,$AA
	.byte $00,$00,$60,$66,$66,$66,$00,$00,$00,$00,$AA,$AA
	.byte $00,$00,$60,$66,$66,$66,$00,$00,$00,$00,$AA,$AA

action_alien1_sprite:
	.byte 12,13	; eye@11,4
	.byte $AA,$AA,$AA,$AA,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$AA
	.byte $AA,$AA,$AA,$0A,$00,$00,$00,$00,$00,$00,$00,$60
	.byte $AA,$AA,$AA,$00,$00,$00,$00,$00,$00,$00,$6f,$56
	.byte $AA,$AA,$0A,$00,$00,$00,$00,$00,$00,$66,$66,$66
	.byte $AA,$0A,$00,$00,$10,$10,$00,$00,$60,$00,$06,$66
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$66,$00,$06
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$66,$AA,$AA
	.byte $00,$00,$00,$00,$60,$60,$00,$00,$00,$00,$AA,$AA
	.byte $00,$00,$60,$60,$66,$66,$60,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$66,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$06,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$00,$00,$00,$00,$AA,$AA
	.byte $00,$00,$00,$66,$66,$66,$00,$00,$00,$00,$AA,$AA

; technically the middle alien has squatter face
; is slightly shorter, and has no red insignia

action_alien2_sprite:
	.byte 12,12	; eye@11,4
	.byte $AA,$AA,$AA,$AA,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	.byte $AA,$AA,$AA,$0A,$00,$00,$00,$00,$00,$00,$00,$60
	.byte $AA,$AA,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$56
	.byte $AA,$AA,$0A,$00,$00,$00,$00,$00,$00,$00,$66,$66
	.byte $AA,$0A,$00,$00,$00,$00,$00,$00,$00,$60,$06,$66
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$66,$00,$06
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$66,$AA,$AA
	.byte $00,$00,$00,$00,$60,$60,$00,$00,$00,$00,$AA,$AA
	.byte $00,$00,$60,$60,$66,$66,$60,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$66,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$06,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$00,$00,$00,$00,$AA,$AA





	;=====================
	; make pink (where applicable)
	;=====================

make_pink:

	ldy	#0						; 2
pink_outer:
	lda	gr_offsets,Y					; 4+
	sta	pi_smc1+1					; 4
	sta	pi_smc2+1					; 4

	lda	gr_offsets+1,Y					; 4+
	clc							; 2
	adc	DRAW_PAGE					; 3
	sta	pi_smc1+2					; 4
	sta	pi_smc2+2					; 4

	sty	TEMPY						; 3

	ldx	#39						; 2
pink_inner:

pi_smc1:
	ldy	$400,X						; 4
	lda	pink_lookup,Y					; 4+
pi_smc2:
	sta	$400,X						; 4
	dex							; 2
	bpl	pink_inner					; 3/2

	ldy	TEMPY						; 3

	iny							; 2
	iny							; 2
	cpy	#48						; 2
	bne	pink_outer					; 3/2

	rts							; 6


; pink colors
;    0->  0
;    1->  3
;    2->  3
;    3->  3
;    4->  1
;    5->  1
;    6->  F
;    7->  1
;    8->  1
;    9->  1
;    10-> 1
;    11-> F?
;    12-> F?
;    13-> F?
;    14-> F?
;    15-> F?


pink_lookup:
;       0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
.byte $00,$03,$03,$03,$01,$01,$0F,$01,$01,$01,$01,$0F,$0F,$0F,$0F,$0F
.byte $30,$33,$33,$33,$31,$31,$3F,$31,$31,$31,$31,$3F,$3F,$3F,$3F,$3F
.byte $30,$33,$33,$33,$31,$31,$3F,$31,$31,$31,$31,$3F,$3F,$3F,$3F,$3F
.byte $30,$33,$33,$33,$31,$31,$3F,$31,$31,$31,$31,$3F,$3F,$3F,$3F,$3F
.byte $10,$13,$13,$13,$11,$11,$1F,$11,$11,$11,$11,$1F,$1F,$1F,$1F,$1F
.byte $10,$13,$13,$13,$11,$11,$1F,$11,$11,$11,$11,$1F,$1F,$1F,$1F,$1F
.byte $F0,$F3,$F3,$F3,$F1,$F1,$FF,$F1,$F1,$F1,$F1,$FF,$FF,$FF,$FF,$FF
.byte $10,$13,$13,$13,$11,$11,$1F,$11,$11,$11,$11,$1F,$1F,$1F,$1F,$1F
.byte $10,$13,$13,$13,$11,$11,$1F,$11,$11,$11,$11,$1F,$1F,$1F,$1F,$1F
.byte $10,$13,$13,$13,$11,$11,$1F,$11,$11,$11,$11,$1F,$1F,$1F,$1F,$1F
.byte $10,$13,$13,$13,$11,$11,$1F,$11,$11,$11,$11,$1F,$1F,$1F,$1F,$1F
.byte $F0,$F3,$F3,$F3,$F1,$F1,$FF,$F1,$F1,$F1,$F1,$FF,$FF,$FF,$FF,$FF
.byte $F0,$F3,$F3,$F3,$F1,$F1,$FF,$F1,$F1,$F1,$F1,$FF,$FF,$FF,$FF,$FF
.byte $F0,$F3,$F3,$F3,$F1,$F1,$FF,$F1,$F1,$F1,$F1,$FF,$FF,$FF,$FF,$FF
.byte $F0,$F3,$F3,$F3,$F1,$F1,$FF,$F1,$F1,$F1,$F1,$FF,$FF,$FF,$FF,$FF
.byte $F0,$F3,$F3,$F3,$F1,$F1,$FF,$F1,$F1,$F1,$F1,$FF,$FF,$FF,$FF,$FF


