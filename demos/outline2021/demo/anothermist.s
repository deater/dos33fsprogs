; another_mist -- a silly demo

; apologies to Cyan and Eric Chahi


another_mist:

	;===========================
	; Enable graphics
	;===========================

	bit	LORES
	bit	SET_GR
	bit	FULLGR
	bit	KEYRESET

	;===========================
	; Setup pages (is this necessary?)
	;===========================

	lda	#0
	sta	DRAW_PAGE
	lda	#4
	sta	DISP_PAGE

	lda	#<another_sequence
	sta	INTRO_LOOPL
	lda	#>another_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	rts


another_sequence:
	.byte	255					; load to bg
	.word	ootw_uboot_bg_lzsa			; this
        .byte	128+5    ;       .word   ootw_uboot_flash1_lzsa   ; (3)
        .byte	128+5    ;       .word   ootw_uboot_flash2_lzsa   ; (3)
        .byte	128+30   ;       .word   swim01_lzsa   ; (3)
        .byte	128+20   ;       .word   swim02_lzsa   ; (3)
        .byte	128+20  ;       .word   swim03_lzsa   ; (3)
        .byte	128+20   ;       .word   swim04_lzsa   ; (3)
        .byte	128+20   ;       .word   swim05_lzsa   ; (3)
        .byte	128+20   ;       .word   swim06_lzsa   ; (3)
	.byte	255                                     ; load to bg
	.word	another_pool_lzsa                       ; this
	.byte	128+40; 	.word ashore01
	.byte	128+40; 	.word ashore02
	.byte	128+40; 	.word ashore03
	.byte	128+40; 	.word ashore04
	.byte	128+40; 	.word ashore05
	.byte	128+40; 	.word ashore06
	.byte	128+40; 	.word ashore07
	.byte	128+40; 	.word ashore08
	.byte	128+40; 	.word ashore09
	.byte	128+40; 	.word ashore10
	.byte	128+40; 	.word ashore11
	.byte	128+40; 	.word ashore12
	.byte	128+40; 	.word ashore13
	.byte	128+40; 	.word ashore14
	.byte	128+40; 	.word ashore15
	.byte	128+40; 	.word ashore16
	.byte	128+40; 	.word ashore17
	.byte	128+40; 	.word ashore18
	.byte	128+40; 	.word ashore19
	.byte	128+40; 	.word ashore20
	.byte	128+40; 	.word ashore21
	.byte	128+40; 	.word ashore22
	.byte	128+40; 	.word ashore23
	.byte	128+40; 	.word ashore24

	.byte	255                                     ; load to bg
	.word	clock_e_lzsa	                        ; this
	.byte	128+90;		.word blank
	.byte	128+90; 	.word clock_n
	.byte	128+90; 	.word tree5_n
	.byte	128+80; 	.word tree4_n
	.byte	128+70; 	.word tree2_n
	.byte	128+70; 	.word tree1_n
	.byte	128+70; 	.word pool_n
	.byte	128+70; 	.word step_top_n
	.byte	128+70; 	.word pad_n
	.byte	128+70; 	.word spaceship_path_w
	.byte	128+70; 	.word spaceship_far_n
	.byte	128+70; 	.word spaceship_switch_n
	.byte	128+70; 	.word spaceship_door_n
	.byte	128+90; 	.word spaceship_door_open
	.byte	255                                     ; load to bg
	.word	spaceship_far_n_lzsa
	.byte	80
	.word	takeoff01_lzsa
	.byte	128+50; 	.word takeoff_02
	.byte	128+40; 	.word takeoff_03
	.byte	128+20; 	.word takeoff_04
	.byte	128+20; 	.word takeoff_05
	.byte	128+20; 	.word takeoff_06
	.byte	128+20; 	.word takeoff_07
	.byte	128+20; 	.word takeoff_08
	.byte	128+20; 	.word takeoff_00
	.byte	128+20; 	.word takeoff_10
	.byte	128+40; 	.word takeoff_11
	.byte	128+80; 	.word takeoff_12
	.byte	0
