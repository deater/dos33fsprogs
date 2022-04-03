; TODO: auto-size this based on MAX_LEMMINGS

lemming_x:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_y:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_direction:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_out:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_frame:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_status:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_exploding:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_fall_distance:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_attribute:
	.byte 0,0,0,0,0,0,0,0,0,0



	;==========================
	; move them
	;==========================
move_lemmings:

	ldy	#0
	sty	CURRENT_LEMMING			; reset loop

move_lemming_loop:

	ldy	CURRENT_LEMMING			; get current in Y
	lda	lemming_out,Y

	beq	skip_move_lemming		; if not out, don't move

really_move_lemming:
	; bump frame
	tya
	tax
	inc	lemming_frame,X			; only can inc with X

	lda	lemming_status,Y		; use jump table based on status
	tax
	lda	move_lemming_jump_h,X
	pha
	lda	move_lemming_jump_l,X
	pha
	rts				; jump to it

skip_move_lemming:
done_move_lemming:

;	jsr	collision_check_ground

	inc     CURRENT_LEMMING		; loop until done
	lda     CURRENT_LEMMING
	cmp     #MAX_LEMMINGS
	bne	move_lemming_loop

really_done_checking_lemming:

	rts


move_lemming_jump_l:
	.byte   <(do_lemming_falling-1)
	.byte   <(do_lemming_walking-1)
	.byte   <(do_lemming_digging-1)
	.byte   <(do_lemming_exploding-1)
	.byte   <(do_lemming_particles-1)
	.byte   <(do_lemming_splatting-1)
	.byte   <(do_lemming_floating-1)
	.byte   <(do_lemming_climbing-1)
	.byte   <(do_lemming_bashing-1)
	.byte   <(do_lemming_stopping-1)
	.byte   <(do_lemming_mining-1)
	.byte   <(do_lemming_building-1)
	.byte   <(do_lemming_shrugging-1)
	.byte   <(do_lemming_pullup-1)

move_lemming_jump_h:
	.byte   >(do_lemming_falling-1)
	.byte   >(do_lemming_walking-1)
	.byte   >(do_lemming_digging-1)
	.byte   >(do_lemming_exploding-1)
	.byte   >(do_lemming_particles-1)
	.byte   >(do_lemming_splatting-1)
	.byte   >(do_lemming_floating-1)
	.byte   >(do_lemming_climbing-1)
	.byte   >(do_lemming_bashing-1)
	.byte   >(do_lemming_stopping-1)
	.byte   >(do_lemming_mining-1)
	.byte   >(do_lemming_building-1)
	.byte   >(do_lemming_shrugging-1)
	.byte   >(do_lemming_pullup-1)


	;=========================
	;=========================
	; falling
	;=========================
	;=========================
do_lemming_falling:

	tya
	tax
	inc	lemming_y,X		; fall speed
	inc	lemming_y,X

	inc	lemming_fall_distance,X	; how far

	lda	lemming_fall_distance,X
	cmp	#12
	bcc	not_fallen_enough		; blt

	lda	lemming_attribute,X
	bpl	not_fallen_enough		; see if high bit set

	; we can switch to floating
	lda	#LEMMING_FLOATING
	sta	lemming_status,X

	lda	#0
	sta	lemming_frame,X

not_fallen_enough:
	jsr	collision_check_ground

	jmp	done_move_lemming


	;=========================
	;=========================
	; floating
	;=========================
	;=========================
do_lemming_floating:

	tya
	tax
	inc	lemming_y,X		; fall speed
	lda	#0
	sta	lemming_fall_distance,X

	jsr	collision_check_ground

	jmp	done_move_lemming


	;=========================
	;=========================
	; walking
	;=========================
	;=========================
do_lemming_walking:

	; see if ground has risen up

	jsr	collision_check_hill

	; collision detect walls

	ldy	CURRENT_LEMMING
	lda	lemming_y,Y
	clc
	adc	#3		; waist-high?
	tax

	lda     hposn_high,X
	clc
	adc	#$20
        sta     GBASH
        lda     hposn_low,X
        sta     GBASL

	; increment
	; only do this every 4th frame?

	lda	lemming_frame,Y
	and	#$3
	beq	walking_increment

	bne	walking_done


