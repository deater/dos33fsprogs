; use BG palette when drawing transparent sprites

USE_BG_PALETTE = 1


	;=======================
	; move arrows
	;=======================
move_arrows:

	clc
	lda	FRAME
	adc	HIT_OFFSET

	pha
	; see if hit ground

	cmp	#24
	bne	skip_hit_ground

	jsr	arrow_miss_sound
skip_hit_ground:

	pla
	tay

	;===========================
	; check sprite to see if stop moving
	;   sprite 2 (hit) or 7 (miss) mean stop
	lda	shoot_sprite_which,Y
	cmp	#2
	beq	arrow_stop_flying
	cmp	#7
	bne	arrow_keep_flying

arrow_stop_flying:

	lda	#0
	sta	ARROW_FLYING

arrow_keep_flying:

	;=========================
	; check if hit target

	cpy	#8
	bne	dont_mess_with

check_if_hit_target:


	jsr	check_target		; carry set if hit

	bcs	dont_mess_with

	; point to miss animation instead
	lda	#15
	sta	HIT_OFFSET


dont_mess_with:



	;================================
	; actually move arrow
	;================================
	; only do this if arrow is in air

	lda	ARROW_FLYING
	beq	arrow_not_flying

arrow_is_flying:

	;=====================================
	; adjust X-coord based on horiz offset

	clc
	lda	ARROW_XL
	adc	HORIZ_OFFSETL

	sta	ARROW_XL

	lda	ARROW_X
	adc	HORIZ_OFFSET
	sta	ARROW_X

	;====================================
	; adjust Y-coord based on vert offset

	clc
	lda	ARROW_Y
	adc	VERT_OFFSET
	sta	ARROW_Y

arrow_not_flying:

	; final adjust for Y-coord even if not flying?

	; set Y-coord

	; arrow_y starts at 147
	; subtract 32 to do math so fits in 8-bit signed?
	; or maybe we need to do 16-bit math here?


	lda	#0
	sta	ARROW_YH
	lda	shoot_sprite_yadd,Y
	bpl	yadd_was_pos
	lda	#$ff
	sta	ARROW_YH
yadd_was_pos:

	clc
	lda	ARROW_Y
	adc	shoot_sprite_yadd,Y
	sta	ARROW_Y
	lda	ARROW_YH
	adc	#0
	sta	ARROW_YH

	;========================
	; keep on screen?

	lda	ARROW_X
	bpl	arrow_left_good

	lda	#0
	beq	arrow_x_fix_common	; bra

arrow_left_good:
	cmp	#39
	bcc	arrow_on_screen

	lda	#38
arrow_x_fix_common:
	sta	ARROW_X

arrow_on_screen:


	rts

	;=======================
	; draw arrow move
	;=======================
draw_arrow_move:

	clc
	lda	FRAME
	adc	HIT_OFFSET
	tay

	; set X-coord

	lda	ARROW_X
	sta	SPRITE_X

	bmi	draw_arrow_no_sprite	; off screen to left

	; set Y-coord

	lda	ARROW_Y
	sta	SPRITE_Y

	; get sprite

	lda	shoot_sprite_which,Y
	bmi	draw_arrow_no_sprite

	tax				; which sprite in X

	jsr	hgr_draw_sprite_mask

draw_arrow_done:
	clc
	rts

draw_arrow_no_sprite:
	sec
	rts


sprites_xsize:
	.byte	2,2,2,2,2
	.byte	2,2,2,2,2

sprites_ysize:
	.byte 30,12, 8, 5, 6
	.byte  9, 9, 9, 8, 8

sprites_data_h:
	.byte >shoot0e_sprite,>shoot1e_sprite,>shoot2e_sprite
	.byte >hit1e_sprite,>hit2e_sprite
	.byte >miss1e_sprite,>miss2e_sprite,>miss3e_sprite
	.byte >miss4e_sprite,>miss5e_sprite

sprites_data_l:
	.byte <shoot0e_sprite,<shoot1e_sprite,<shoot2e_sprite
	.byte <hit1e_sprite,<hit2e_sprite
	.byte <miss1e_sprite,<miss2e_sprite,<miss3e_sprite
	.byte <miss4e_sprite,<miss5e_sprite

sprites_mask_h:
	.byte >shoot0e_mask,>shoot1e_mask,>shoot2e_mask
	.byte >hit1e_mask,>hit2e_mask
	.byte >miss1e_mask,>miss2e_mask,>miss3e_mask
	.byte >miss4e_mask,>miss5e_mask

