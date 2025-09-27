	;======================
	; deploy baby animation
	;======================
	; see below for details

deploy_baby_animation:


	; load new background priority

	;============================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<baby_hut_priority_zx02
	sta	zx_src_l+1
	lda	#>baby_hut_priority_zx02
	sta	zx_src_h+1

	lda	#$4

;	lda	#>priority_temp         ; temporarily load to $6000

	jsr	zx02_full_decomp

;	jsr	priority_copy           ; copy to $400




	lda	#0
	sta	BABY_COUNT
	sta	BABY_SUBCOUNT

	lda	#26			; 182/7=26
	sta	BABY_X

	lda	#117
	sta	BABY_Y

deploy_baby_loop:

	; change background if needed

	jsr	change_background

	; change broom if needed

	jsr	change_broom


	jsr	update_screen

	; draw baby

	ldy	BABY_COUNT
	cpy	#6			; don't draw before frame 6
	bcc	skip_draw_baby


	lda	BABY_X
	sta	CURSOR_X
	lda	BABY_Y
	sta	CURSOR_Y

	lda	BABY_SUBCOUNT
	clc
	adc	#5
	tax

	jsr	hgr_sprite_custom_bg_mask


	;=========================
	; move baby

move_baby_x:

	inc	BABY_SUBCOUNT		; increase subcount

	ldy	BABY_COUNT		; if count > 63 moving fast
	cpy	#63
	bcs	move_baby_fast

move_baby_slow:

	lda	BABY_SUBCOUNT		; see if subcount hit 9
	cmp	#9
	bne	baby_no_wrap

	dec	BABY_X
	dec	BABY_X

	lda	#0			; if was 9. wrap
	sta	BABY_SUBCOUNT

	beq	baby_no_wrap		; bra


move_baby_fast:

	lda	BABY_SUBCOUNT		; see if subcount hit 5
	cmp	#5
	bne	baby_no_wrap

	dec	BABY_X
	dec	BABY_X

	lda	#0			; if was 5. wrap
	sta	BABY_SUBCOUNT

baby_no_wrap:


move_baby_y:

	ldy	BABY_COUNT
	cpy	#54
	bcc	baby_only_left
	cpy	#60
	bcs	baby_only_left

	inc	BABY_Y

baby_only_left:


skip_draw_baby:

	jsr	hgr_page_flip

;	jsr	wait_until_keypress


	;=========================
	; move to next frame

	inc	BABY_COUNT

	lda	BABY_COUNT
	cmp	#101
	bne	deploy_baby_loop

done_deploy_baby:

	rts



	; updated

	; frame	sprite   X	Y		wall	broom
	; 23    0  end of q-baby message (23/29/33/39/43/49)
	; 53    6  t	-0	0
	; 59    7  t	-1	0
	; 63    8  w	-2	0
	; 69    9  w	-3	0
	; 73   10  t	-3	0
	; 79   11  t	-4	0
	; 83   12  w	-5	0
	; 89   13  w       -6	0
	; 93   14  t	-6	0
	; 99   15  t	-7	0
	;103   16  w	-8	0
	;109   17  w	-9	0
	;113   18  t	-9	0
	;119   19  t	-10	0
	;123   20  w	-11	0
	;129   21  w	-12	0
	;133   22  t	-12	0	small
	;139   23  t	-13	0	bigger
	;143   24  w	-14	0	full
	;149   25  t	-14	0
	;153   26
	;159 / 163 / 169 / 173 /179 /183 /189 / 193 / 199
	;203 / 209 (behind broom)	(broom start far right)
	;213   38			broom slight right
	;219   39			broom slight left
	;223   40			broom slight right
	;229   41			broom slight left
	;233   42			broom rslight right
	;239   43			broom slight left
	;243   44			broom slight right
	;249   45			broom slight left
	;253   46  (baby behind door)	broom slight right
	;259   47			broom slight left
	;263   48			broom slight right
	;269   49			broom slight left
	;273   50			broom slirght right
	;279   51			broom fall left
	;289   52			broom fallen, door part open
	;293   53			door fall open
	;299   54	-1	+1
	;303   55	-1	+1
	;309/313/319/323/329
	;333   61	baby stop down	opening middle
	;339   62			opening small
	;343   63			opening gone
	;	note starts moving twice as fast
	;	this will be hard to do without separate sprite set
	;	cheat?
	;443   83	baby reach fence
	;483   91	baby edge of screen
	;503  100	baby gone
	;519  104	message


