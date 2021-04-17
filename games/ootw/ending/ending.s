; ootw -- It's the End of the Game as We Know It

; TODO: missing a bunch of frames


; by Vince "Deater" Weaver	<vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"

ending:

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

pickup_sequence:
	.byte   255						; load to bg
	.word	rooftop_bg_lzsa					; this
	.byte	128+20	;	.word	rooftop01_lzsa		; next
	.byte	128+20	;	.word	rooftop02_lzsa		; next
	.byte	128+20	;	.word	rooftop03_lzsa		; next
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
	.byte	128+20	;	.word	rooftop15_lzsa		; next
	.byte	128+20	;	.word	rooftop16_lzsa		; next
	.byte	128+20	;	.word	rooftop17_lzsa		; next
	.byte	128+20	;	.word	rooftop18_lzsa		; next
	.byte	128+20	;	.word	rooftop19_lzsa		; next
	.byte	128+20	;	.word	rooftop20_lzsa		; next
	.byte	128+20	;	.word	rooftop21_lzsa		; next
	.byte	128+20	;	.word	rooftop22_lzsa		; next
	.byte	128+20	;	.word	rooftop23_lzsa		; next
	.byte	128+20	;	.word	rooftop24_lzsa		; next
	.byte	128+20	;	.word	rooftop25_lzsa		; next
	.byte	128+20	;	.word	rooftop26_lzsa		; next
	.byte	128+20	;	.word	rooftop27_lzsa		; next
	.byte	128+20	;	.word	rooftop28_lzsa		; next
	.byte	128+20	;	.word	rooftop29_lzsa		; next
	.byte	0						; finish

wing_sequence:
	.byte   255						; load to bg
	.word	wing_bg_lzsa					;  this
	.byte	128+50	;	.word	left_unfurl1_lzsa	; next
	.byte	128+30	;	.word	left_unfurl2_lzsa	; next
	.byte	128+30	;	.word	left_unfurl3_lzsa	; next
	.byte	128+30	;	.word	left_unfurl4_lzsa	; next
	.byte	128+30	;	.word	left_unfurl5_lzsa	; next
	.byte	128+50	;	.word	right_unfurl1_lzsa	; next
	.byte	128+30	;	.word	right_unfurl2_lzsa	; next
	.byte	128+30	;	.word	right_unfurl3_lzsa	; next
	.byte	128+30	;	.word	right_unfurl4_lzsa	; next
	.byte	128+30	;	.word	right_unfurl5_lzsa	; next
	.byte	128+20	;	.word	onboard01_lzsa		; next
	.byte	128+20	;	.word	onboard02_lzsa		; next
	.byte	128+20	;	.word	onboard03_lzsa		; next
	.byte	128+20	;	.word	onboard04_lzsa		; next
	.byte	128+20	;	.word	onboard05_lzsa		; next
	.byte	128+20	;	.word	onboard06_lzsa		; next
	.byte	128+20	;	.word	onboard07_lzsa		; next
	.byte	128+20	;	.word	onboard08_lzsa		; next
	.byte	0						; finish

