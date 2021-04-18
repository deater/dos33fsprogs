; ootw -- It's the End of the Game as We Know It

; TODO: missing a bunch of frames


; by Vince "Deater" Weaver	<vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"

ending:

	; temporary debug


	lda	#4
	sta	DRAW_PAGE
	lda	#0
	sta	DISP_PAGE
	jmp	handle_credits

	;=========================
	; set up sound
	;=========================
	lda	#0
	sta	DONE_PLAYING

	lda	#1
	sta	LOOP

	; detect mockingboard

	jsr	mockingboard_detect

	bcc	mockingboard_notfound

mockingboard_found:

;	jsr	mockingboard_patch	; patch to work in slots other than 4?

	;=======================
	; Set up 50Hz interrupt
	;========================

	jsr	mockingboard_init
	jsr	mockingboard_setup_interrupt

	;============================
	; Init the Mockingboard
	;============================

	jsr	reset_ay_both
	jsr	clear_ay_both

	;==================
	; init song
	;==================

	jsr	pt3_init_song


	jmp	done_setup_sound

mockingboard_notfound:
	; patch out cli/sei calls

	lda	#$EA
	sta	cli_smc
	sta	sei_smc

done_setup_sound:

repeat_ending:

	;===========================
	; Enable graphics
	;===========================

	bit	LORES
	bit	SET_GR
	bit	FULLGR
	bit	KEYRESET

	;=================================
	; Setup pages (is this necessary?)
	;=================================

;	lda	#0
;	sta	DRAW_PAGE
;	lda	#1
;	sta	DISP_PAGE



	;============
	; start music
	;============

cli_smc:
	cli	; enable interrupts

	;=====================================
	; friend arrive, board dragon sequence
	;=====================================

	lda	#<pickup_sequence
	sta	INTRO_LOOPL
	lda	#>pickup_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	;=========================
	; wing open sequence
	;=========================

	lda	#<wing_sequence
	sta	INTRO_LOOPL
	lda	#>wing_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	;=========================
	; flying sequence
	;=========================

	lda	#<flying_sequence
	sta	INTRO_LOOPL
	lda	#>flying_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	; wait roughly 2 seconds

	ldx	#200
	jsr	long_wait

;===========================
; credits
;===========================

handle_credits:

	;======================
	; scroll credits
	;======================

	jsr	end_credits


	;======================
	; wait before rebooting
	;======================

	; wait wait wait

	jsr	wait_until_keypressed

	; disable music

	jsr	clear_ay_both
sei_smc:
	sei

	; reboot to title

	lda	#$ff			; force cold reboot
	sta	$03F4
	jmp	($FFFC)

;	jmp	repeat_ending


	;======================
	; wait until keypressed
	;======================
wait_until_keypressed:
	lda	KEYPRESS
	bpl	wait_until_keypressed
	bit	KEYRESET
	rts


	;	sequence:	0 = done
	;			255 reload $C00 with PTR
	;			0..127 wait TIME, then overlay $C00 with X
	;			128..254 wait TIME then overlay $C00 with next
	;	note: pauses *before* flipping to new graphic


	; dragon moves its head a bit when we arrive
	; repeats twice pulling self
	; then again but slightly to right
	; two more times
	; friend pops up, pauses a while


	; times are in seconds.frames
	; 1/25th a second in this case, which is 40ms
	;   time length is in 10ms increments (so X=4 per frame)

