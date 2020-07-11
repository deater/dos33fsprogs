; Ending with page steps
;
; DNI_PROGRESS
;	5		say text both
;	6		say give me page (until you do)
;	7		takes page
;	8		puts in book / says staement about sons
;	9		zaps into book
;	10		pause
;	11		zaps out of book
;	12		page3/it is done
;	13		page4/reward
;	14		page5/stick around
;		effect of clicking is now myst linking book
;		red/blue book in myst replaced and no longer can click on
;		all red/blue/white pages cleared out
;		atrus no longer talks in green book


atrus_text:
	.word atrus_text_nothing	; 0
	.word atrus_text_both		; 1
	.word atrus_text_nopage1	; 2
	.word atrus_text_nopage2	; 3
	.word atrus_text_nothing	; 4
	.word atrus_text_page1		; 5
	.word atrus_text_page2		; 6
	.word atrus_text_page3		; 7
	.word atrus_text_page4		; 8
	.word atrus_text_page5		; 9
	.word atrus_text_nothing	; 10
	.word atrus_text_nothing	; 11


atrus_sprites:
	.word	atrus_sprite_writing1	; 0
	.word	atrus_sprite_talking	; 1
	.word	atrus_sprite_facepalm	; 2
	.word	atrus_sprite_talking	; 3
	.word	atrus_sprite_writing1	; 4
	.word	atrus_sprite_talking	; 5
	.word	atrus_sprite_talking	; 6
	.word	atrus_sprite_talking	; 7
	.word	atrus_sprite_talking	; 8
	.word	atrus_sprite_talking	; 9
	.word	atrus_sprite_writing1	; 10
	.word	atrus_sprite_writing2	; 11

atrus_xy:
	.byte	13,6,  16,6,  16,6
	.byte	16,6,  13,6,  16,6
	.byte	16,6,  16,6,  16,6
	.byte	16,6,  13,6,  15,22

atrus_sprite_writing1:
	.byte 1,1
	.byte	$AA


atrus_sprite_writing2:
	.byte 5,3
	.byte	$ff,$dd,$0d,$dd,$dd
	.byte	$fd,$bd,$b0,$0d,$dd
	.byte	$ff,$bb,$bb,$bb,$0d

atrus_sprite_facepalm:
	.byte 10,12
	.byte	$00,$55,$77,$77,$77,$77,$77,$77,$77,$77
	.byte	$00,$77,$77,$77,$88,$88,$88,$87,$77,$77
	.byte	$00,$77,$77,$88,$b8,$b8,$bb,$bb,$77,$77
	.byte	$00,$77,$77,$bb,$3b,$3b,$bb,$bb,$77,$77
	.byte	$00,$f7,$df,$bb,$3b,$33,$33,$3b,$f7,$77
	.byte	$ff,$df,$dd,$8b,$33,$33,$33,$33,$ff,$ff
	.byte	$ff,$dd,$dd,$88,$88,$83,$83,$53,$ff,$ff
	.byte	$ff,$dd,$dd,$df,$f8,$f8,$f8,$55,$ff,$ff
	.byte	$dd,$dd,$dd,$dd,$ff,$ff,$dd,$55,$ff,$ff
	.byte	$bd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$ff
	.byte	$bb,$bb,$7d,$7d,$7d,$7d,$7d,$7d,$dd,$df
	.byte	$77,$77,$77,$07,$57,$55,$55,$55,$55,$5d
atrus_sprite_talking:
	.byte 8,11
	.byte	$00,$55,$77,$77,$77,$77,$77,$77
	.byte	$00,$77,$77,$77,$88,$88,$88,$87
	.byte	$00,$77,$77,$88,$bb,$bb,$b8,$bb
	.byte	$00,$77,$77,$bb,$0b,$3b,$0b,$bb
	.byte	$00,$f7,$df,$bb,$bb,$33,$bb,$bb
	.byte	$ff,$df,$dd,$8b,$88,$88,$88,$8b
	.byte	$ff,$dd,$dd,$88,$88,$80,$88,$88
	.byte	$ff,$dd,$dd,$df,$f8,$f8,$f8,$dd
	.byte	$dd,$dd,$dd,$dd,$ff,$ff,$dd,$dd
	.byte	$bd,$dd,$dd,$dd,$dd,$dd,$dd,$bd
	.byte	$bb,$bb,$7d,$7d,$7d,$7d,$bb,$bb



atrus_sprite_nothing:
	.byte 1,1
	.byte	$AA




;
; ending, both
;
atrus_text_both:
.byte 0,20,"AH, MY FRIEND.  YOU'VE RETURNED.",0
.byte 0,21,"WE MEET FACE-TO-FACE.",0
.byte 0,22,"AND THE PAGE, DID YOU BRING THE PAGE?",0
.byte 0,23," ",0

; ending, no white page
;

atrus_text_nopage1:
.byte 0,20,"YOU DIDN'T BRING THE PAGE.",0
.byte 0,21,"YOU DIDN'T BRING THE PAGE!",0
.byte 0,22,"WHAT KIND OF FOOL ARE YOU?!",0
.byte 0,23,"DID YOU NOT TAKE MY WARNING SERIOUSLY?",0

