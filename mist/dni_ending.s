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


; graphics needed:
;	hand out asking for page
;	page in hand
;	pick up myst book
;	put page in
;	look down sadly
;	zap away
;	gone
;		zap back (same as away?)
;	place book
;	back to writing

; says variations of "give me the page" while holding out hand
; click on him with

HAVE_PAGE_START = 5
ATRUS_WRITING = 10

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


; good ending

atrus_sprite_reaching:	; at 14,6
	.byte 10,14
	.byte $00,$00,$00,$55,$77,$77,$77,$77,$77,$77
	.byte $77,$00,$00,$77,$77,$77,$88,$88,$88,$87
	.byte $77,$70,$00,$77,$77,$88,$bb,$bb,$b8,$88
	.byte $77,$77,$00,$77,$77,$bb,$0b,$3b,$0b,$bb
	.byte $77,$77,$00,$f7,$df,$bb,$bb,$33,$bb,$bb
	.byte $77,$77,$ff,$df,$dd,$8b,$88,$88,$88,$8b
	.byte $77,$f7,$ff,$dd,$dd,$88,$88,$80,$88,$88
	.byte $f7,$ff,$ff,$dd,$dd,$df,$f8,$f8,$f8,$dd
	.byte $ff,$ff,$dd,$dd,$dd,$dd,$ff,$ff,$ff,$dd
	.byte $ff,$fd,$fd,$fd,$dd,$dd,$dd,$dd,$dd,$bd
	.byte $ff,$bb,$bb,$bb,$ff,$7d,$7d,$7d,$bb,$bb
	.byte $ff,$55,$bb,$bb,$ff,$07,$57,$55,$55,$5b
	.byte $ff,$55,$bb,$5b,$ff,$85,$50,$50,$50,$50
	.byte $8f,$f5,$f5,$f5,$8f,$80,$80,$80,$80,$80

atrus_sprite_hold_page:	; at 15,6
	.byte 9,11
	.byte $00,$00,$55,$77,$77,$77,$77,$77,$77
	.byte $00,$00,$77,$77,$77,$88,$88,$88,$87
	.byte $70,$00,$77,$77,$88,$bb,$bb,$b8,$88
	.byte $77,$00,$77,$77,$bb,$0b,$3b,$0b,$bb
	.byte $77,$00,$f7,$df,$bb,$bb,$33,$bb,$bb
	.byte $77,$ff,$df,$dd,$8b,$88,$88,$88,$8b
	.byte $f7,$ff,$dd,$dd,$88,$88,$80,$88,$88
	.byte $ff,$ff,$dd,$dd,$df,$f8,$f8,$f8,$dd
	.byte $ff,$dd,$dd,$dd,$dd,$ff,$ff,$dd,$dd
	.byte $fd,$bd,$bd,$bd,$fd,$fd,$fd,$fd,$bd
	.byte $bb,$bb,$bb,$fb,$ff,$ff,$ff,$bb,$bb

atrus_sprite_hold_book:	; at 15,6
	.byte 9,12
	.byte $00,$00,$55,$77,$87,$87,$87,$77,$77
	.byte $00,$00,$77,$87,$b8,$b8,$88,$88,$77
	.byte $70,$00,$77,$b8,$bb,$bb,$bb,$b8,$77
	.byte $77,$00,$77,$bb,$b0,$33,$b0,$bb,$77
	.byte $77,$00,$f7,$bb,$8b,$83,$8b,$bb,$d7
	.byte $77,$ff,$df,$88,$88,$08,$88,$88,$dd
	.byte $f7,$ff,$dd,$f8,$88,$88,$88,$d8,$dd
	.byte $ff,$ff,$dd,$dd,$df,$ff,$ff,$fd,$dd
	.byte $ff,$dd,$dd,$88,$88,$88,$88,$88,$dd
	.byte $fd,$bd,$bd,$b8,$88,$88,$88,$88,$bd
	.byte $bb,$bb,$bb,$8b,$88,$88,$88,$bb,$bb
	.byte $77,$77,$77,$78,$08,$58,$58,$58,$5b