sprites_mask_l:
	.byte <shoot0e_mask,<shoot1e_mask,<shoot2e_mask
	.byte <hit1e_mask,<hit2e_mask
	.byte <miss1e_mask,<miss2e_mask,<miss3e_mask
	.byte <miss4e_mask,<miss5e_mask


	; this is all really complex
	; the flash game plays a movie to view the arrow
	; it has 43 frames

	; frame 0..6 (12)  are standard in all cases

	; if at that point hit the target
	;	7..19 (25)

	; if miss target
	;	20..37 (43)


shoot_sprite_which:
;	.byte	-0, -0, -0, -0, -0	; first 5 frames just regular arrow

	; shoot sprites

	.byte	0, 0, 0, 0, 0		; next 5 frames are launched
	.byte	1, 1			; next 2 smaller

	; hit sprites
hit_sprite_which:
	.byte	2,3,4,3, 2,3,4,3,2, 2,2,2,2,2,$FF

	; miss sprites
miss_sprite_which:
	.byte	5,6,7,8, 9,8,9,7,7, 7,7,7,7,7,$FF


;shoot_sprite_y:
;	.byte	83, 72, 54, 44, 26
;	.byte	19,  9

;hit_sprite_y:
;	.byte	2,1,0,3,  2,1,0,1,2, 2,2,2,2,2,$FF

;miss_sprite_y:
;	.byte	11,12,24,25, 25,25,25,24,24, 24,24,24,24,24,$FF


; starts at 83+64=147
; then diffs each one

shoot_sprite_yadd:
	.byte	0,<-11,<-18,<-10,<-18		; 83, 72, 54, 44, 26
	.byte	<-7,<-10			; 19,  9

hit_sprite_yadd:
	.byte	<-7,<-1,<-1,3			; 2,1,0,3
	.byte	<-1,<-1,<-1,1,1			; 2,1,0,1,2
	.byte	0,0,0,0,0			; 2,2,2,2,2
	.byte	$FF				; not needed but padding?

miss_sprite_yadd:
	.byte	2,1,12,1			; 11,12,24,25
	.byte	0,0,0,<-1,0			; 25,25,25,24,24
	.byte	0,0,0,0,0			; 24,24,24,24,24





	;=======================
	; backup arrow bg
	;=======================
backup_arrow_bg:

	lda	DRAW_PAGE
	beq	backup_arrow_bg_page1

backup_arrow_bg_page2:

	lda	#1
	sta	backup2_valid

	lda	ARROW_X
	sta	backup2_x

	lda	ARROW_Y
	sta	backup2_y

	ldy	#0
	ldx	#0
backup_arrow_loop2:
	stx	ARROW_TEMP

	txa
	clc
	adc	ARROW_Y
	tax
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	bal2_smc1+2
	sta	bal2_smc2+2

	clc
	lda	hposn_low,X
	adc	ARROW_X
	sta	bal2_smc1+1
	adc	#1		; can't overflow
	sta	bal2_smc2+1

bal2_smc1:
	lda	$2000
	sta	backup2_data,Y
	iny

bal2_smc2:
	lda	$2001
	sta	backup2_data,Y
	iny

	ldx	ARROW_TEMP
	inx
	cpx	#30
	bne	backup_arrow_loop2

	rts


backup_arrow_bg_page1:

	lda	#1
	sta	backup1_valid

	lda	ARROW_X
	sta	backup1_x

	lda	ARROW_Y
	sta	backup1_y

	ldy	#0
	ldx	#0
backup_arrow_loop:
	stx	ARROW_TEMP

	txa
	clc
	adc	ARROW_Y
	tax
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	bal_smc1+2
	sta	bal_smc2+2

	clc
	lda	hposn_low,X
	adc	ARROW_X
	sta	bal_smc1+1
	adc	#1		; can't overflow
	sta	bal_smc2+1

bal_smc1:
	lda	$2000
	sta	backup1_data,Y
	iny

bal_smc2:
	lda	$2001
	sta	backup1_data,Y
	iny

	ldx	ARROW_TEMP
	inx
	cpx	#30
	bne	backup_arrow_loop

	rts



	;=======================
	; restore arrow bg
	;=======================
restore_arrow_bg:

	ldy	#0			; set output pointer to 0
	ldx	#0			; set input row to 0

	lda	DRAW_PAGE
	beq	restore_arrow_bg_page1

restore_arrow_bg_page2:

	lda	backup2_valid
	beq	done_restore_arrow_bg