pickup_sequence:
	.byte   255					; load to bg
	.word	rooftop_bg_lzsa				; this
	.byte	128+20	;	.word	rooftop01_lzsa	; 03.22-04.15
	.byte	128+20	;	.word	rooftop02_lzsa	; 04.15-04.19
	.byte	128+20	;	.word	rooftop03_lzsa	; 04.19-
	.byte	128+20	;	.word	rooftop04_lzsa		; next
	.byte	128+20	;	.word	rooftop05_lzsa		; next
	.byte	128+20	;	.word	rooftop06_lzsa		; next
	.byte	128+20	;	.word	rooftop07_lzsa		; next
	.byte	128+20	;	.word	rooftop08_lzsa		; next
	.byte	128+20	;	.word	rooftop09_lzsa		; next
	.byte	128+20	;	.word	rooftop10_lzsa		; next
	.byte	128+20	;	.word	rooftop11_lzsa		; next
	.byte	128+20	;	.word	rooftop12_lzsa		; next
	.byte	128+20	;	.word	rooftop13_lzsa		; next
	.byte	128+20	;	.word	rooftop14_lzsa		; next
	.byte	128+20	;	.word	rooftop15_lzsa	; 25.13-25.16 (friend arriving)
	.byte	128+20	;	.word	rooftop16_lzsa	; 25.16-25.22
	.byte	128+20	;	.word	rooftop17_lzsa	; 25.22-27.00 (friend stand)
	.byte	128+20	;	.word	rooftop18_lzsa	; 27.00-27.04
	.byte	128+20	;	.word	rooftop19_lzsa	; 27.04-27.09
	.byte	128+20	;	.word	rooftop20_lzsa	; 27.09-27.17
	.byte	128+20	;	.word	rooftop21_lzsa	; 27.17-27.22
	.byte	128+20	;	.word	rooftop22_lzsa	; 27.22-
	.byte	128+20	;	.word	rooftop23_lzsa	; 29.00-      (friend reaching)
	.byte	128+20	;	.word	rooftop24_lzsa	; 29.11-
	.byte	128+20	;	.word	rooftop25_lzsa	; 29.17-	(mouth open)
	.byte	128+20	;	.word	rooftop26_lzsa	; 30.03-	(mouth closed)
	.byte	128+20	;	.word	rooftop27_lzsa	; 30.14-	(start to pick up)
	.byte	128+20	;	.word	rooftop28_lzsa	; 30.22-	(halfway up)
	.byte	128+20	;	.word	rooftop29_lzsa	; 31.00-	(standing)
	.byte	0					; 31.06		finish

wing_sequence:
	.byte   255						; load to bg
	.word	wing_bg_lzsa					;  this
	.byte	128+50	;	.word	left_unfurl1_lzsa	; 31.06 (14)
	.byte	128+11	;	.word	left_unfurl2_lzsa	; 31.20 (3)
	.byte	128+11	;	.word	left_unfurl3_lzsa	; 31.23 (3)
	.byte	128+11	;	.word	left_unfurl4_lzsa	; 32.01 (2)
	.byte	128+100	;	.word	left_unfurl5_lzsa	; 32.03 (27)
	.byte	128+11	;	.word	right_unfurl1_lzsa	; 33.01 (3)
	.byte	128+11	;	.word	right_unfurl2_lzsa	; 33.04 (2)
	.byte	128+11	;	.word	right_unfurl3_lzsa	; 33.06 (3)
	.byte	128+11	;	.word	right_unfurl4_lzsa	; 33.09 (3)
	.byte	128+100	;	.word	right_unfurl5_lzsa	; 33.12 (27)
	.byte	128+11	;	.word	onboard01_lzsa		; 34.15 (3)
	.byte	128+11	;	.word	onboard02_lzsa		; 34.18 (3)
	.byte	128+11	;	.word	onboard03_lzsa		; 34.21 (3)
	.byte	128+11	;	.word	onboard04_lzsa		; 34.24 (3)
	.byte	128+11	;	.word	onboard05_lzsa		; 35.01 (2)
	.byte	128+11	;	.word	onboard06_lzsa		; 35.04 (3)
	.byte	128+11	;	.word	onboard07_lzsa		; 35.07 (3)
	.byte	128+11	;	.word	onboard08_lzsa		; 35.10 (2)
	.byte	0						; 35.12-