atrus_sprite_place_page:	; at 15,6
	.byte 10,12
	.byte $00,$00,$55,$77,$87,$87,$87,$77,$77,$77
	.byte $00,$00,$77,$87,$b8,$b8,$88,$88,$77,$77
	.byte $70,$00,$77,$b8,$bb,$bb,$bb,$b8,$77,$77
	.byte $77,$00,$77,$bb,$b0,$33,$b0,$bb,$77,$77
	.byte $77,$00,$f7,$bb,$8b,$83,$8b,$bb,$d7,$d7
	.byte $77,$ff,$df,$88,$88,$08,$88,$88,$dd,$dd
	.byte $f7,$ff,$dd,$f8,$88,$88,$88,$d8,$dd,$dd
	.byte $ff,$ff,$dd,$dd,$df,$ff,$ff,$fd,$dd,$dd
	.byte $ff,$77,$7d,$dd,$dd,$ff,$ff,$dd,$dd,$dd
	.byte $ff,$bd,$77,$7d,$dd,$dd,$dd,$bd,$bd,$fd
	.byte $bb,$bb,$bb,$77,$7d,$7d,$7b,$7b,$bb,$ff
	.byte $87,$87,$87,$87,$08,$58,$58,$58,$5b,$5f

atrus_sprite_sad:	; at 14,14
	.byte 11,8
	.byte $77,$77,$00,$f7,$f7,$b0,$33,$b3,$b8,$88,$d7
	.byte $77,$77,$ff,$df,$df,$8b,$33,$bb,$bb,$ff,$dd
	.byte $77,$f7,$ff,$dd,$fd,$88,$80,$88,$fb,$ff,$fd
	.byte $f7,$ff,$ff,$dd,$dd,$df,$f8,$f8,$ff,$ff,$ff
	.byte $ff,$ff,$df,$dd,$dd,$dd,$ff,$dd,$ff,$ff,$ff
	.byte $ff,$ff,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$ff,$ff
	.byte $bb,$bb,$dd,$dd,$7d,$7d,$7d,$7d,$7d,$df,$ff
	.byte $ff,$57,$57,$57,$57,$08,$58,$58,$58,$58,$8f

atrus_sprite_link:	; at 15,6
	.byte 10,12
	.byte $00,$00,$55,$77,$87,$87,$87,$77,$77,$77
	.byte $00,$00,$77,$87,$b8,$b8,$88,$88,$77,$77
	.byte $70,$00,$77,$b8,$bb,$bb,$bb,$b8,$77,$77
	.byte $77,$00,$77,$bb,$b0,$33,$b0,$bb,$77,$77
	.byte $77,$00,$f7,$bb,$8b,$83,$8b,$bb,$d7,$d7
	.byte $77,$ff,$df,$88,$88,$08,$88,$88,$dd,$dd
	.byte $f7,$ff,$dd,$f8,$88,$88,$88,$d8,$dd,$dd
	.byte $ff,$ff,$dd,$dd,$df,$ff,$ff,$fd,$dd,$dd
	.byte $ff,$df,$dd,$dd,$dd,$ff,$ff,$dd,$dd,$dd
	.byte $ff,$dd,$dd,$dd,$dd,$dd,$dd,$bd,$bd,$fd
	.byte $bb,$bb,$bd,$bd,$7d,$7d,$7b,$7b,$bb,$ff
	.byte $87,$87,$57,$57,$08,$58,$58,$58,$58,$5f

atrus_sprite_going:	; at 13,6
	.byte 14,12
	.byte $77,$00,$00,$00,$55,$77,$77,$87,$77,$77,$77,$77,$07,$00
	.byte $77,$77,$00,$00,$77,$77,$78,$b7,$78,$77,$77,$77,$00,$00
	.byte $77,$77,$70,$00,$77,$77,$7b,$b7,$7b,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$00,$77,$77,$70,$37,$70,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$00,$77,$77,$7b,$87,$7b,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$00,$77,$77,$78,$07,$78,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$00,$77,$f7,$78,$87,$78,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$00,$77,$d7,$7f,$f7,$7f,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$50,$7d,$d7,$7d,$f7,$7f,$77,$77,$77,$00,$00
	.byte $77,$77,$f7,$55,$7d,$d7,$7d,$d7,$77,$b7,$b7,$77,$00,$00
	.byte $77,$ff,$bb,$bb,$bd,$bd,$7d,$f7,$fb,$fb,$bb,$77,$00,$00
	.byte $22,$ff,$8f,$8f,$8f,$8f,$08,$58,$58,$58,$58,$87,$40,$00