restore_arrow_loop2:
	stx	ARROW_TEMP

	txa
	clc
	adc	backup2_y
	tax
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	ral2_smc1+2
	sta	ral2_smc2+2

	clc
	lda	hposn_low,X
	adc	backup2_x
	sta	ral2_smc1+1
	clc
	adc	#1		; can't overflow
	sta	ral2_smc2+1

;	lda	#$00

	lda	backup2_data,Y
ral2_smc1:
	sta	$2000

	iny

;	lda	#$ff

	lda	backup2_data,Y
ral2_smc2:
	sta	$2001

	iny

	ldx	ARROW_TEMP
	inx
	cpx	#30
	bne	restore_arrow_loop2

	rts



restore_arrow_bg_page1:

	lda	backup1_valid		; exit early if no valid backup data
	beq	done_restore_arrow_bg

restore_arrow_loop:
	stx	ARROW_TEMP

	txa				; put row in A
	clc
	adc	backup1_y		; add y-offset

	tax				; X is the current row
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE		; adjust for correct page
	sta	ral_smc1+2		; self modify
	sta	ral_smc2+2

	clc
	lda	hposn_low,X		; get low address
	adc	backup1_x		; add in x position
	sta	ral_smc1+1

	clc				; not needed?
	adc	#1			; can't overflow
	sta	ral_smc2+1

;	lda	#$00

	lda	backup1_data,Y
ral_smc1:
	sta	$2000

	iny

;	lda	#$ff

	lda	backup1_data,Y
ral_smc2:
	sta	$2001

	iny

	ldx	ARROW_TEMP
	inx
	cpx	#30
	bne	restore_arrow_loop

done_restore_arrow_bg:
	rts




backup1_valid:
	.byte 0
backup1_x:
	.byte 0
backup1_y:
	.byte 0
backup1_data:
	.res 30*2

backup2_valid:
	.byte 0
backup2_x:
	.byte 0
backup2_y:
	.byte 0
backup2_data:
	.res 30*2



	;=========================
	; check target
	;=========================
	; carry clear = miss
	; carry set = hit
check_target:

	ldx	#0

check_target_loop:

	lda	ARROW_X

	cmp	target_x1,X
	bcc	check_target_again

	cmp	target_x2,X
	bcs	check_target_again

	lda	ARROW_Y
	cmp	target_y1,X
	bcc	check_target_again

	cmp	target_y2,X
	bcs	check_target_again

	bcc	check_target_hit

check_target_again:
	inx
	cpx	#14
	bne	check_target_loop

check_target_missed:
	clc
	rts

check_target_hit:
	sec
	rts

target_x1:
;	.byte 119,111,104, 97, 89, 84, 90, 97,104,104, 97,153,153,160
	.byte  17, 16, 15, 14, 13, 12, 13, 14, 15, 15, 14, 22, 22, 23
target_y1:
	.byte 15,  19, 23, 29, 37, 49, 85, 95,106,119,126,119,125,134
target_x2:
;	.byte 160,168,174,182,189,189,188,181,175,126,119,176,181,174
	.byte  23, 24, 25, 26, 27, 27, 27, 26, 25, 18, 17, 25, 26, 25
target_y2:
	.byte 19,  24, 30, 38, 49, 85, 95,106,119,126,139,125,135,139






	;=========================
	; check bullseye
	;=========================
	; carry clear = miss
	; carry set = hit
check_bullseye:

	; box is 133,60 146, 73  (19+20)
	; arrow is 2 blocks wide, so from 18..20?

	lda	ARROW_X
	cmp	#18
	bcc	check_bullseye_missed
	cmp	#21
	bcs	check_bullseye_missed

	lda	ARROW_Y
	cmp	#59
	bcc	check_bullseye_missed
	cmp	#73
	bcs	check_bullseye_missed

check_bullseye_hit:

	; play sound effect

	jsr	bullseye_sound

	; draw circle, both pages

	lda	DRAW_PAGE
	pha

	lda	#0
	sta	DRAW_PAGE

	jsr	draw_circle

	lda	#$20
	sta	DRAW_PAGE

	jsr	draw_circle

	pla
	sta	DRAW_PAGE

	; increment hits
	inc	ARROW_SCORE

	sec
	rts

check_bullseye_missed:
	jsr	arrow_miss_sound

	clc
	rts


	;========================
	; draw circle
	;========================

draw_circle:

	; set X-coord

	lda	ARROW_SCORE
	asl
	sta	CURSOR_X

	; set Y-coord

	lda	#77
	sta	CURSOR_Y

	; get sprite

	lda	#<circle_sprite
	sta	INL
	lda	#>circle_sprite
	sta	INH

	jsr	hgr_draw_sprite

	rts