walking_increment:
	; actually incrememt

	clc				; increment/decrement X
	lda	lemming_x,Y
	adc	lemming_direction,Y	; A is now incremented version
;	sta	lemming_x,Y
	tay				; Y is now incremented version

	lda	(GBASL),Y		; collision check

	cmp	#$ff			; don't collide with bridge
	beq	walking_no_wall

	and	#$7f
	beq	walking_no_wall

walking_yes_wall:
	pha


	;  we hit a wall, reverse course, undo the increment
	; Y is updated

	jsr	check_at_exit_xiny

	; check if climber, if so climb
	ldy	CURRENT_LEMMING

	pla

	cmp	#$10
	beq	not_climber		; HACK: special case so climbers
					; don't climb over stoppers

	lda	lemming_attribute,Y
	and	#LEMMING_CLIMBER
	beq	not_climber

	lda	#LEMMING_CLIMBING
	sta	lemming_status,Y
	jmp	walking_done

not_climber:

	; reverse direction

	lda	lemming_direction,Y
	eor	#$ff
	clc
	adc	#1
	sta	lemming_direction,Y
	jmp	walking_no_increment

walking_no_wall:
	; y is incremented version
	tya
	ldy	CURRENT_LEMMING
	sta	lemming_x,Y

walking_no_increment:

	jsr	collision_check_ground

walking_done:
	jmp	done_move_lemming


	;=====================
	; digging
	;=====================
do_lemming_digging:

;	ldy	#CURRENT_LEMMING

	lda	lemming_y,Y		; point to spot below us
	clc
	adc	#9
	tax

	lda     hposn_high,X
	clc
	adc	#$20			; point to background
        sta     GBASH
        lda     hposn_low,X
        sta     GBASL

	lda	lemming_x,Y
	tay

	lda	#$0
	sta	(GBASL),Y			; erase bg

	ldx	CURRENT_LEMMING			; dig down
	inc	lemming_y,X

blurgh:

	jsr	collision_check_ground


	jmp	done_move_lemming


	;=====================
	; mining
	;=====================
do_lemming_mining:
	ldy	CURRENT_LEMMING
	lda	lemming_frame,Y
	and	#$f
	bne	no_mining_this_frame		; only move dirt on frame 0


	ldx	#0				; erase background
	stx	HGR_COLOR

	; (X,A) to (X,A+Y) where X is xcoord/7

	jsr	hgr_box_page_toggle		; erase box page1
	ldy	CURRENT_LEMMING
	lda	lemming_x,Y
	tax
	lda	lemming_y,Y
	ldy	#10
	jsr	hgr_box

	jsr	hgr_box_page_toggle		; erase box page2
	ldy	CURRENT_LEMMING
	lda	lemming_x,Y
	tax
	lda	lemming_y,Y
	ldy	#10
	jsr	hgr_box

	ldx	CURRENT_LEMMING			; move 3 lines down
	inc	lemming_y,X
	inc	lemming_y,X
	inc	lemming_y,X

	lda	lemming_x,X			; move left or right
	clc
	adc	lemming_direction,X
	sta	lemming_x,X

	jsr	collision_check_ground

no_mining_this_frame:
done_mining:

	jmp	done_move_lemming





	;=====================
	; bashing
	;=====================
do_lemming_bashing:
	ldy	CURRENT_LEMMING
	lda	lemming_frame,Y
	and	#$f
	bne	no_bashing_this_frame

	ldx	#0
	stx	HGR_COLOR

	; (X,A) to (X,A+Y) where X is xcoord/7
	jsr	hgr_box_page_toggle
	ldy	CURRENT_LEMMING
	lda	lemming_x,Y
	clc
	adc	lemming_direction,Y
	tax
	lda	lemming_y,Y
	ldy	#9
	jsr	hgr_box

	jsr	hgr_box_page_toggle
	ldy	CURRENT_LEMMING
	lda	lemming_x,Y
	clc
	adc	lemming_direction,Y
	tax
	lda	lemming_y,Y
	ldy	#9
	jsr	hgr_box

	ldy	CURRENT_LEMMING			; FIXME: combine with earlier?
	lda	lemming_x,Y
	clc
	adc	lemming_direction,Y
	sta	lemming_x,Y

	; here?
	jsr	collision_check_side