atrus_text_nopage2:
.byte 17,20,"*SIGH*",0
.byte  0,21," ",0
.byte 12,22,"WELCOME TO D'NI",0
.byte  2,23,"YOU AND I WILL LIVE HERE... FOREVER.",0


; ending, with white page

atrus_text_page1:
.byte 0,20," ",0
.byte 0,21,"GIVE IT TO ME... GIVE ME THE PAGE",0
.byte 0,22,"PLEASE GIVE THE PAGE...",0
.byte 0,23," ",0

atrus_text_page2:
.byte 0,20,"YOU'VE DONE THE RIGHT THING.",0
.byte 0,21,"I HAVE A DIFFICULT CHOIC TO MAKE",0
.byte 0,22,"MY SONS BETRAYED ME, I KNOW",0
.byte 0,23,"WHAT I MUST DO.  I SHALL RETURN SHORTLY",0

; [links away]

; [links in]

atrus_text_page3:
.byte 0,20,"IT IS DONE.  I HAVE MANY QUESTIONS,",0
.byte 0,21,"BUT MY WRITING CANNOT WAIT.  MY DELAY",0
.byte 0,22,"MAY HAVE HAD A CATASTROPHIC IMPACT ON",0
.byte 0,23,"THE WORLD WHERE MY WIFE IS HELD HOSTAGE",0

atrus_text_page4:
.byte 0,20,"A REWARD? I'M SORRY BUT ALL I HAVE TO",0
.byte 0,21,"OFFER IS THE LIBRARY ON MYST AND THE",0
.byte 0,22,"BOOKS CONTAINED THERE.  FEEL FREE TO",0
.byte 0,23,"EXPLORE AT YOUR LEISURE.",0

atrus_text_page5:
.byte 0,20,"ALSO, I AM FIGHTING A FOE MUCH",0
.byte 0,21,"GREATER THAN MY SONS CAN IMAGINE.",0
.byte 0,22,"I MIGHT REQUEST YOUR ASSISTANCE.",0
.byte 0,23,"UNTIL THEN, HAVE FUN ON MYST",0


atrus_text_nothing:
.byte 0,20," ",0
.byte 0,21," ",0
.byte 0,22," ",0
.byte 0,23," ",0


	; just speed up talking
skip_text:
	lda	DNI_PROGRESS
	cmp	#10
	bcs	no_speedup

	; skip to next
	inc	DNI_PROGRESS
	lda	#0
	sta	FRAMEL
	sta	FRAMEH

no_speedup:
	rts


	;====================================
	; draw atrus
	;====================================
draw_atrus:

	; handle writing separately

	lda	DNI_PROGRESS
	cmp	#10
	bcc	not_writing		; blt

atrus_is_writing:

	lda	FRAMEL
	and	#$3f
	bne	no_increment

	lda	DNI_PROGRESS
	eor	#$1
	sta	DNI_PROGRESS

	jmp	no_increment

not_writing:

	; calc next frame
	lda	FRAMEH
	cmp	#$2
	bne	no_increment

do_increment:
	inc	DNI_PROGRESS

	lda	#0
	sta	FRAMEH
	sta	FRAMEL

	lda	DNI_PROGRESS
	cmp	#4
	bne	no_increment

	lda	#10		; if not have it, end of text, skip to end
	sta	DNI_PROGRESS

no_increment:

	; only draw the words if looking at atrus
	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_N
	bne	done_draw_atrus

	; put words

	bit	TEXTGR		; in case turned off by turning mid-speech

	jsr	clear_bottom

	lda	DNI_PROGRESS
	asl
	tay
	lda	atrus_text,Y
	sta	OUTL
	lda	atrus_text+1,Y
	sta	OUTH

	lda	#$09		; ora
	sta	ps_smc1
	lda	#$80
	sta	ps_smc1+1	; set regular text

	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	lda	#$29		; and
	sta	ps_smc1
	lda	#$3f
	sta	ps_smc1+1	; restore inverse text

	; draw sprite

	lda	DNI_PROGRESS
	asl
	tay

	lda	atrus_xy,Y
	sta	XPOS

	lda	atrus_xy+1,Y
	sta	YPOS

	lda	atrus_sprites,Y
	sta	INL
	lda	atrus_sprites+1,Y
	sta	INH

	jsr	put_sprite_crop
done_draw_atrus:
	rts



	;==========================
	; visit atrus
	;    mostly has to do with getting dialog right

visit_atrus:
	; start part-way through pause
	lda	#1
	sta	FRAMEH
	lda	#$80
	sta	FRAMEL		; want consistent timers


	; FIXME: check for white page or not

	; see if it's the first time we've opened book
	lda	DNI_PROGRESS
	beq	actually_talk_with_atrus

	; skip to just writing if not
	lda	#10
	sta	DNI_PROGRESS

actually_talk_with_atrus:

	lda	#DIRECTION_N|DIRECTION_SPLIT
	sta	DIRECTION

	lda	#DNI_DESK
	sta	LOCATION
	jmp	change_location