flying_sequence:
	.byte   255						; load to bg
	.word	sky_bg_lzsa					;  this
	.byte	128+11	;	.word	flying01_lzsa		; 35.12 (3)
	.byte	128+11	;	.word	flying02_lzsa		; 35.15 (3)
	.byte	128+11	;	.word	flying03_lzsa		; 35.18 (3)
	.byte	128+11	;	.word	flying04_lzsa		; 35.21 (3)
	.byte	128+11	;	.word	flying05_lzsa		; 35.24 (2)
	.byte	128+11	;	.word	flying06_lzsa		; 36.01 (3)
	.byte	128+11	;	.word	flying07_lzsa		; 36.04 (3)
	.byte	128+11	;	.word	flying08_lzsa		; 36.07 (3)
	.byte	128+11	;	.word	flying09_lzsa		; 36.10 (3)
	.byte	128+11	;	.word	flying10_lzsa		; 36.13 (2)
	.byte	128+11	;	.word	flying11_lzsa		; 36.15 (3)
	.byte	128+11	;	.word	flying12_lzsa		; 36.18 (3)
	.byte	128+11	;	.word	flying13_lzsa		; 36.21 (3)
	.byte	128+11	;	.word	flying14_lzsa		; 36.24 (3)
	.byte	128+11	;	.word	flying15_lzsa		; 37.02 (2)
	.byte	128+11	;	.word	flying16_lzsa		; 37.04 (3)
	.byte	128+11	;	.word	flying17_lzsa		; 37.07 (3)
	.byte	128+11	;	.word	flying18_lzsa		; 37.10 (3)
	.byte	128+11	;	.word	flying19_lzsa		; 37.13 (3)
	.byte	128+11	;	.word	flying20_lzsa		; 37.16 (2)
	.byte	128+11	;	.word	flying21_lzsa		; 37.18 (3)
	.byte	128+11	;	.word	flying22_lzsa		; 37.21 (3)
	.byte	128+11	;	.word	flying23_lzsa		; 37.24 (3)
	.byte	128+11	;	.word	flying24_lzsa		; 38.02 (3)
	.byte	128+11	;	.word	flying25_lzsa		; 38.05 (2)
	.byte	128+11	;	.word	flying26_lzsa		; 38.07 (3)
	.byte	128+11	;	.word	flying27_lzsa		; 38.10 (3)
	.byte	128+11	;	.word	flying28_lzsa		; 38.13 (3)
	.byte	128+11	;	.word	flying29_lzsa		; 38.16 (3)
	.byte	128+11	;	.word	flying30_lzsa		; 38.19 (2)
	.byte	128+11	;	.word	flying31_lzsa		; 38.21 (3)
	.byte	128+11	;	.word	flying32_lzsa		; 38.24 (3)
	.byte	128+11	;	.word	flying33_lzsa		; 39.02 (3)
	.byte	128+11	;	.word	flying34_lzsa		; 39.05 (3)
	.byte	128+11	;	.word	flying35_lzsa		; 39.08 (2)
	.byte	128+11	;	.word	flying36_lzsa		; 39.10 (3)
	.byte	128+11	;	.word	flying37_lzsa		; 39.13 (3)
	.byte	128+11	;	.word	flying38_lzsa		; 39.16 (3)
	.byte	128+11	;	.word	flying39_lzsa		; 39.19 (3)
	.byte	128+11	;	.word	flying40_lzsa		; 39.22 (2)
	.byte	128+11	;	.word	flying41_lzsa		; 39.24 (3)
	.byte	128+11	;	.word	flying42_lzsa		; 40.02 (3)
	.byte	128+11	;	.word	flying43_lzsa		; 40.05 (3)
	.byte	128+11	;	.word	flying44_lzsa		; 40.08 (3)
	.byte	128+11	;	.word	flying45_lzsa		; 40.11 (2)
	.byte	128+11	;	.word	flying46_lzsa		; 40.13 (3)
	.byte	128+11	;	.word	flying47_lzsa		; 40.16 (3)
	.byte	128+11	;	.word	flying48_lzsa		; 40.19 (3)
	.byte	128+11	;	.word	flying49_lzsa		; 40.22 (2)
	.byte	128+11	;	.word	flying50_lzsa		; 40.24 (3)
	.byte	128+11	;	.word	flying51_lzsa		; 41.02 (3)
	.byte	128+11	;	.word	flying52_lzsa		; 41.05 (3)
	.byte	128+11	;	.word	flying53_lzsa		; 41.08 (3)
	.byte	128+11	;	.word	flying54_lzsa		; 41.11 (3)
	.byte	128+11	;	.word	flying55_lzsa		; 41.14 (2)
	.byte	128+11	;	.word	flying56_lzsa		; 41.16 (3)
	.byte	128+11	;	.word	flying57_lzsa		; 41.19 (3)
	.byte	128+11	;	.word	flying58_lzsa		; 41.22 (3)
	.byte	128+11	;	.word	flying59_lzsa		; 42.00 (3)
	.byte	128+11	;	.word	flying60_lzsa		; 42.03 (2)
	.byte	128+11	;	.word	flying61_lzsa		; 42.05 (3)
	.byte	128+11	;	.word	flying62_lzsa		; 42.08 (3)
	.byte	128+11	;	.word	flying63_lzsa		; 42.11 (3)
	.byte	128+11	;	.word	flying64_lzsa		; 42.14 (2)
	.byte	128+11	;	.word	flying65_lzsa		; 42.16 (3)
	.byte	128+11	;	.word	the_end00_lzsa		; 42.19 (3)
	.byte	128+11	;	.word	the_end01_lzsa		; 42.22 (3)
	.byte	128+11	;	.word	the_end02_lzsa		; 43.00 (3)
	.byte	128+11	;	.word	the_end03_lzsa		; 43.03 (2)
	.byte	128+11	;	.word	the_end04_lzsa		; 43.05 (3)
	.byte	128+11	;	.word	the_end05_lzsa		; 43.08 (3)
	.byte	128+11	;	.word	the_end06_lzsa		; 43.11 (3)
	.byte	128+11	;	.word	the_end07_lzsa		; 43.14 (3)
	.byte	128+11	;	.word	the_end08_lzsa		; 43.17 (3)
	.byte	128+11	;	.word	the_end09_lzsa		; 43.20 (2)
	.byte	128+11	;	.word	the_end10_lzsa		; 43.22 (3)
	.byte	128+11	;	.word	the_end11_lzsa		; 44.00 (3)
	.byte	128+11	;	.word	the_end12_lzsa		; 44.03 (3)
	.byte	128+11	;	.word	the_end13_lzsa		; 44.06 (3)
	.byte	128+11	;	.word	the_end14_lzsa		; 44.09 (2)
	.byte	128+11	;	.word	the_end15_lzsa		; 44.11 (3)
	.byte	128+11	;	.word	the_end16_lzsa		; 44.14 (3)
	.byte	128+11	;	.word	the_end17_lzsa		; 44.17 (3)
	.byte	128+20	;	.word	the_end18_lzsa		; 44.23 (5) up
	.byte	128+44	;	.word	the_end19_lzsa		; 45.03 (11)wayup
	.byte	128+44	;	.word	the_end20_lzsa		; 45.14 (11)side
	.byte	128+52	;	.word	the_end21_lzsa		; 46.00 (13)down
	.byte	40
	.word	the_end20_lzsa					; 46.13 (10)side
	.byte	16
	.word	the_end18_lzsa					; 46.23 (4)up
	.byte	128+40	;	.word the_end19_lzsa		; 47.02 (10)wayup
	.byte	128+44	;	.word the_end20_lzsa		; 47.12 (11)side
	.byte	128+48	;	.word the_end21_lzsa		; 47.23 (12)down
	.byte	40
	.word	the_end20_lzsa					; 48.10 (10)side
	.byte	16
	.word	the_end18_lzsa					; 48.20 (4)up
	.byte	128+64	;	.word the_end_19_lzsa		; 48.24 (16)wayup
	.byte	128+24	;	.word the_end_20_lzsa		; 49.15 (6)side
	.byte	128+48	;	.word the_end_21_lzsa		; 49.21 (12)down
	.byte	8
	.word	the_end20_lzsa					; 50.08 (2)side
	.byte	12
	.word	the_end22_lzsa					; 50.10 (3)moving again
	.byte	128+11	;	.word	the_end23_lzsa		; 50.13 (2)
	.byte	128+11	;	.word	the_end24_lzsa		; 50.15 (3)
	.byte	128+11	;	.word	the_end25_lzsa		; 50.18 (3)
	.byte	128+11	;	.word	the_end26_lzsa		; 50.21 (3)
	.byte	128+11	;	.word	the_end27_lzsa		; 50.24 (3)dark
	.byte	128+11	;	.word	the_end28_lzsa		; 51.02 (2)
	.byte	128+11	;	.word	the_end29_lzsa		; 51.04 (3)
	.byte	128+11	;	.word	black_lzsa		; 51.07 black
	.byte	0						; 53.00 credits


.include "credits.s"


.include "../text_print.s"
.include "../gr_pageflip.s"
.include "../decompress_fast_v2.s"
.include "../gr_fast_clear.s"
.include "../gr_copy.s"
.include "../gr_offsets.s"
.include "../gr_overlay.s"
.include "../gr_run_sequence2.s"

.include "../pt3_player/pt3_lib_core.s"
.include "../pt3_player/pt3_lib_init.s"
.include "../pt3_player/interrupt_handler.s"
.include "../pt3_player/pt3_lib_mockingboard_detect.s"
.include "../pt3_player/pt3_lib_mockingboard_setup.s"

; backgrounds
.include "graphics/ending/ootw_c16_end.inc"

PT3_LOC = song

; must be page aligned
.align 256
song:
.incbin "music/ootw_outro.pt3"
