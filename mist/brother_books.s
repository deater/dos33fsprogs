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

	lda	#OCTAGON_RED_BOOK_CLOSED
	sta	LOCATION

	jsr	change_location

	rts


open_red_book:

	lda	#OCTAGON_RED_BOOK_OPEN
	sta	LOCATION

	lda	#DIRECTION_W|DIRECTION_SPLIT
open_book:
	sta	DIRECTION

	jsr	change_location

	lda	#1
	sta	ANIMATE_FRAME

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

	lda	#OCTAGON_BLUE_BOOK_CLOSED
	sta	LOCATION

	jsr	change_location

	rts

open_blue_book:

	lda	#OCTAGON_BLUE_BOOK_OPEN
	sta	LOCATION

	lda	#DIRECTION_E|DIRECTION_SPLIT
	jmp	open_book



	;===========================
	; Red book animation
	;===========================

red_book_animation:

	lda	ANIMATE_FRAME
	asl
	tay

	lda	red_book_sprite_sequence0,Y
	sta	INL
	lda	red_book_sprite_sequence0+1,Y
	sta	INH

        lda     #23

advance_red_book:
	sta	XPOS
	lda	#14
	sta	YPOS

	jsr	put_sprite_crop

	; Play the "bring red pages" audio

;	lda	#<audio_red_page
;	sta	BTC_L
;	lda	#>audio_red_page
;	sta	BTC_H
;	ldx	#21		; 21 pages long???
;	jsr	play_audio

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

sirrus_dialog:
	.word red_dialog0,red_dialog1,red_dialog2,red_dialog3
	.word red_dialog4,red_dialog5,red_dialog6

; red 0
; only static
red_dialog0:
	.byte 15,22
	.byte "**STATIC**",0

; red 1
; who are you, bring me a red page, I can't see you
; I am Sirrus

             ; 0123456789012345678901234567890123456789
red_dialog1:
	.byte 0,21
	.byte "WHO ARE YOU? I CAN'T SEE YOU",0
	.byte 0,22
	.byte "BRING ME A RED PAGE. I AM SIRRUS.",0

; red 2
; You've returned.  Thank you for the red page.
; I beg you to find the remaining red pages.
; Don't waste time on my brother, he is guilty.

             ; 0123456789012345678901234567890123456789
red_dialog2:
	.byte 0,21
	.byte "YOU'VE RETURNED. THANK YOU FOR THE PAGE",0
	.byte 0,22
	.byte "I BEG YOU TO FIND REMAINING RED PAGES",0
	.byte 0,23
	.byte "DON'T WASTE TIME ON MY GUILTY BROTHER",0

; red 3
; Free me from my prison.  I am called Sirrus.
; I need two more pages.  Don't touch the blue
; Don not help my wicked brother Achenar.

             ; 0123456789012345678901234567890123456789
red_dialog3:
	.byte 0,21
	.byte "FREE ME FROM MY PRISON.  I AM SIRRUS.",0
	.byte 0,22
	.byte "I NEED MORE PAGES, DON'T TOUCH BLUE ONES",0
	.byte 0,23
	.byte "DO NOT HELP MY WICKED BROTHER ACHENAR",0

; red 4
; With each page I can see you more clearly.
; Achenar is guilty of conquest.  He took
; advantage of father.  Free me and I will reward you

             ; 0123456789012345678901234567890123456789
red_dialog4:
	.byte 0,21
	.byte "WITH EACH PAGE I CAN SEE MORE CLEARLY",0
	.byte 0,22
	.byte "ACHENAR IS GUILTY OF CONQUEST",0
	.byte 0,23
	.byte "FREE ME AND I WILL REWARD YOU",0

; red 5
; You've finally returned.  You must think Achenar is guilty.
; Find page 158 in the pattern book and retrieve the last page.
; Do not touch the green book you find there.
;
; Achenar became disturbed, conquest.
; Father must be lost


             ; 0123456789012345678901234567890123456789