no_bashing_this_frame:


;	jsr	collision_check_ground

	jmp	done_move_lemming




;
;           xxxxxxx
;        xxxxxxx
;    xxxxxxx
; xxxxxxx
;


	;=====================
	; building
	;=====================
do_lemming_building:
	ldy	CURRENT_LEMMING
	lda	lemming_frame,Y
	and	#$7
	beq	yes_building_this_frame
	jmp	no_building_this_frame		; only move dirt on frame 0

yes_building_this_frame:
;	ldx	#7				; draw white block
;	stx	HGR_COLOR

	lda	lemming_attribute,Y
	and	#$1
	bne	building_odd

building_even:

	ldy	CURRENT_LEMMING

	lda	lemming_y,Y
	clc
	adc	#9

	tax                    ; get row info for Y1 into GBASL/GBASH
	lda     hposn_high,X
	sta     GBASH

	lda	hposn_low,X
	sta	GBASL

	lda	lemming_x,Y
	clc
	adc	lemming_direction,Y
	tay

	lda	#$ff
	sta	(GBASL),Y

	lda	GBASH
	clc
	adc	#$20
	sta	GBASH
	lda	#$ff
	sta	(GBASL),Y

	jmp	update_building

building_odd:

	ldy	CURRENT_LEMMING

	lda	lemming_y,Y
	clc
	adc	#8

	tax                    ; get row info for Y1 into GBASL/GBASH
	lda     hposn_high,X
	sta     GBASH

	lda	hposn_low,X
	sta	GBASL

	lda	lemming_x,Y		; build one block beyond
	clc
	adc	lemming_direction,Y
	sta	build_smc4+1
	sta	build_smc3+1
	clc
	adc	lemming_direction,Y
	sta	build_smc1+1
	sta	build_smc2+1

	lda	#$ff			; put one block
build_smc4:
	ldy	#$dd
	sta	(GBASL),Y
build_smc1:
	ldy	#$dd			; also put one beyond
	sta	(GBASL),Y

	lda	GBASH
	clc
	adc	#$20
	sta	GBASH
	lda	#$ff
build_smc3:
	ldy	#$dd
	sta	(GBASL),Y
build_smc2:
	ldy	#$dd			; see if hit wall
	lda	(GBASL),Y
	and	#$7f
	beq	coast_clear
hit_something:

	ldy	CURRENT_LEMMING
	lda	#LEMMING_WALKING
	sta	lemming_status,Y

	jmp	keep_at_it
coast_clear:
	lda	#$ff
	sta	(GBASL),Y

keep_at_it:

	ldx	CURRENT_LEMMING			; move 2 lines up
	dec	lemming_y,X
	dec	lemming_y,X
;	dec	lemming_y,X

	lda	lemming_x,X			; move left or right
	clc
	adc	lemming_direction,X
	sta	lemming_x,X

update_building:
	ldx	CURRENT_LEMMING
	inc	lemming_attribute,X
	lda	lemming_attribute,X
	and	#$f
	cmp	#11
	bne	done_building
	cmp	#8
	bcc	no_build_click

	jsr	click_speaker

no_build_click:


	; hit the end!

	lda	#LEMMING_SHRUGGING
	sta	lemming_status,X

	lda	#0
	sta	lemming_frame,X

no_building_this_frame:
done_building:
	jmp	done_move_lemming

	;========================
	; stopping
	;========================
do_lemming_stopping:
	; we do want to see if something knocks the ground out from
	; under us

	; in practice that is tricky as the barrier we draw causes
	; the lemming to jump. hmmm

;	jsr	collision_check_ground
	jmp	done_move_lemming



	;========================
	; shrugging
	;========================
