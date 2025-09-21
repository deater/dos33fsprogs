	;======================
	; deploy baby animation
	;======================
	; see below for details

deploy_baby_animation:

	lda	#0
	sta	BABY_COUNT
	sta	BABY_SUBCOUNT

	lda	#26			; 182/7=26
	sta	BABY_X

	lda	#117
	sta	BABY_Y

deploy_baby_loop:

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
	inc	BABY_SUBCOUNT
	lda	BABY_SUBCOUNT
	cmp	#9
	bne	baby_doing_fine

	dec	BABY_X
	dec	BABY_X

	ldy	BABY_COUNT
	cpy	#63
	bcc	baby_slow

	dec	BABY_X
	dec	BABY_X
baby_slow:

	lda	#0
	sta	BABY_SUBCOUNT

baby_doing_fine:


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

	jsr	wait_until_keypress


	;=========================
	; move to next frame

	inc	BABY_COUNT

	lda	BABY_COUNT
	cmp	#104
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