red_dialog5:
	.byte 0,21
	.byte "YOU FINALLY RETURNED.",0
	.byte 0,22
	.byte "YOU MUST THINK ACHENAR IS GUILTY",0
	.byte 0,23
	.byte "USE PAGE 158 IN PATTERN BOOK",0
	.byte 0,24
	.byte "DO NOT TOUCH THE GREEN BOOK",0

; ending
; I am free!  Thank you!  You've done the right thing.
; Stupid fool.  Let me rip some pages out.
; I hope you're into books.  Goodbye!

             ; 0123456789012345678901234567890123456789
red_dialog6:
	.byte 0,21
	.byte "I AM FREE! THANK YOU, YOU STUPID FOOL!",0
	.byte 0,22
	.byte "LET ME RIP SOME PAGES OUT!",0
	.byte 0,23
	.byte "I HOPE YOU'RE INTO BOOKS!  GOODBYE!",0

;==========================
; blue/Achenar

achenar_dialog:
	.word red_dialog0,blue_dialog1,blue_dialog2,blue_dialog3
	.word blue_dialog4,blue_dialog5,blue_dialog6

; blue 0
; only static

; blue 1
; sirrus is that you?  who are you? help me.  bring blue pages
; I must have the blue page

             ; 0123456789012345678901234567890123456789
blue_dialog1:
	.byte 0,21
	.byte "SIRRUS IS THAT YOU?  WHO ARE YOU?",0
	.byte 0,22
	.byte "BRING BLUE PAGES. MUST HAVE BLUE PAGES",0

; blue 2
; you've returned,  I'm Achenar.  don't listen to my brother.
; egotistical fool and liar, bring the blue pages, not the red ones
; I've been wrongly imprisoned.   I will have my retribution.

             ; 0123456789012345678901234567890123456789
blue_dialog2:
	.byte 0,21
	.byte "YOU'VE RETURNED.  I'M ACHENAR.",0
	.byte 0,22
	.byte "DON'T LISTEN TO MY LIAR BROTHER",0
	.byte 0,23
	.byte "BRING BLUE PAGES, NOT RED",0
	.byte 0,24
	.byte "I WILL HAVE MY RETRIBUTION",0

; blue 3
; you've returned, good.  bring blue pages.
; sirrus trapped me here.  He is greedy.
; don't touch the red pages.

             ; 0123456789012345678901234567890123456789
blue_dialog3:
	.byte 0,21
	.byte "YOU'VE RETURNED, GOOD.",0
	.byte 0,22
	.byte "GREEDY SIRRUS TRAPPED ME HERE",0
	.byte 0,23
	.byte "BRING BLUE PAGES, DON'T TOUCH THE RED",0

; blue 4
; my friend, I see you think Sirrus is guilty.
; Have you observed his lust for riches.
; Please bring more blue pages.

             ; 0123456789012345678901234567890123456789
blue_dialog4:
	.byte 0,21
	.byte "FRIEND, I SEE YOU THINK SIRRUS IS WRONG",0
	.byte 0,22
	.byte "HAVE YOU OBSERVED HIS LUST FOR RICHES",0
	.byte 0,23
	.byte "PLEASE BRING MORE BLUE PAGES",0

; blue 5
; Sirrus is guilty, lied to father and killed him
; Find pattern 158 and use it in the fireplace.
; Don't touch the green book!

             ; 0123456789012345678901234567890123456789
blue_dialog5:
	.byte 0,21
	.byte "SIRRUS IS GUILTY, HE LIED TO FATHER",0
	.byte 0,22
	.byte "FIND PATTERN 158 AND USE THE FIREPLACE",0
	.byte 0,23
	.byte "DON'T TOUCH THE GREEN BOOK!",0

; after
; Haha I am free!  I feel so alive!
; These pages you worked so hard to find
; what happens if I pull them out?
; Maybe someone will rescue you.

             ; 0123456789012345678901234567890123456789
blue_dialog6:
	.byte 0,21
	.byte "HAHA I AM FREE!  I FEEL SO ALIVE!",0
	.byte 0,22
	.byte "WHAT HAPPENS IF I RIP THESE PAGES OUT?",0
	.byte 0,23
	.byte "MAYBE SOMEONE WILL RESCUE YOU",0
