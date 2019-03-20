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

	lda	#37			; beast trigger
	sta	RIGHT_LIMIT
	jmp	mesa_left

beast_not_out_yet:
	lda	#20			; beast trigger
	sta	RIGHT_LIMIT

mesa_left:
	lda	#0
	sta	LEFT_LIMIT

	;=============================
	; Load background to $c00

	lda     #>(cavern3_rle)
        sta     GBASH
	lda     #<(cavern3_rle)
        sta     GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy to screen

	jsr	gr_copy_to_current
	jsr	page_flip

	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER
	sta     LEVELEND_PROGRESS

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

	;=== load special background on first frame and frame 19

	cmp	#(MAX_PROGRESSION-36)		; on frame 19?
	bne	check_if_first

	lda	#<deadbeast_rle
	sta	GBASL
	lda	#>deadbeast_rle
	jmp	finish_first

check_if_first:

	cmp	#MAX_PROGRESSION	; only load background on first frame
	bne	levelend_not_first

	lda	#<cavern3_rle
	sta	GBASL
	lda	#>cavern3_rle
finish_first:
	sta	GBASH
	lda	#$C			; load image off-screen $C00
	jsr	load_rle_gr

levelend_not_first:
        dec     LEVELEND_PROGRESS
        dec     LEVELEND_PROGRESS

	ldx	LEVELEND_PROGRESS
	lda	endl1_progression,X
	sta	GBASL
	lda	endl1_progression+1,X
	sta	GBASH
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay_40x40


	;====================
	; pause
	lda	LEVELEND_PROGRESS
	lsr
	tax
	lda	endl_pauses,X
	tax
	jsr	long_wait

	jmp     beyond_mesa_normal

no_levelend:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current

beyond_mesa_normal:

	;===============================
	; check keyboard

	jsr	handle_keypress

	;===============================
	; check limits

	jsr	check_screen_limit


	;===============
	; draw physicist

	lda	LEVELEND_PROGRESS	; only draw if not in end animation
	bne	level1_ending

        jsr     draw_physicist
level1_ending:

	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	mesa_frame_no_oflo
	inc	FRAMEH

mesa_frame_no_oflo:


	; check if done this level

	lda	GAME_OVER
	beq	not_done_mesa

	cmp	#$ff			; check if dead
	beq	done_mesa

	;====================
	; check if leaving room
mesa_check_right:
	cmp	#$2
	bne	mesa_check_left

	;=====================
	; off screen to right

	lda	BEAST_OUT		; if beast out trigger end
	beq	trigger_beast		; otherwise trigger beast

	;=====================
	; trigger ending

	lda	#MAX_PROGRESSION
	sta	LEVELEND_PROGRESS

	lda	#0
	sta	GAME_OVER

	lda	#30
	sta	PHYSICIST_X		; debugging

	jmp	not_done_mesa

trigger_beast:
	;=======================
	; trigger beast emerging
	lda	#1
	sta	BEAST_OUT

	lda	#0
	sta	GAME_OVER

	lda	#37			; update right side of screen
	sta	RIGHT_LIMIT		; this is mostly for testing

	jsr	beast_cutscene

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
        ; waits approximately ?? ms

long_wait:
	lda	#64
	jsr	WAIT			; delay
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
.byte	230,80		; gun, peace
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
