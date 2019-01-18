; Cavern scene (with the slugs)

ootw_cavern:
	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR


	;===========================
	; Clear both bottoms

;	lda	#$4
;	sta	DRAW_PAGE
;	jsr     clear_bottom

	lda	#$0
	sta	DRAW_PAGE
;	jsr     clear_bottom

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE


	;=============================
	; Load background to $c00

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL			; load image off-screen $c00

	lda     #>(cavern_rle)
        sta     GBASH
	lda     #<(cavern_rle)
        sta     GBASL
	jsr	load_rle_gr

	;=============================
	; Load quake background to $1000

	lda	#$10
	sta	BASH
	lda	#$00
	sta	BASL			; load image off-screen $c00

	lda     #>(quake_rle)
        sta     GBASH
	lda     #<(quake_rle)
        sta     GBASL
	jsr	load_rle_gr


	;=================================
	; copy to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current


	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER

	;============================
	; Cavern Loop (not a palindrome)
	;============================
cavern_loop:

	;==========================
	; check for earthquake

earthquake_handler:
	lda     FRAMEH
	and	#3
	bne	earth_mover
	lda	FRAMEL
	cmp	#$ff
	bne	earth_mover
earthquake_init:
	lda	#200
	sta	EQUAKE_PROGRESS

	lda	#0
	sta	BOULDER_Y
	jsr	random16
	lda	SEEDL
	and	#$1f
	clc
	adc	#4
	sta	BOULDER_X


earth_mover:
	lda	EQUAKE_PROGRESS
	beq	earth_still

	and	#$8
	bne	earth_calm

	lda	#2
	bne	earth_decrement

earth_calm:
	lda	#0
earth_decrement:
	sta	EARTH_OFFSET
	dec	EQUAKE_PROGRESS
	jmp	earth_done


earth_still:
	lda	#0
	sta	EARTH_OFFSET

earth_done:

	;================================
	; copy background to current page

	lda	EARTH_OFFSET
	bne	shake_shake
no_shake:
	jsr	gr_copy_to_current
	jmp	done_shake
shake_shake:
	jsr	gr_copy_to_current_40
done_shake:


	;===============
	; handle slug death

	lda	SLUGDEATH
	beq	still_alive

collapsing:
	lda     SLUGDEATH_PROGRESS
        cmp     #18
        bmi     still_collapsing

really_dead:
	lda	#$ff
	sta	GAME_OVER
	jmp	just_slugs


still_collapsing:
        tax

        lda     collapse_progression,X
        sta     INL
        lda     collapse_progression+1,X
        sta     INH

        lda     PHYSICIST_X
        sta     XPOS
        lda     PHYSICIST_Y
	sec
	sbc	EARTH_OFFSET
        sta     YPOS

	jsr	put_sprite

        lda     FRAMEL
        and     #$1f
        bne     no_collapse_progress

        inc     SLUGDEATH_PROGRESS
        inc     SLUGDEATH_PROGRESS
no_collapse_progress:


	jmp	just_slugs

still_alive:

	;===============
	; check keyboard

	jsr	handle_keypress_cavern

	;===============
	; draw physicist

	jsr	draw_physicist

just_slugs:

	;===============
	; draw slugs

	jsr	draw_slugs

	;======================
	; draw falling boulders

	lda	BOULDER_Y
	cmp	#38
	bpl	no_boulder

	lda	#<boulder
	sta	INL
	lda	#>boulder
	sta	INH

	lda	BOULDER_X
	sta	XPOS
	lda	BOULDER_Y
	sta	YPOS
        jsr	put_sprite

	lda	FRAMEL
	and	#$3
	bne	no_boulder
	inc	BOULDER_Y
	inc	BOULDER_Y

no_boulder:
	;=======================
	; page flip

	jsr	page_flip

	;========================
	; inc frame count

	inc	FRAMEL
	bne	frame_no_oflo_c
	inc	FRAMEH