do_lemming_shrugging:
	lda	lemming_frame,Y
	cmp	#8
	bne	not_done_shrugging

	lda	#LEMMING_WALKING	; done shrug, start walking again
	sta	lemming_status,Y

not_done_shrugging:
	jmp	done_move_lemming


	;========================
	; climbing
	;========================
do_lemming_climbing:
	lda	lemming_frame,Y
	and	#3
	bne	not_done_climbing

	; climb
	tya
	tax
	dec	lemming_y,X
	dec	lemming_y,X

not_done_climbing:
	jsr	collision_check_ceiling
	bcs	done_climbing		; carry set we hit ceiling
					; don't check pullup then

	jsr	collision_check_above

done_climbing:
	jmp	done_move_lemming


	;========================
	; pulling up
	;========================
do_lemming_pullup:
	lda	lemming_frame,Y
	cmp	#8
	bne	not_done_pullup

	lda	lemming_x,Y
	clc
	adc	lemming_direction,Y
	sta	lemming_x,Y

	lda	#LEMMING_WALKING
	sta	lemming_status,Y

	jmp	done_pullup

not_done_pullup:
	; climb
	tya
	tax
	dec	lemming_y,X
done_pullup:
	jmp	done_move_lemming




	;=====================
	; do nothing
	;=====================

	; placeholders
do_lemming_exploding:		; nothing special
do_lemming_splatting:		; nothing special
do_lemming_particles:		; work done in draw

	jmp	done_move_lemming




	;==========================
	; remove lemming from game
	;==========================
	; Y points to CURRENT_LEMMING
	; if C set it means they exited

remove_lemming:

	bcc	didnt_exit

	sed
	lda	PERCENT_RESCUED_L
	clc
	adc	PERCENT_ADD
	sta	PERCENT_RESCUED_L
	bcc	no_percent_oflo

	inc	PERCENT_RESCUED_H
no_percent_oflo:
	cld

	jsr	update_percent_in

didnt_exit:

	sed			; decrement BCD value
	lda	LEMMINGS_OUT
	sec
	sbc	#1
	sta	LEMMINGS_OUT
	cld

	jsr	click_speaker

	lda	#0
	ldy	CURRENT_LEMMING
	sta	lemming_out,Y

	jsr	update_lemmings_out

	; if that was the last one, then level over

	lda	LEMMINGS_OUT
	bne	not_last_lemming

	lda	#LEVEL_WIN
	sta	LEVEL_OVER
not_last_lemming:

	rts


	;=============================
	; collision check side
	;=============================
	; for bashing
	; maybe can also be used when building?
collision_check_side:

	ldy	CURRENT_LEMMING
	lda	lemming_y,Y
	clc
	adc	#3
	tax

	lda     hposn_high,X
	clc
	adc	#$20			; check bg, not fg
        sta     GBASH
        lda     hposn_low,X
        sta     GBASL

	lda	lemming_x,Y
	clc
	adc	lemming_direction,Y

	tay
	lda	(GBASL),Y
	and	#$7f
	bne	gotta_keep_going

broke_on_through_to_the_other_side:

	ldy	CURRENT_LEMMING
	lda	#LEMMING_WALKING
	sta	lemming_status,Y

gotta_keep_going:

	rts


	;=============================
	; collision check above
	;=============================
	; looking above right/left
	; useful for climbers to see if at top
collision_check_above:
	ldy	CURRENT_LEMMING
	lda	lemming_y,Y
	tax

	lda     hposn_high,X
	clc
	adc	#$20			; check bg, not fg
        sta     GBASH
        lda     hposn_low,X
        sta     GBASL

	lda	lemming_x,Y
	clc
	adc	lemming_direction,Y

	tay
	lda	(GBASL),Y
	and	#$7f
	bne	gotta_keep_climbing

at_the_top:
	ldy	CURRENT_LEMMING
	lda	#LEMMING_PULLUP
	sta	lemming_status,Y

	lda	#0			; reset frame for pullup
	sta	lemming_frame,Y

gotta_keep_climbing:

	rts


	;=============================
	; collision check ceiling
	;=============================