atrus_sprite_gone:	; at 13,6
	.byte 15,13
	.byte $77,$00,$00,$00,$55,$77,$77,$77,$77,$77,$77,$77,$77,$07,$00
	.byte $77,$77,$00,$00,$77,$77,$77,$77,$77,$77,$77,$77,$77,$00,$00
	.byte $77,$77,$70,$00,$77,$77,$77,$77,$77,$77,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$00,$77,$77,$77,$77,$77,$77,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$00,$77,$77,$77,$77,$77,$77,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$00,$77,$77,$77,$77,$77,$77,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$00,$77,$77,$77,$77,$77,$77,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$00,$77,$77,$77,$77,$77,$77,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$50,$77,$77,$77,$77,$77,$77,$77,$77,$77,$00,$00
	.byte $77,$77,$f7,$55,$77,$77,$77,$77,$77,$77,$77,$77,$77,$00,$00
	.byte $77,$77,$77,$55,$77,$77,$f7,$f7,$f7,$f7,$77,$77,$77,$00,$00
	.byte $22,$87,$8f,$8f,$8f,$8f,$08,$58,$58,$58,$58,$87,$87,$40,$00
	.byte $22,$25,$85,$85,$85,$85,$85,$50,$50,$50,$50,$40,$44,$04,$80



atrus_sprite_book_down:	; at 15,6
	.byte 12,12
	.byte $00,$00,$55,$77,$87,$87,$87,$77,$77,$77,$77,$07
	.byte $00,$00,$77,$87,$b8,$b8,$88,$88,$77,$77,$77,$00
	.byte $70,$00,$77,$b8,$bb,$bb,$bb,$b8,$77,$77,$77,$00
	.byte $77,$00,$77,$bb,$b0,$33,$b0,$bb,$77,$77,$77,$00
	.byte $77,$00,$f7,$bb,$8b,$83,$8b,$bb,$d7,$d7,$77,$00
	.byte $77,$ff,$df,$88,$88,$08,$88,$88,$dd,$dd,$dd,$00
	.byte $f7,$ff,$dd,$f8,$88,$88,$88,$d8,$dd,$dd,$ff,$f0
	.byte $ff,$ff,$dd,$dd,$df,$ff,$ff,$fd,$dd,$dd,$ff,$ff
	.byte $ff,$ff,$dd,$dd,$dd,$ff,$dd,$dd,$dd,$dd,$ff,$ff
	.byte $ff,$bd,$dd,$dd,$dd,$88,$88,$88,$88,$b8,$bb,$bb
	.byte $bb,$bb,$bb,$db,$dd,$d8,$d8,$d8,$d8,$d8,$5b,$55
	.byte $7b,$7b,$7b,$7d,$0d,$5d,$5d,$5d,$5d,$5d,$5f,$4f













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
           ;0123456789012345678901234567890123456789
atrus_text_page2:
.byte 6,20,"YOU'VE DONE THE RIGHT THING.",0
.byte 3,21,"I HAVE A DIFFICULT CHOICE TO MAKE.",0
.byte 4,22,"MY SONS BETRAYED ME: I KNOW WHAT",0
.byte 3,23,"I MUST DO.  I SHALL RETURN SHORTLY",0

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
	cmp	#ATRUS_WRITING
	bcs	no_speedup	; bge

	cmp	#3		; don't skip too far in no page case
	bcs	no_speedup	; blt

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
	cmp	#ATRUS_WRITING
	bcc	not_writing		; blt

atrus_is_writing:

	lda	FRAMEL
	and	#$3f
	bne	no_increment

	lda	DNI_PROGRESS
	eor	#$1
	sta	DNI_PROGRESS

	jmp	no_increment


	;======================
	; not writing
	;======================

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

	lda	#ATRUS_WRITING		; if not have it, end of text, skip to end
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

	; see if it's the first time we've opened book
	lda	DNI_PROGRESS
	beq	actually_talk_with_atrus

	; skip to just writing if not
	lda	#ATRUS_WRITING
	sta	DNI_PROGRESS

actually_talk_with_atrus:

	lda	HOLDING_PAGE
	and	#$c0
	cmp	#HOLDING_WHITE_PAGE
	bne	not_holding_page

	lda	#HAVE_PAGE_START
	sta	DNI_PROGRESS

not_holding_page:

	lda	#DIRECTION_N|DIRECTION_SPLIT
	sta	DIRECTION

	lda	#DNI_DESK
	sta	LOCATION
	jmp	change_location


