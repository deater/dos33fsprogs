	;============================
	; draw gary reacting to being hurt

	;======================================
	; first move peasant to 105,119 (15,119)
	;
	; display message
	;
	;

	;
	;  8 frames -- nothing, flies still move
	;  6 frames -- rear1 @ 49,117
	;  6 frames -- rear2 @ 49,115
	;  6 frames -- rear3 
	;		peasant0 off feet (3)
	;		peasant1 (3)
	;  6 frames -- rear2
	;		peasant2 (upside down) 3
	;		peasant3 (3)
	;  6 frames -- rear1
	;		peasant4 (3)
	;		peasant5 (3) down on ground
	; 60 frames -- rear0 
	;		peasant6 bounce?



draw_gary_revenge:

	lda	#0
	sta	GARY_COUNT

revenge_gary_loop:
	;==========================
	; update suppression loops

	; suppress gary

	lda	SUPPRESS_DRAWING

	ldy	GARY_COUNT
	ldx	revenge_gary_which,Y

	; NOTE: loop ending happens here
	;	if we do it later we suppress at end which we don't want

	bmi	done_revenge_gary_loop

not_done_revenge:

	bne	suppress_gary_revenge
no_suppress_gary_revenge:
	and	#<~(SUPPRESS_GARY)
	jmp	common_suppress_gary
suppress_gary_revenge:
	ora	#SUPPRESS_GARY
common_suppress_gary:
;	sta	SUPPRESS_DRAWING

	; suppress peasant

;	lda	SUPPRESS_DRAWING
	ldx	revenge_peasant_which,Y
	bmi	no_suppress_peasant_revenge	; if minus, no suppress

suppress_peasant_revenge:
	ora	#SUPPRESS_PEASANT
	bne	suppress_peasant_common		; bra
no_suppress_peasant_revenge:
	and	#<(~SUPPRESS_PEASANT)
suppress_peasant_common:
	sta	SUPPRESS_DRAWING


	; draw screen

	jsr	update_screen

	;======================
	; draw gary

	ldy	GARY_COUNT
	ldx	revenge_gary_which,Y
;	bpl	not_done_revenge
;	jmp	done_revenge_gary_loop
;not_done_revenge:
	beq	draw_peasant_revenge	; skip if state 0

do_draw_gary_revenge:
	; note, re-use gary sprites from scare-gary

	lda	scare_gary_x,X
	sta	CURSOR_X
	lda	scare_gary_y,X
	sta	CURSOR_Y

	lda	scare_gary_sprite_l,X
	sta	INL
	lda	scare_gary_sprite_h,X
	sta	INH

	jsr	hgr_draw_sprite

draw_peasant_revenge:

	jsr	handle_draw_peasant_revenge


	;========================
	; flip pages

	jsr	hgr_page_flip

	inc	GARY_COUNT
	jmp	revenge_gary_loop

done_revenge_gary_loop:

	; no longer suppress
	lda	#CUSTOM_PEASANT
	sta	SUPPRESS_DRAWING

	rts



	;======================
	; draw peasant
handle_draw_peasant_revenge:
	ldy	GARY_COUNT
	ldx	revenge_peasant_which,Y
	bmi	skip_draw_peasant_revenge

	lda	revenge_peasant_x,X
	sta	CURSOR_X
	lda	revenge_peasant_y,X
	sta	CURSOR_Y

	lda	revenge_peasant_sprite_l,X
	sta	INL
	lda	revenge_peasant_sprite_h,X
	sta	INH

	jsr	hgr_draw_sprite

skip_draw_peasant_revenge:

	rts

revenge_gary_which:
	.byte	0,0,0,0
	.byte	1,1,1
	.byte	2,2,2
	.byte	3,3,3
	.byte	2,2,2
	.byte	1,1,1
	.byte	0,0,0,0,0, 0,0,0,0,0
	.byte	0,0,0,0,0, 0,0,0,0,0
	.byte	$FF


revenge_peasant_which:
	.byte	$80,$80,$80,$80
	.byte	$80,$80,$80
	.byte	$80,$80,$80
	.byte	0,0,1
	.byte	1,2,2
	.byte	3,3,4
	.byte	4,5,5,5,5, 5,5,5,5,5
	.byte	5,5,5,5,5, 5,5,5,5,5
	.byte	5	; last one displayed when done

	; peasant starts at 15,119	28->119 + 91
	;	peasant0:	18,117
	;	peasant1:	20,117
	;	peasant2:	22,117
	;	peasant3:	24,117
	;	peasant4:	26,123
	;	peasant5:	26,140

revenge_peasant_x:
	.byte	18,20,22
	.byte	24,26,26

revenge_peasant_y:
	.byte	117,117,117
	.byte	117,123,140

revenge_peasant_sprite_l:
	.byte <peasant_flip0,<peasant_flip1,<peasant_flip2
	.byte <peasant_flip3,<peasant_flip4,<peasant_flip5

revenge_peasant_sprite_h:
	.byte >peasant_flip0,>peasant_flip1,>peasant_flip2
	.byte >peasant_flip3,>peasant_flip4,>peasant_flip5




	;
	;  8 frames -- nothing, flies still move
	;  6 frames -- rear1 @ 49,117
	;  6 frames -- rear2 @ 49,115
	;  6 frames -- rear3 
	;		peasant0 off feet (3)
	;		peasant1 (3)
	;  6 frames -- rear2
	;		peasant2 (upside down) 3
	;		peasant3 (3)
	;  6 frames -- rear1
	;		peasant4 (3)
	;		peasant5 (3) down on ground
	; 60 frames -- rear0 
	;		peasant6 bounce?