frame_no_oflo_c:

	; pause?

	; see if game over
	lda	GAME_OVER
	cmp	#$ff
	beq	done_cavern

	; see if left level
	cmp	#1
	bne	still_in_cavern

	lda	#37
	sta	PHYSICIST_X
	jmp	ootw_pool

still_in_cavern:
	; loop forever

	jmp	cavern_loop

done_cavern:
	rts


;======================================
; handle keypress (cavern)
;======================================

handle_keypress_cavern:

	lda	KEYPRESS						; 4
	bmi	keypress_cavern						; 3

	rts

keypress_cavern:
									; -1

	and	#$7f		; clear high bit

check_quit_c:
	cmp	#'Q'
	beq	quit_c
	cmp	#27
	bne	check_left_c
quit_c:
	lda	#$ff
	sta	GAME_OVER
	rts

check_left_c:
	cmp	#'A'
	beq	left_c
	cmp	#$8		; left arrow
	bne	check_right_c
left_c:
	lda	#0
	sta	CROUCHING

	lda	DIRECTION
	bne	face_left_c

	dec	PHYSICIST_X
	bpl	just_fine_left_c
too_far_left_c:

	lda	#1
	sta	GAME_OVER
	rts

just_fine_left_c:

	inc	GAIT
	inc	GAIT

	jmp	done_keypress_c

face_left_c:
	lda	#0
	sta	DIRECTION
	sta	GAIT
	jmp	done_keypress_c

check_right_c:
	cmp	#'D'
	beq	right_c
	cmp	#$15
	bne	check_down_c
right_c:
	lda	#0
	sta	CROUCHING

	lda	DIRECTION
	beq	face_right_c

	inc	PHYSICIST_X
	lda	PHYSICIST_X
	cmp	#37
	bne	just_fine_right_c
too_far_right_c:
	dec	PHYSICIST_X
just_fine_right_c:


	inc	GAIT
	inc	GAIT
	jmp	done_keypress_c

face_right_c:
	lda	#0
	sta	GAIT
	lda	#1
	sta	DIRECTION
	jmp	done_keypress_c

check_down_c:
	cmp	#'S'
	beq	down_c
	cmp	#$0A
	bne	check_space_c
down_c:
	lda	#48
	sta	CROUCHING
	lda	#0
	sta	GAIT

	jmp	done_keypress_c

check_space_c:
	cmp     #' '
	beq	space_c
	cmp	#$15
	bne	unknown_c
space_c:
	lda	#15
	sta	KICKING
	lda	#0
	sta	GAIT
unknown_c:
done_keypress_c:
	bit	KEYRESET	; clear the keyboard strobe		; 4


no_keypress_c:
	rts								; 6


;==================================
; draw slugs
;==================================

	; outstate 0=dead 1=normal 2=dieing 3=falling

slugg0_out:	.byte	1
slugg0_attack:	.byte	0
slugg0_x:	.byte	30
slugg0_dir:	.byte	$ff
slugg0_gait:	.byte	0

slugg1_out:	.byte	1
slugg1_x:	.byte	30
slugg1_dir:	.byte	$ff
slugg1_gait:	.byte	0

slugg2_out:	.byte	1
slugg2_x:	.byte	30
slugg2_dir:	.byte	$ff
slugg2_gait:	.byte	0


draw_slugs:

	lda	slugg0_out
	bne	check_attack		; don't draw if not there
	jmp	slug_done

check_attack:
	;==================
	; see if attack

	lda	PHYSICIST_X
	sec
	sbc	slugg0_x		; -2 to +2
	clc
	adc	#2
	and	#$fc
	bne	no_attack
attack:

	;=================
	; start an attack

	lda	#1
	sta	slugg0_attack

	lda	SLUGDEATH		; don't re-attack if already dead
	bne	no_attack

	lda	#$1
	sta	SLUGDEATH
	lda	#0
	sta	SLUGDEATH_PROGRESS

	jsr	slug_cutscene


