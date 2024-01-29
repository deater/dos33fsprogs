
	;======================================
	; do_flames
	;======================================
	; copy background from $6000, left
	;	then do the following pattern
	;	s=short, 1=tall_1 2=tall_2, b=both short

	;	flames: left: ss1122
	;	flames: bb
	;	flames: right 22112211ss
	;	flames: left  ss11221122ss

	; FLAME_L = X of left flame
	; FLAME_R = X of right flame
	; FLAME_BG = type of background
	;	0 = blank white
	;	1 = blank_white + left_copy
	;	2 = blank_white + right_copy

do_flames:

	; this gets set to 1 if bg being copied

	lda	#2
	sta	FLAME_DELAY


	;======================================
	;	left flame short 2 frames

	jsr	draw_flame_bg

	ldx	FLAME_L
	jsr	draw_flame_small_1
	jsr	hgr_page_flip

	lda	FLAME_DELAY
	jsr	wait_ticks


	;=================================================
	;	left tall 1212 roughly 10 frames (1/2 s)

	lda	#2
	sta	ANIMATE_COUNT
left_flame_animate1:

	; 1

	jsr	draw_flame_bg

	ldx	FLAME_L
	jsr	draw_flame_tall_1
	jsr	hgr_page_flip

	lda	FLAME_DELAY
	jsr	wait_ticks

	; 2

	jsr	draw_flame_bg

	ldx	FLAME_L
	jsr	draw_flame_tall_2
	jsr	hgr_page_flip

	lda	FLAME_DELAY
	jsr	wait_ticks

	dec	ANIMATE_COUNT
	bne	left_flame_animate1

	;==============================
	;	both short 2 frames

	jsr	draw_flame_bg

	ldx	FLAME_L
	jsr	draw_flame_small_1

	ldx	FLAME_R
	jsr	draw_flame_small_1

	jsr	hgr_page_flip

	lda	FLAME_DELAY
	jsr	wait_ticks


	;===========================================
	;	right tall 1212 roughly 10 frames

	lda	#2
	sta	ANIMATE_COUNT

right_flame_animate1:

	; 2

	jsr	draw_flame_bg

	ldx	FLAME_R
	jsr	draw_flame_tall_2
	jsr	hgr_page_flip

	lda	FLAME_DELAY
	jsr	wait_ticks

	; 1

	jsr	draw_flame_bg

	ldx	FLAME_R
	jsr	draw_flame_tall_1
	jsr	hgr_page_flip

	lda	FLAME_DELAY
	jsr	wait_ticks

	dec	ANIMATE_COUNT
	bne	right_flame_animate1

	;=============================
	;	right short 2 frames

	jsr	draw_flame_bg

	ldx	FLAME_R
	jsr	draw_flame_small_2
	jsr	hgr_page_flip

	lda	FLAME_DELAY
	jsr	wait_ticks

	;=============================
	;	left short 2 frames

	jsr	draw_flame_bg

	ldx	FLAME_L
	jsr	draw_flame_small_1
	jsr	hgr_page_flip

	lda	FLAME_DELAY
	jsr	wait_ticks

	;================================================
	;	left tall 1212 roughly 10 frames (1/2 s)

	lda	#2
	sta	ANIMATE_COUNT
left_flame_animate2:

	; 1

	jsr	draw_flame_bg

	ldx	FLAME_L
	jsr	draw_flame_tall_1
	jsr	hgr_page_flip

	lda	FLAME_DELAY
	jsr	wait_ticks

	; 2

	jsr	draw_flame_bg

	ldx	FLAME_L
	jsr	draw_flame_tall_2
	jsr	hgr_page_flip

	lda	FLAME_DELAY
	jsr	wait_ticks

	dec	ANIMATE_COUNT
	bne	left_flame_animate2


	;=============================
	;	left short 2 frames

	jsr	draw_flame_bg

	ldx	FLAME_L
	jsr	draw_flame_small_1
	jsr	hgr_page_flip

	lda	FLAME_DELAY
	jmp	wait_ticks	; tail call


	;===============================
	; draw_flame_bg
	;===============================

draw_flame_bg:

	; clear no matter what

	ldy	#$7f
	jsr	hgr_clear_screen

	lda	FLAME_BG
	beq	flame_bg_clear

	cmp	#2
	bne	flame_bg_left

flame_bg_right:

	lda	#1
	sta	FLAME_DELAY
	jmp	hgr_copy_right		; tail call

flame_bg_left:

	lda	#1
	sta	FLAME_DELAY
	jmp	hgr_copy_left		; tail call

flame_bg_clear:

	rts




	;===============================
	; draw_flame_small
	;===============================
	; x location in X

draw_flame_small_1:
	lda	#<left_flame_small
	sta	INL
	lda	#>left_flame_small
	sta	INH
	lda	#<left_flame_small_mask
	sta	MASKL
	lda	#>left_flame_small_mask
	bne	draw_flame_small_common		; bra

draw_flame_small_2:
	lda	#<left_flame_small
	sta	INL
	lda	#>left_flame_small
	sta	INH
	lda	#<left_flame_small_mask
	sta	MASKL
	lda	#>left_flame_small_mask

draw_flame_small_common:
	sta	MASKH

	txa
	sta	SPRITE_X

	lda	#152
	sta	SPRITE_Y

	jmp	hgr_draw_sprite_big_mask	; tail call


	;===============================
	; draw_flame_tall
	;===============================
	; X location in X

draw_flame_tall_1:

	lda	#<left_flame_big
	sta	INL
	lda	#>left_flame_big
	sta	INH
	lda	#<left_flame_big_mask
	sta	MASKL
	lda	#>left_flame_big_mask
	sta	MASKH

	bne	draw_left_flame_common	; bra

draw_flame_tall_2:

	; draw right flame

	lda	#<right_flame_big
	sta	INL
	lda	#>right_flame_big
	sta	INH
	lda	#<right_flame_big_mask
	sta	MASKL
	lda	#>right_flame_big_mask
	sta	MASKH

draw_left_flame_common:

	txa
	sta	SPRITE_X

	lda	#54
	sta	SPRITE_Y

	jmp	hgr_draw_sprite_big_mask	; tail call


	;===================================
	; twin flames tall
draw_twin_flames_tall_1:

	ldx	#4
	jsr	draw_flame_tall_1
	ldx	#28
	jmp	draw_flame_tall_2	; tail call


draw_twin_flames_tall_2:

	ldx	#4
	jsr	draw_flame_tall_2
	ldx	#28
	jmp	draw_flame_tall_1	; tail call



	;===================================
	; twin flames low
draw_twin_flames_low:

	ldx	#4
	jsr	draw_flame_small_1
	ldx	#28
	jmp	draw_flame_small_2	; tail call