collision_check_ceiling:
	ldy	CURRENT_LEMMING
	lda	lemming_y,Y
	tax

	lda     hposn_high,X
	clc
	adc	#$20			; check bg, not fg
        sta     GBASH
        lda     hposn_low,X
        sta     GBASL

	lda	lemming_x,Y
	tay
	lda	(GBASL),Y
	and	#$7f
	beq	done_check_ceiling	; if empty space above us, OK

hit_head:
	; o/~ I hit my head, I heard the phone ring... o/~

	; face other direction, fall

	ldy	CURRENT_LEMMING
	lda	lemming_direction,Y

	eor	#$ff
	clc
	adc	#1
	sta	lemming_direction,Y


	lda	#LEMMING_FALLING
	sta	lemming_status,Y
	sec
	rts

done_check_ceiling:
	clc
	rts




	;=============================
	; collision check ground
	;=============================

collision_check_ground:
	ldy	CURRENT_LEMMING
	lda	lemming_y,Y
	clc
	adc	#9			; FIXME: should be 10?
	tax

	lda     hposn_high,X
	clc
	adc	#$20			; check bg, not fg
        sta     GBASH
        lda     hposn_low,X
        sta     GBASL

	lda	lemming_x,Y
	tay
	lda	(GBASL),Y
	and	#$7f
	beq	ground_falling		; if empty space below us, fall

on_the_ground:
	; if we get here we're on the ground

	; if we were previously falling/floating we need to do something
	; otherwise do nothing


	ldy	CURRENT_LEMMING
	lda	lemming_status,Y

	cmp	#LEMMING_FALLING
	beq	hit_ground
	cmp	#LEMMING_FLOATING
	beq	hit_ground
	bne	done_check_ground	 ; could rts here?


hit_ground:
	; hit ground walking

	ldy	CURRENT_LEMMING

	lda	lemming_fall_distance,Y
	cmp	#32
	bcs	lemming_goes_splat

	lda	#0
	sta	lemming_fall_distance,Y

	lda	#LEMMING_WALKING	; else, walk
	jmp	update_status_check_ground

	; nothing beneath us, falling
ground_falling:
	ldy	CURRENT_LEMMING
	lda	lemming_status,Y	; if floating, don't go back to fall
	cmp	#LEMMING_FLOATING
	beq	done_check_ground

	lda	#LEMMING_FALLING
update_status_check_ground:
	ldy	CURRENT_LEMMING
	sta	lemming_status,Y
done_check_ground:
	rts

lemming_goes_splat:

	lda	#LEMMING_SPLATTING
	sta	lemming_status,Y

	lda	#0
	sta	lemming_frame,Y

;	clc
;	jsr	remove_lemming

	rts


	;=============================
	; collision check hill
	;=============================

collision_check_hill:
	lda	lemming_y,Y
	clc
	adc	#8
	tax

	lda     hposn_high,X
	clc
	adc	#$20			; check bg, not fg
        sta     GBASH
        lda     hposn_low,X
        sta     GBASL

	lda	lemming_x,Y
	tay
	lda	(GBASL),Y
	and	#$7f
	beq	on_ground		; if empty space below us, good
underground:
	ldx	CURRENT_LEMMING
	dec	lemming_y,X		; bump us up

on_ground:

	rts


	;=============================
	; check at exit
	;=============================
check_at_exit_xiny:
	tya
	ldy	CURRENT_LEMMING
	jmp	check_at_exit_y

check_at_exit:

	; see if at exit

	ldy	CURRENT_LEMMING

	; check X

	lda	lemming_x,Y
check_at_exit_y:

exit_x1_smc:
	cmp	#31
	bcc	not_done_level
exit_x2_smc:
	cmp	#35
	bcs	not_done_level

	; check Y

	lda	lemming_y,Y
exit_y1_smc:
	cmp	#116
	bcc	not_done_level
exit_y2_smc:
	cmp	#127
	bcs	not_done_level

	; done level
	sec
	jsr	remove_lemming


not_done_level:
	rts

