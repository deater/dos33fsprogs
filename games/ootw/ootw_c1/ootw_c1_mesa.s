; Ootw mesa at far right

ootw_mesa:

	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	;===========================
	; Setup pages (is this necessary?)

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE


	;===========================
	; Setup right/left exit paramaters

	lda	BEAST_OUT		; if beast out, we can go full right
	beq	beast_not_out_yet

	lda	#(128+39)		; aliens trigger
	sta	RIGHT_LIMIT
	sta	RIGHT_WALK_LIMIT
	jmp	mesa_left

beast_not_out_yet:
	lda	#(128+20)		; beast trigger
	sta	RIGHT_LIMIT
	sta	RIGHT_WALK_LIMIT
mesa_left:
	lda	#(128-4)
	sta	LEFT_LIMIT
	sta	LEFT_WALK_LIMIT

	;=============================
	; Load background to $c00

	lda     #>(cavern3_rle)
        sta     GBASH
	lda     #<(cavern3_rle)
        sta     GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr


	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER
	sta     LEVELEND_PROGRESS

	lda	#2
	sta	WHICH_CAVE

	jsr	setup_beast

	;============================
	;============================
	;============================
	; Mesa main Loop
	;============================
	;============================
	;============================
mesa_loop:

	;===================================
	; Check if in end-of-level animation
	;===================================

	lda     LEVELEND_PROGRESS
	beq	no_levelend

	jsr	l1_end_level

	jmp     mesa_no_beast

no_levelend:

	;==================================
	; copy background to current page
	;==================================

	jsr	gr_copy_to_current

;beyond_mesa_normal:

	lda	LEVELEND_PROGRESS	; only draw if not in end animation
	bne	level1_ending

	;===============================
	; check keyboard
	;===============================

	jsr	handle_keypress

	;===============================
	; Move physicist
	;===============================

	jsr	move_physicist

	;===============================
	; check limits
	;===============================

	jsr	check_screen_limit

	;===============
	; draw physicist
	;===============

        jsr     draw_physicist

mesa_no_check_levelend:



	;================
	; handle beast

	lda	BEAST_OUT
	beq	mesa_no_beast

	;================
	; move beast
	;=================

	jsr	move_beast

	;================
	; draw beast
	;================

	jsr	draw_beast

mesa_no_beast:

level1_ending:

	;===============
	; page flip
	;===============

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	mesa_frame_no_oflo
	inc	FRAMEH

mesa_frame_no_oflo:


	;========================================
	;========================================
	; check if triggering beast
	;========================================
	;========================================
	lda	BEAST_OUT
	bne	mesa_done_check_beast

	lda	PHYSICIST_X
	cmp	#19
	bne	mesa_done_check_beast		; blt

trigger_beast:
	;=======================
	; trigger beast emerging
	lda	#1
	sta	BEAST_OUT

	lda	#26
	sta	BEAST_Y

	lda	#0
	sta	BEAST_DIRECTION
	sta	BEAST_GAIT
	sta	BEAST_STATE		; B_STANDING
	sta	GAME_OVER
	sta	PHYSICIST_STATE		; stop in tracks

	lda	#50
	sta	BEAST_COUNT

	lda	#30
	sta	BEAST_X

	lda	#(39+128)		; update right side of screen
	sta	RIGHT_LIMIT		; this is mostly for testing
	sta	RIGHT_WALK_LIMIT

	; show cutscene of arrival
	jsr	beast_arrival_cutscene

	jmp	not_done_mesa


mesa_done_check_beast:

	;========================================
	;========================================
	; check if at edge of screen or game over
	;========================================
	;========================================
l1_game_over_check:
	lda	GAME_OVER		; if not game over, skip ahead
	beq	not_done_mesa

	cmp	#$ff			; check if died, if so exit
	beq	done_mesa

	cmp	#$5			; check if defeated, if so exit
	beq	done_mesa

	;====================
	; check if leaving room
mesa_check_right:
	cmp	#$2
	bne	mesa_check_left

	;=====================
	; off screen to right
	; trigger ending

	lda	#MAX_PROGRESSION
	sta	LEVELEND_PROGRESS

	lda	#0
	sta	GAME_OVER

	lda	#30
	sta	PHYSICIST_X		; debugging

	jmp	not_done_mesa



