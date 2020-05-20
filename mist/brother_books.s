	;===========================
	; Touch the red book
	;===========================
touch_red_book:

	; first see if picking up the page
	lda	CURSOR_X
	cmp	#24
	bcc	yes_touching_red_book		; blt

	lda	RED_PAGES_TAKEN
	and	#OCTAGON_PAGE
	bne	no_touch_red_page

	lda	#OCTAGON_PAGE
	jsr	take_red_page
no_touch_red_page:
	rts


yes_touching_red_book:
	; if have a red page, take it and increment count

	lda	HOLDING_PAGE
	and	#$c0
	cmp	#HOLDING_RED_PAGE
	bne	not_red_page

	lda	#0		; put down page
	sta	HOLDING_PAGE

	inc	RED_PAGE_COUNT	; increment page count

	; in actual game plays sound effect here

	rts

not_red_page:

	lda	#0
	sta	FRAMEL

	lda	#OCTAGON_RED_BOOK_CLOSED
	sta	LOCATION

	jsr	change_location

	rts


	;===========================
	; Touch the blue book
	;===========================
touch_blue_book:

	; first see if picking up the page
	lda	CURSOR_X
	cmp	#24
	bcc	yes_touching_blue_book		; blt

	lda	BLUE_PAGES_TAKEN
	and	#OCTAGON_PAGE
	bne	no_touch_blue_page

	lda	#OCTAGON_PAGE
	jsr	take_blue_page
no_touch_blue_page:
	rts

yes_touching_blue_book:

	; if have a blue page, take it and increment count

	lda	HOLDING_PAGE
	and	#$c0
	cmp	#HOLDING_BLUE_PAGE
	bne	not_blue_page

	lda	#0		; put down page
	sta	HOLDING_PAGE

	inc	BLUE_PAGE_COUNT	; increment page count

	; in actual game plays sound effect here

	rts

not_blue_page:

	lda	#0
	sta	FRAMEL

	lda	#OCTAGON_BLUE_BOOK_CLOSED
	sta	LOCATION

	jsr	change_location

	rts




	;===========================
	; Red book animation
	;===========================

red_book_animation:


	jsr	gr_copy_to_current

	jsr	page_flip

	lda	#120
	jsr	WAIT


	jsr	page_flip

	lda	#120
	jsr	WAIT


	inc	FRAMEL
	lda	FRAMEL
	cmp	#5
	bne	done_sir

	;; annoying brother

	jsr	gr_copy_to_current

	jsr	page_flip

	; FIXME
	lda	#<audio_red_page
	sta	BTC_L
	lda	#>audio_red_page
	sta	BTC_H
	ldx	#21		; 21 pages long???
	jsr	play_audio

;	lda	#100
;	jsr	WAIT


done_sir:

red_book_done:


	rts


;==========================
; books sprites
;==========================

red_book_sprite_sequence0:
	.word red_book_static1_sprite
	.word red_book_static2_sprite
	.word red_book_static1_sprite
	.word red_book_static2_sprite

red_book_sprite_sequence1:
	.word red_book_static1_sprite
	.word red_book_static2_sprite
	.word red_book_face_sprite
	.word red_book_static2_sprite


red_book_face_sprite:
	.byte 9,7
	.byte $31,$88,$bb,$bb,$bb,$bb,$bb,$88,$13
	.byte $31,$bb,$bb,$b0,$bb,$b0,$bb,$11,$13
	.byte $31,$bb,$bb,$bb,$33,$bb,$bb,$11,$13
	.byte $31,$11,$bb,$8b,$b8,$8b,$bb,$11,$13
	.byte $31,$11,$bb,$bb,$b3,$bb,$bb,$11,$13
	.byte $11,$01,$01,$8b,$88,$8b,$01,$01,$13
	.byte $A0,$A0,$A0,$Af,$Af,$Af,$A0,$A0,$A0

red_book_static1_sprite:
	.byte 9,7
	.byte $11,$1b,$11,$1f,$1b,$11,$11,$13,$11
	.byte $b1,$13,$11,$1b,$11,$13,$11,$1b,$f1
	.byte $31,$11,$b1,$13,$11,$1f,$13,$b1,$31
	.byte $11,$1f,$11,$11,$13,$11,$1b,$f1,$11
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $31,$1b,$f1,$11,$f3,$11,$31,$1b,$11
	.byte $A1,$A1,$A3,$A1,$A1,$Ab,$A1,$A1,$A3

red_book_static2_sprite:
	.byte 9,7
	.byte $01,$01,$01,$0b,$01,$01,$01,$0f,$01
	.byte $10,$b0,$10,$10,$30,$10,$10,$b0,$10
	.byte $13,$11,$3f,$11,$1f,$b1,$13,$11,$31
	.byte $1f,$11,$11,$11,$13,$11,$1b,$11,$f1
	.byte $11,$1b,$f1,$1f,$1b,$31,$f1,$1b,$11
	.byte $13,$11,$1b,$11,$11,$11,$b1,$13,$b1
	.byte $A1,$Af,$A1,$A3,$A1,$A1,$A1,$A1,$A1



;==========================
; books dialog
;==========================

;==========================
; red/sirrus

; red 0
; only static

; 0123456789012345678901234567890123456789
; red 1
; who are you, bring me a red page, I can't see you
; I am Sirrus

; red 2
; You've returned.  Thank you for the red page.
; I beg you to find the remaining red pages.
; Don't waste time on my brother, he is guilty.

; red 3
; Free me from my prison.  I am called Sirrus.
; I need two more pages.  Don't touch the blue
; Don not help my wicked brother Achenar.

; red 4
; With each page I can see you more clearly.
; Achenar is guilty of conquest.  He took
; advantage of father.  Free me and I will reward you

; red 5
; You've finally returned.  You must think Achenar is guilty.
; Find page 158 in the pattern book and retrieve the last page.
; Do not touch the green book you find there.
;
; Achenar became disturbed, conquest.
; Father must be lost

; ending
; I am free!  Thank you!  You've done the right thing.
; Stupid fool.  Let me rip some pages out.
; I hope you're into books.  Goodbye!

;==========================
; blue/Achenar

; blue 0
; only static

; blue 1
; sirrus is that you?  who are you? help me.  bring blue pages
; I must have the blue page

; blue 2
; you've returned,  I'm Achenar.  don't listen to my brother.
; egotistical fool and liar, bring the blue pages, not the red ones
; I've been wrongly imprisoned.   I will have my retribution.

; blue 3
; you've returned, good.  bring blue pages.
; sirrus trapped me here.  He is greedy.
; don't touch the red pages.

; blue 4
; my friend, I see you think Sirrus is guilty.
; Have you observed his lust for riches.
; Please bring more blue pages.

; blue 5
; Sirrus is guilty, lied to father and killed him
; Find pattern 158 and use it in the fireplace.
; Don't touch the green book!

; after
; Haha I am free!  I fel so alive!
; These pages you worked so hard to find
; what happens if I pull them out?
; Maybe someone will rescue you.