no_attack:
	inc	slugg0_gait		; increment slug gait counter

	lda	slugg0_gait		; only move every 64 frames
	and	#$3f
	cmp	#$00
	bne	slug_no_move

slug_move:
	lda	slugg0_x
	clc
	adc	slugg0_dir
	sta	slugg0_x

	cmp	#37
	beq	remove_slug

	cmp	#0
	beq	remove_slug

slug_no_move:


	;===============================
	;===============================
	; DRAW SLUG
	;===============================
	;===============================

	; if exploding

	;==============
	; if attacking
	;==============
	lda	slugg0_attack
	beq	slug_normal
slug_attacking:

	lda	slugg0_gait
	and	#$70
	lsr
	lsr
	lsr
	tax

	lda	slug_attack_progression,X
	sta	INL
	lda	slug_attack_progression+1,X
	sta	INH
	jmp	slug_selected

	;==============
	; if normal
	;==============
slug_normal:
	lda	slugg0_gait
	and	#$20
	beq	slug_squinched

slug_flat:
	lda	#<slug1
	sta	INL
	lda	#>slug1
	sta	INH
	bne	slug_selected

slug_squinched:
	lda	#<slug2
	sta	INL
	lda	#>slug2
	sta	INH

	;================
	; end slug normal
	;================

slug_selected:


	lda	slugg0_x
	sta	XPOS

	lda	#30
	sec
	sbc	EARTH_OFFSET
	sta	YPOS

	lda	DIRECTION
	bmi	slug_right

slug_left:
        jsr	put_sprite
	jmp	slug_done

slug_right:
	jsr	put_sprite_flipped

slug_done:
	rts

remove_slug:
	lda	#0
	sta	slugg0_out
	rts




	;=========================================================
	; gr_copy_to_current, 40x48 version
	;=========================================================
	; copy 0x1000 to DRAW_PAGE

gr_copy_to_current_40:

	lda	DRAW_PAGE					; 3
	clc							; 2
	adc	#$4						; 2
	sta	gr_copy_line_40+5				; 4
	sta	gr_copy_line_40+11				; 4
	adc	#$1						; 2
	sta	gr_copy_line_40+17				; 4
	sta	gr_copy_line_40+23				; 4
	adc	#$1						; 2
	sta	gr_copy_line_40+29				; 4
	sta	gr_copy_line_40+35				; 4
	adc	#$1						; 2
	sta	gr_copy_line_40+41				; 4
	sta	gr_copy_line_40+47				; 4
							;===========
							;	45

	ldy	#119		; for early ones, copy 120 bytes	; 2

gr_copy_line_40:
	lda	$1000,Y		; load a byte (self modified)		; 4
	sta	$400,Y		; store a byte (self modified)		; 5

	lda	$1080,Y		; load a byte (self modified)		; 4
	sta	$480,Y		; store a byte (self modified)		; 5

	lda	$1100,Y		; load a byte (self modified)		; 4
	sta	$500,Y		; store a byte (self modified)		; 5

	lda	$1180,Y		; load a byte (self modified)		; 4
	sta	$580,Y		; store a byte (self modified)		; 5

	lda	$1200,Y		; load a byte (self modified)		; 4
	sta	$600,Y		; store a byte (self modified)		; 5

	lda	$1280,Y		; load a byte (self modified)		; 4
	sta	$680,Y		; store a byte (self modified)		; 5

	lda	$1300,Y		; load a byte (self modified)		; 4
	sta	$700,Y		; store a byte (self modified)		; 5

	lda	$1380,Y		; load a byte (self modified)		; 4
	sta	$780,Y		; store a byte (self modified)		; 5

	dey			; decrement pointer			; 2
	bpl	gr_copy_line_40	;					; 2nt/3

	rts								; 6