mesa_check_left:
	cmp	#$1
	bne	not_done_mesa

	;============================
	; off screen to left
mesa_off_left:
	lda	#37
	sta	PHYSICIST_X
	lda	#1
	sta	WHICH_CAVE	; go left one screen

	jmp	ootw_cavern

not_done_mesa:

	; loop forever

	jmp	mesa_loop

done_mesa:
	rts


        ;=====================
        ; long(er) wait
        ; waits approximately 10ms * X

long_wait:
	lda	#64
	jsr	WAIT			; delay 1/2(26+27A+5A^2) us, 11,117
	dex
	bne	long_wait
	rts


MAX_PROGRESSION = 106

endl1_progression:
.word	black_rle,black_rle
.word	l1end51_rle,l1end50_rle,l1end49_rle,l1end48_rle,l1end47_rle
.word	l1end46_rle,l1end45_rle,l1end44_rle,l1end43_rle,l1end42_rle
.word	l1end41_rle,l1end40_rle,l1end39_rle,l1end38_rle,l1end37_rle
.word	l1end36_rle
.word	gunguy_rle,peace_rle
.word   l1end33_rle,l1end32_rle,l1end31_rle,l1end30_rle
.word   l1end29_rle,l1end28_rle,l1end27_rle,l1end26_rle,l1end25_rle
.word   l1end24_rle,l1end23_rle,l1end22_rle,l1end21_rle,l1end20_rle
.word   l1end19_rle,l1end18_rle,l1end17_rle,l1end16_rle,l1end15_rle
.word   l1end14_rle,l1end13_rle,l1end12_rle,l1end11_rle,l1end10_rle
.word   l1end09_rle,l1end08_rle,l1end07_rle,l1end06_rle,l1end05_rle
.word   l1end04_rle,l1end03_rle,l1end02_rle,l1end01_rle

; pause is *before* image indicated
endl_pauses:
; fading out
.byte	10,10		; black,black
.byte	10,10,10,10,220	; 51,50,49,48,47
; getting shot
.byte	3,3,3,3,3	; 46,45,44,43,42
.byte	3,3,3,3,3	; 41,40,39,38,37
.byte	250		; 36
.byte	230,80		; gun, peace	35,34
; raising hand
.byte	20,150,20,20	; 33,32,31,30
; getting up
.byte	20,20,150,10,10	; 29,28,27,26,25
.byte	10,10,10,10,10	; 24,23,22,21,20
; shooting of beast
.byte	3,3,3,3,3	; 19,18,17,16,15
.byte	3,3,3,3,3	; 14,13,12,11,10
.byte	3,3,3,3,3	; 09,08,07,06,05
.byte	3,3,3,3		; 04,03,02,01




	;==========================
	; Draw level-end animation
	;==========================

l1_end_level:


check_if_first:

	cmp	#MAX_PROGRESSION	; only load background on first frame
	bne	levelend_not_first

	lda	#<cavern3_rle
	sta	GBASL
	lda	#>cavern3_rle

	sta	GBASH
	lda	#$C			; load image off-screen $C00
	jsr	load_rle_gr

	lda	#0
	sta	BEAST_DEAD
	sta	BEAST_ZAPPING

	;=============================

levelend_not_first:


make_levelend_progress:
	lda	LEVELEND_PROGRESS	; if beast not zapped, can't go beyond19

	cmp	#(MAX_PROGRESSION-38)	; always go if not to afterzap
	bcs	levelend_dec		; bge

	lda	BEAST_DEAD
	beq	not_beginning_of_end

;	jmp	not_beginning_of_end

levelend_dec:
        dec     LEVELEND_PROGRESS
        dec     LEVELEND_PROGRESS

	bne	not_beginning_of_end

beginning_of_end:
	lda	#5
	sta	GAME_OVER
	jmp	l1_game_over_check

not_beginning_of_end:

	ldx	LEVELEND_PROGRESS
	lda	endl1_progression,X
	sta	GBASL
	lda	endl1_progression+1,X
	sta	GBASH
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay_40x40


	;=====================================
	; see if we should start zapping beast

	lda	BEAST_DEAD
	beq	beast_notdead		; skip all if dead
	jmp	ending_no_draw_beast