flying_sequence:
	.byte   255						; load to bg
	.word	sky_bg_lzsa					;  this
	.byte	128+30	;	.word	flying01_lzsa		; next
	.byte	128+30	;	.word	flying02_lzsa		; next
	.byte	128+30	;	.word	flying03_lzsa		; next
	.byte	128+30	;	.word	flying04_lzsa		; next
	.byte	128+30	;	.word	flying05_lzsa		; next
	.byte	128+30	;	.word	flying06_lzsa		; next
	.byte	128+30	;	.word	flying07_lzsa		; next
	.byte	128+30	;	.word	flying08_lzsa		; next
	.byte	128+30	;	.word	flying09_lzsa		; next
	.byte	128+30	;	.word	flying10_lzsa		; next
	.byte	128+30	;	.word	flying11_lzsa		; next
	.byte	128+30	;	.word	flying12_lzsa		; next
	.byte	128+30	;	.word	flying13_lzsa		; next
	.byte	128+30	;	.word	flying14_lzsa		; next
	.byte	128+30	;	.word	flying15_lzsa		; next
	.byte	128+30	;	.word	flying16_lzsa		; next
	.byte	128+30	;	.word	flying17_lzsa		; next
	.byte	128+30	;	.word	flying18_lzsa		; next
	.byte	128+30	;	.word	flying19_lzsa		; next
	.byte	128+30	;	.word	flying20_lzsa		; next
	.byte	128+30	;	.word	flying21_lzsa		; next
	.byte	128+30	;	.word	flying22_lzsa		; next
	.byte	128+30	;	.word	flying23_lzsa		; next
	.byte	128+30	;	.word	flying24_lzsa		; next
	.byte	128+30	;	.word	flying25_lzsa		; next
	.byte	128+30	;	.word	flying26_lzsa		; next
	.byte	128+30	;	.word	flying27_lzsa		; next
	.byte	128+30	;	.word	flying28_lzsa		; next
	.byte	128+30	;	.word	flying29_lzsa		; next
	.byte	128+30	;	.word	flying30_lzsa		; next
	.byte	128+30	;	.word	flying31_lzsa		; next
	.byte	128+30	;	.word	flying32_lzsa		; next
	.byte	128+30	;	.word	flying33_lzsa		; next
	.byte	128+30	;	.word	flying34_lzsa		; next
	.byte	128+30	;	.word	flying35_lzsa		; next
	.byte	128+30	;	.word	flying36_lzsa		; next
	.byte	128+30	;	.word	flying37_lzsa		; next
	.byte	128+30	;	.word	flying38_lzsa		; next
	.byte	128+30	;	.word	flying39_lzsa		; next
	.byte	128+30	;	.word	flying40_lzsa		; next
	.byte	128+30	;	.word	flying41_lzsa		; next
	.byte	128+30	;	.word	flying42_lzsa		; next
	.byte	128+30	;	.word	flying43_lzsa		; next
	.byte	128+30	;	.word	flying44_lzsa		; next
	.byte	128+30	;	.word	flying45_lzsa		; next
	.byte	128+30	;	.word	flying46_lzsa		; next
	.byte	128+30	;	.word	flying47_lzsa		; next
	.byte	128+30	;	.word	flying48_lzsa		; next
	.byte	128+30	;	.word	flying49_lzsa		; next
	.byte	128+30	;	.word	flying50_lzsa		; next
	.byte	128+30	;	.word	flying51_lzsa		; next
	.byte	128+30	;	.word	flying52_lzsa		; next
	.byte	128+30	;	.word	flying53_lzsa		; next
	.byte	128+30	;	.word	flying54_lzsa		; next
	.byte	128+30	;	.word	flying55_lzsa		; next
	.byte	128+30	;	.word	flying56_lzsa		; next
	.byte	128+30	;	.word	flying57_lzsa		; next
	.byte	128+30	;	.word	flying58_lzsa		; next
	.byte	128+30	;	.word	flying59_lzsa		; next
	.byte	128+30	;	.word	flying60_lzsa		; next
	.byte	128+30	;	.word	flying61_lzsa		; next
	.byte	128+30	;	.word	flying62_lzsa		; next
	.byte	128+30	;	.word	flying63_lzsa		; next
	.byte	128+30	;	.word	flying64_lzsa		; next
	.byte	128+30	;	.word	flying65_lzsa		; next
	.byte	128+50	;	.word	the_end00_lzsa		; next
	.byte	128+50	;	.word	the_end01_lzsa		; next
	.byte	128+50	;	.word	the_end02_lzsa		; next
	.byte	128+50	;	.word	the_end03_lzsa		; next
	.byte	128+50	;	.word	the_end04_lzsa		; next
	.byte	128+50	;	.word	the_end05_lzsa		; next
	.byte	128+50	;	.word	the_end06_lzsa		; next
	.byte	128+50	;	.word	the_end07_lzsa		; next
	.byte	128+120	;	.word	the_end08_lzsa		; next
	.byte	128+50	;	.word	the_end09_lzsa		; next
	.byte	128+50	;	.word	the_end10_lzsa		; next
	.byte	128+50	;	.word	the_end11_lzsa		; next
	.byte	128+50	;	.word	the_end12_lzsa		; next
	.byte	128+50	;	.word	the_end13_lzsa		; next
	.byte	128+50	;	.word	the_end14_lzsa		; next
	.byte	128+50	;	.word	the_end15_lzsa		; next
	.byte	128+50	;	.word	the_end16_lzsa		; next
	.byte	128+50	;	.word	the_end17_lzsa		; next
	.byte	128+120	;	.word	the_end18_lzsa		; next
	.byte	128+50	;	.word	the_end19_lzsa		; next
	.byte	128+50	;	.word	the_end20_lzsa		; next
	.byte	128+50	;	.word	the_end21_lzsa		; next
	.byte	128+50	;	.word	the_end22_lzsa		; next
	.byte	128+50	;	.word	the_end23_lzsa		; next
	.byte	128+50	;	.word	the_end24_lzsa		; next
	.byte	128+50	;	.word	the_end25_lzsa		; next
	.byte	128+50	;	.word	the_end26_lzsa		; next
	.byte	128+50	;	.word	the_end27_lzsa		; next
	.byte	128+120	;	.word	the_end28_lzsa		; next
	.byte	128+50	;	.word	the_end29_lzsa		; next
	.byte	0						; finish


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