; really the bg shouldn't change until $1B = 27 (not 22)
; 	when door opens		       $40 = 64 (not 52)


	;===================
	; change background
	;===================

change_background:

	;133   22  t	-12	0	0 small
	;139   23  t	-13	0	1 bigger
	;143   24  w	-14	0	2 full
	;289   52			3 broom fallen, door part open
	;293   53			4 door fall open
	;333   61	baby stop down	5 opening middle
	;339   62			6 opening small
	;343   63			7 opening gone


	ldx	#0
	ldy	BABY_COUNT
	cpy	#22
	beq	do_change_background

	inx
	cpy	#23
	beq	do_change_background

	inx
	cpy	#24
	beq	do_change_background

	inx
	cpy	#52
	beq	do_change_background

	inx
	cpy	#53
	beq	do_change_background

	inx
	cpy	#61
	beq	do_change_background

	inx
	cpy	#62
	beq	do_change_background

	inx
	cpy	#63
	bne	background_same
do_change_background:

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40		; draw to $6000
	sta	DRAW_PAGE

	lda	background_x,X
	sta	CURSOR_X
	lda	background_y,X
	sta	CURSOR_Y

	lda	background_l,X
	sta	INL
	lda	background_h,X
	sta	INH

	jsr	hgr_draw_sprite

done_change_background:
	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

background_same:
	rts


	;===================
	; change broom
	;===================

change_broom:

	;203 / 209 (behind broom)	(broom start far right)
	;213   38			broom slight right
	;219   39			broom slight left
	;223   40			broom slight right
	;229   41			broom slight left
	;233   42			broom rslight right
	;239   43			broom slight left
	;243   44			broom slight right
	;249   45			broom slight left
	;253   46  (baby behind door)	broom slight right
	;259   47			broom slight left
	;263   48			broom slight right
	;269   49			broom slight left
	;273   50			broom slirght right
	;279   51			broom fall left
	;289   52			broom fallen, door part open
	;293   53			door fall open

	ldy	BABY_COUNT
	cpy	#38
	bcc	no_change_broom
	cpy	#53
	bcs	no_change_broom

do_change_broom:

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40		; draw to $6000
	sta	DRAW_PAGE

	lda	BABY_COUNT
	sec
	sbc	#38
	tax

	lda	broom_status,X
	tax

	lda	#18
	sta	CURSOR_X
	lda	#97
	sta	CURSOR_Y

	lda	broom_l,X
	sta	INL
	lda	broom_h,X
	sta	INH

	jsr	hgr_draw_sprite

done_change_broom:
	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

no_change_broom:
	rts


broom_status:
	.byte 0,1,0,1,0,1,0,1,0,1,0,1,0,2,3

broom_l:
	.byte	<broom_sprite0,<broom_sprite1,<broom_sprite2,<broom_sprite3

broom_h:
	.byte	>broom_sprite0,>broom_sprite1,>broom_sprite2,>broom_sprite3


background_x:
	.byte	18,17,14	; 126,119,98
	.byte	15,12,14	; 105,84,98
	.byte	17,18		; 119,126
background_y:
	.byte	90,82,69
	.byte	98,98,69
	.byte	81,90

background_l:
	.byte	<wall_sprite0,<wall_sprite1,<wall_sprite2
	.byte	<wall_sprite3,<wall_sprite4,<wall_sprite5
	.byte	<wall_sprite6,<wall_sprite7
background_h:
	.byte	>wall_sprite0,>wall_sprite1,>wall_sprite2
	.byte	>wall_sprite3,>wall_sprite4,>wall_sprite5
	.byte	>wall_sprite6,>wall_sprite7