beast_notdead:
	lda	BEAST_ZAPPING
	bne	already_zapping			; already zapping

	; if it's greater than 18, zap away

	lda	BEAST_X
	cmp	#18
	bcc	beast_nozapped	; blt

	lda	#1
	sta	BEAST_ZAPPING

beast_nozapped:
already_zapping:

	ldx	BEAST_ZAPPING
	beq	beast_draw_regular

beast_draw_zapping:

	dex	; one past

	; adjust X
	sec
	lda	BEAST_X
	sbc	beast_zap_xadj,X
	sta	BEAST_X
	sta	XPOS

	; adjust y
	clc
	lda	BEAST_Y
	adc	beast_zap_yadj,X
	sta	BEAST_Y
	sta	YPOS

	; draw laser


	lda	#$0f
	sta 	hlin_mask_smc+1
	lda	#$10
	sta 	hlin_color_smc+1

	ldy	#28			; at 29


	; from left to center of beast if all but last frame

	cpx	#5
	beq	last_frame

	sec
	lda	#37
	sbc	BEAST_X
	tax
	lda	BEAST_X
	clc
	adc	#2
	jmp	not_last_frame

last_frame:

	lda	BEAST_X
	clc
	adc	#2
	tax
	lda	#0

not_last_frame:
	jsr	hlin

	ldx	BEAST_ZAPPING
	dex
	lda	beast_zap_progression_hi,X
	sta	INH
	lda	beast_zap_progression_lo,X
	sta	INL

	jsr	put_sprite_crop

	; adjust to next zapitude

	inc	BEAST_ZAPPING

	lda	BEAST_ZAPPING
	cmp	#7
	bne	beast_not_dead_yet

	lda	#1
	sta	BEAST_DEAD

	ldx	BEAST_X
	dex
	dex
	stx	BEAST_X

	lda	BEAST_Y
	clc
	adc	#8
	sta	BEAST_Y

beast_not_dead_yet:
	jmp	done_check_dead_beast

beast_draw_regular:

	; draw beast

	; move a bit faster than normal due to low frame rate
	; in cutscene

	; if make it to 20, stop

	lda	BEAST_X
	cmp	#19
	bcs	beast_full_stop		; bge

	; if closer than #10, slow a bit

;	lda	BEAST_X
;	cmp	#4
;	bcs	beast_half_speed	; bge
;	bcc	beast_inc_speed
;beast_half_speed:
;	lda	LEVELEND_PROGRESS
;	lsr
;	and	#$1
;	beq	beast_full_stop

beast_inc_speed:
	inc	BEAST_X
	inc	BEAST_GAIT

beast_full_stop:
	jsr	draw_beast

ending_no_draw_beast:

	; draw dead beast if frame >=19
	; but *not* frame with peace 34
	; we count down, so we want if less than (MAX_PROGRESSION-36)

	lda     LEVELEND_PROGRESS
	cmp	#(MAX_PROGRESSION-68)		; peace
	beq	done_check_dead_beast
	lda	BEAST_DEAD
	beq	done_check_dead_beast

	lda	BEAST_X
	sta	XPOS
	lda	BEAST_Y
	sta	YPOS

	lda	#<beast_dead_sprite
	sta	INL
	lda	#>beast_dead_sprite
	sta	INH

	jsr	put_sprite_crop


done_check_dead_beast:

;looploop:
;	lda	KEYPRESS
;	bpl	looploop
;	bit	KEYRESET

	;====================
	; pause
	lda	LEVELEND_PROGRESS
	lsr
	tax
	lda	endl_pauses,X
	tax
	jmp	long_wait


beast_zap_progression_hi:
	.byte >beast_blast_sprite0
	.byte >beast_blast_sprite1
	.byte >beast_blast_sprite2
	.byte >beast_blast_sprite3
	.byte >beast_blast_sprite4
	.byte >beast_blast_sprite5

beast_zap_progression_lo:
	.byte <beast_blast_sprite0
	.byte <beast_blast_sprite1
	.byte <beast_blast_sprite2
	.byte <beast_blast_sprite3
	.byte <beast_blast_sprite4
	.byte <beast_blast_sprite5


beast_zap_xadj:
	.byte	1,2,5,1,4,2

beast_zap_yadj:
	.byte	254,254,254,0,2,2


