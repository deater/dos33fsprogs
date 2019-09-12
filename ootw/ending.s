; ootw
; quick demo of what the ending might be like


; by Vince "Deater" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

ending:

	;=========================
	; set up sound
	;=========================

	jsr	pt3_setup

	lda	#1
	sta	LOOP


;	jmp	quit_level

	jsr	wait_until_keypressed

repeat_ending:

	;===========================
	; Enable graphics
	;===========================

	bit	LORES
	bit	SET_GR
	bit	FULLGR
	bit	KEYRESET

	;===========================
	; Setup pages (is this necessary?)
	;===========================

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE




	;===========================
	; show some pictures
	;============================


	;==================
	; bath
	;==================

	lda	#>(bath_rle)
	sta	GBASH
	lda	#<(bath_rle)
	sta	GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr


	jsr	gr_copy_to_current
	jsr	page_flip

	jsr	wait_until_keypressed

	;==================
	; battle
	;==================

	lda	#>(battle_rle)
	sta	GBASH
	lda	#<(battle_rle)
	sta	GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr


	jsr	gr_copy_to_current
	jsr	page_flip

	jsr	wait_until_keypressed

	;==================
	; grabbed
	;==================

	lda	#>(grabbed_rle)
	sta	GBASH
	lda	#<(grabbed_rle)
	sta	GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr


	jsr	gr_copy_to_current
	jsr	page_flip

	jsr	wait_until_keypressed

	;===========================
	; ending sequence
	;============================






	;=========================
	; set up bg
	;=========================

	lda	#>(sky_bg_rle)
	sta	GBASH
	lda	#<(sky_bg_rle)
	sta	GBASL
	lda	#$0c			; load image off-screen $c00
	jsr	load_rle_gr

	;===================
	; rooftop00

	lda	#>(rooftop0_rle)
	sta	GBASH
	lda	#<(rooftop0_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

	jsr	wait_until_keypressed


	; start music

	cli	; enable interrupts

	ldx	#240
	jsr	long_wait

	;===================
	; rooftop01

	lda	#>(rooftop1_rle)
	sta	GBASH
	lda	#<(rooftop1_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#60
	jsr	long_wait

	;===================
	; rooftop02

	lda	#>(rooftop2_rle)
	sta	GBASH
	lda	#<(rooftop2_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#60
	jsr	long_wait

	;===================
	; rooftop03

	lda	#>(rooftop3_rle)
	sta	GBASH
	lda	#<(rooftop3_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#50
	jsr	long_wait

	;===================
	; onboard

	lda	#>(onboard_rle)
	sta	GBASH
	lda	#<(onboard_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#50
	jsr	long_wait



	;=========================
	; set up wing bg
	;=========================

	lda	#>(wing_bg_rle)
	sta	GBASH
	lda	#<(wing_bg_rle)
	sta	GBASL
	lda	#$0c			; load image off-screen $c00
	jsr	load_rle_gr

	;===================
	; left wing 1

	lda	#>(left_unfurl1_rle)
	sta	GBASH
	lda	#<(left_unfurl1_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#40
	jsr	long_wait

	;===================
	; left wing 2

	lda	#>(left_unfurl2_rle)
	sta	GBASH
	lda	#<(left_unfurl2_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; right wing 1

	lda	#>(right_unfurl1_rle)
	sta	GBASH
	lda	#<(right_unfurl1_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#40
	jsr	long_wait

	;===================
	; right wing 2

	lda	#>(right_unfurl2_rle)
	sta	GBASH
	lda	#<(right_unfurl2_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#30
	jsr	long_wait

	;=========================
	; re-set up sky bg
	;=========================

	lda	#>(sky_bg_rle)
	sta	GBASH
	lda	#<(sky_bg_rle)
	sta	GBASL
	lda	#$0c			; load image off-screen $c00
	jsr	load_rle_gr

	;===================
	; flying01

	lda	#>(flying01_rle)
	sta	GBASH
	lda	#<(flying01_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying03

	lda	#>(flying03_rle)
	sta	GBASH
	lda	#<(flying03_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying05

	lda	#>(flying05_rle)
	sta	GBASH
	lda	#<(flying05_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying07

	lda	#>(flying07_rle)
	sta	GBASH
	lda	#<(flying07_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying09

	lda	#>(flying09_rle)
	sta	GBASH
	lda	#<(flying09_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying11

	lda	#>(flying11_rle)
	sta	GBASH
	lda	#<(flying11_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end01

	lda	#>(the_end01_rle)
	sta	GBASH
	lda	#<(the_end01_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end02

	lda	#>(the_end02_rle)
	sta	GBASH
	lda	#<(the_end02_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end03

	lda	#>(the_end03_rle)
	sta	GBASH
	lda	#<(the_end03_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end04

	lda	#>(the_end04_rle)
	sta	GBASH
	lda	#<(the_end04_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end05

	lda	#>(the_end05_rle)
	sta	GBASH
	lda	#<(the_end05_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end06

	lda	#>(the_end06_rle)
	sta	GBASH
	lda	#<(the_end06_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end07

	lda	#>(the_end07_rle)
	sta	GBASH
	lda	#<(the_end07_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#200
	jsr	long_wait

	;===================
	; the end08

	lda	#>(the_end08_rle)
	sta	GBASH
	lda	#<(the_end08_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end09

	lda	#>(the_end09_rle)
	sta	GBASH
	lda	#<(the_end09_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end10

	lda	#>(the_end10_rle)
	sta	GBASH
	lda	#<(the_end10_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait



;===========================
; real end
;===========================

quit_level:
	jsr	TEXT
	jsr	HOME
	lda	KEYRESET		; clear strobe

	;======================
	; scroll credits
	;======================

	;
	;
	; 0@24
	; 0@23,1@24
	; 0@22,1@23,2@24...
	; 0@0...


	ldx	#46

scroll_loop:
	jsr	HOME

	ldy	#0
	stx	XPOS
print_loop:

	lda	credit_list,Y
	sta	OUTL
	lda	credit_list+1,Y
	sta	OUTH

	tya
	pha

	ldy	XPOS
	jsr	gotoy

	jsr	print_string

	pla
	tay

	iny
	iny

	inc	XPOS
	inc	XPOS
	lda	XPOS
	cmp	#48
	bne	print_loop

	txa
	pha
	ldx	#20
	jsr	long_wait
	pla
	tax

	dex
	dex
	bpl	scroll_loop

	ldx	#200
	jsr	long_wait

	jsr	HOME
	bit	KEYRESET

	;======================
	; print end message
	;======================

	lda	#0
	sta	DRAW_PAGE

	lda	#<end_message
	sta	OUTL
	lda	#>end_message
	sta	OUTH

	jsr	move_and_print


	; wait wait wait

	jsr	wait_until_keypressed

	jmp	repeat_ending


; 0123456789012345678901234567890123456789
;        DESIGNED BY ..... ERIC CHAHI
;
;        ARTWORK ......... ERIC CHAHI
;
; MUSIC BY ........ JEAN-FRANCOIS FREITAS
;
;              SOUND EFFECTS
;          JEAN-FRANCOIS FREITAS
;               ERIC CHAHI
;
;              APPLE II PORT
;              VINCE WEAVER
;
;             APPLE ][ FOREVER

credits0:.byte "",0
credits1:.byte "        DESIGNED BY ..... ERIC CHAHI",0
credits2:.byte "",0
credits3:.byte "        ARTWORK ......... ERIC CHAHI",0
credits4:.byte "",0
credits5:.byte " MUSIC BY ........ JEAN-FRANCOIS FREITAS",0
credits6:.byte "",0
credits7:.byte "              SOUND EFFECTS",0
credits8:.byte "          JEAN-FRANCOIS FREITAS",0
credits9:.byte "               ERIC CHAHI",0
credits10:.byte "",0
credits11:.byte "             APPLE II+ PORT",0
credits12:.byte "              VINCE WEAVER",0
credits13:.byte "",0
credits14:.byte "            APPLE ][ FOREVER",0

credit_list:
	.word credits0	; 0
	.word credits0	; 1
	.word credits0	; 2
	.word credits1	; 3
	.word credits2	; 4
	.word credits3	; 5
	.word credits4	; 6
	.word credits5	; 7
	.word credits6	; 8
	.word credits0	; 9
	.word credits7	; 10
	.word credits8	; 11
	.word credits9	; 12
	.word credits10	; 13
	.word credits11	; 14
	.word credits12	; 16
	.word credits0	; 15
	.word credits0	; 18
	.word credits13	; 17
	.word credits14 ; 19
	.word credits0	; 20
	.word credits0	; 21
	.word credits0	; 22

end_message:
.byte 6,10,"NOW GO BACK TO ANOTHER EARTH",0

	;============================
	; set BASL/BASH to offset w Y
gotoy:
	lda	gr_offsets,Y
	sta	BASL
	lda	gr_offsets+1,Y
	sta	BASH
	rts

	;======================
	; wait until keypressed
	;======================
wait_until_keypressed:
	lda	KEYPRESS
	bpl	wait_until_keypressed
	bit	KEYRESET
	rts



        ;=====================
        ; long(er) wait
        ; waits approximately ?? ms

long_wait:
        lda     #100
        jsr     WAIT                    ; delay
        dex
        bne     long_wait
        rts



.include "text_print.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "gr_offsets.s"
.include "gr_overlay.s"

.include "pt3_lib_core.s"
.include "pt3_lib_init.s"
.include "interrupt_handler.s"
.include "pt3_lib_mockingboard.s"

.include "pt3_setup.s"



; backgrounds
.include "ootw_graphics/l15final/ootw_c15_final.inc"
.include "ootw_graphics/l16end/ootw_c16_end.inc"

PT3_LOC = song

; must be page aligned
.align 256
song:
.incbin "ootw_audio/ootw_outro.pt3"





