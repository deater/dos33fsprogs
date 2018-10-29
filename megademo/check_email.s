; Display e-mail demo

; 40x96 graphics as well as half-screen text manipulation


check_email:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE
	sta	FRAME
	sta	FRAMEH

init_email_letters:
        lda     #<em_letters
        sta     LETTERL
        lda     #>em_letters
        sta     LETTERH
        lda     #18
        sta     LETTERX
        lda     #4
        sta     LETTERY
        lda     #4
        sta     LETTERD


	;=============================
	; Load graphic page0

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00


	lda	#<email_low
	sta	GBASL
	lda	#>email_low
	sta	GBASH
	jsr	load_rle_gr

	lda	#4
	sta	DRAW_PAGE

	jsr	gr_copy_to_current	; copy to page1

	; GR part
	bit	PAGE1
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	;=============================
	; Load graphic page1

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00

	lda	#<email_high
	sta	GBASL
	lda	#>email_high
	sta	GBASH
	jsr	load_rle_gr

	lda	#0
	sta	DRAW_PAGE

	jsr	gr_copy_to_current

	; GR part
	bit	PAGE0

	; disable interrupt music
	sei

	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	jsr	gr_copy_to_current		; 6+ 9292

	; now we have 322 left

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	; 322 - 12 = 310
	; - 3 for jmp
	; 307

	; Try X=9 Y=6 cycles=307

        ldy	#6							; 2
celoopA:ldx	#9							; 2
celoopB:dex								; 2
	bne	celoopB							; 2nt/3
	dey								; 2
	bne	celoopA							; 2nt/3

	jmp	em_begin_loop
.align  $100


	;================================================
	; Email Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was


	; For this part we want on Apple II/II+
	; On Apple IIe and newer want  T 000/11111
	; because the font is shifted upwards a line

	; T00000000000000000000 G0000000000000000000000
	; T00000000000000000000 G0000000000000000000000
	; T00000000000000000000 G1111111111111111111111
	; T00000000000000000000 G1111111111111111111111
	; T11111111111111111111 G0000000000000000000000
	; T11111111111111111111 G0000000000000000000000
	; T11111111111111111111 G1111111111111111111111
	; T11111111111111111111 G1111111111111111111111

	; 0,1,0,1 0,0,1,1
	; 54,55,54,55  54,54,55,55

em_begin_loop:

em_display_loop:

	ldy	#24
em_outer_loop:

	;== line0
	bit	PAGE0			; 4
	lda	#$54			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6
	;== line1
	bit	PAGE0			; 4
	lda	#$54			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6
	;== line2
	bit	PAGE0			; 4
	lda	#$55			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6
	;== line3
ce_patch:
	bit	PAGE1	;IIe		; 4
;	bit	PAGE0	;II/II+		; 4

	lda	#$55			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6

	;== line4
	bit	PAGE1			; 4
	lda	#$54			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6
	;== line5
	bit	PAGE1			; 4
	lda	#$54			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6
	;== line6
	bit	PAGE1			; 4
	lda	#$55			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6

	;== line7
	bit	PAGE1			; 4
	lda	#$55			; 2
	sta	draw_line_p2+1		; 4
	jsr	draw_line_2		; 6


	dey							; 2
	bne	em_outer_loop					; 3
								; -1


;======================================================
; We have 4550 cycles in the vblank, use them wisely
;======================================================

	; do_nothing should be      4550
	;			      +1 fallthrough from above
	;			     -23 frame count
	;			      -7 timeout
	;			     -10 keypress
	;			      -2 ldy at top
	;			    -132 move letters
	;			   -1038 play_music
	;			===========
	;			    3339

	jsr	play_music	; 6+1032

	; Try X=110 Y=6 cycles=3337 R2

	nop								; 2

	ldy	#6							; 2
emloop1:ldx	#110							; 2
emloop2:dex								; 2
	bne	emloop2							; 2nt/3
	dey								; 2
	bne	emloop1							; 2nt/3


	;=====================
	; Update Frame Counter
	;=====================
	; nowrap = 13+10=23
	;   wrap = 13+10=23
	inc	FRAME							; 5
	lda	FRAME							; 3
	cmp	#60	; 1Hz						; 2
	beq     em_wrap							; 3
em_nowrap:
									;-1
	lda	$0			; nop				; 3
	lda	$0			; nop				; 3
	nop								; 2
	jmp	em_wrap_done						; 3
em_wrap:
	lda	#0							; 2
	sta	FRAME							; 3
	inc	FRAMEH							; 5
em_wrap_done:

	;=========================
	; timeout after 20s or so?
	;=========================
	; 7 cycles
em_timeout:
	lda	FRAMEH							; 3
	cmp	#27							; 2
	beq	em_done							; 3
									; -1


	;==================
	; move letters
	;==================

	jsr	move_letters				; 6+126

	;==================
	; check keys
	;==================

	lda	KEYPRESS				; 4
	bpl	em_no_keypress				; 3
	jmp	em_done
em_no_keypress:

	jmp	em_display_loop				; 3

em_done:
	bit	KEYRESET	; clear keypress	; 4
	cli			; enable interrupt music
	rts						; 6



	;======================
	; Draw split line
	; with no room for rec/jump at end

draw_line_1:	; line0

	; come in with 16
	lda	$0
	bit	SET_TEXT					; 4

	nop							; 2
	nop							; 2
	nop							; 2
	nop							; 2
	nop							; 2

							;==============
							;	33


	nop
	nop

	bit	SET_GR						; 4
draw_line_p1:
	bit	PAGE0						; 4



	lda	$0
	lda	$0
	lda	$0
	lda	$0

;	nop
;	nop
	nop
	rts

							;==============
							;	32


	;======================
	; Draw split line
	; with room for 5 cycles of dec/jump at end

draw_line_2:	; line0

	; come in with 16
	lda	$0						; 3

	bit	SET_TEXT					; 4
	nop							; 2
	nop							; 2
	nop							; 2
	nop							; 2
	nop							; 2

	nop
	nop

							;==============
							;	33

	bit	SET_GR						; 4
draw_line_p2:
	bit	PAGE0						; 4
	lda	$0
	lda	$0
	lda	$0
;	lda	$0
;	nop
;	nop
;	nop
;	lda	$0
;	lda	$0
	rts
							;==============
							;	32


em_letters:
	; note it is y,x
;       .byte	4,4,
	.byte	        "RE: VISIT",128		; RE: VISIT
	.byte	4+128,4,"RE: VISIT",128

	.byte	6,4,	"DA LA , K MML",128	; DEATER, KOMMT
	.byte	6+128,4,"DE&FEF, K8MMF",128

	.byte	7,4,    " L !J, ICL",128	; BALD, ICH
	.byte	7+128,4," 8&I8, ICH",128

	.byte	8,4,    " A M SSA J CL",128	; VERMISSE DICH.
	.byte	8+128,4,"VEFMISSE 8ICH.",128

	.byte	10,4,    "  F  GGYS A",128
	.byte	10+128,4,"  FF8GGYSUE",128	; FROGGYSUE

	.byte	13,10,          "  /I",128
	.byte	13+128,10,      "  /Y",128
	.byte	14,10,          " /_I",128
	.byte	14+128,4,"  __ __/_Y", 128
	.byte	15,4,    " /__]    I/",128
	.byte	15+128,4," /__]    Y/",128
	.byte	16,4,    "/_____   I\",128
	.byte	16+128,4,"/_____EEEE\"
	.byte	255


.if 0
em_letters:
	; note it is y,x
;       .byte	4,4,
	.byte	        "RE: VISIT",128		; RE: VISIT
	.byte	4+128,4,"RE: VISIT",198

	.byte	6,4,	"DA LA ",128		; DEATER
	.byte	6+128,4,"DE&FEF",198

	.byte	7,4,    " K MML L !J,",128	; KOMMT BALD,
	.byte	7+128,4," K8MMF 8&I8,",128

	.byte	8,4,    "ICL  A M SSA",128	; ICH VERMISSE
	.byte	8+128,4,"ICH VEFMISSE",128

	.byte	9,4,    "J CL.",128
	.byte	9+128,4,"8ICH.",128		; DICH.

	.byte	11,4,    "  F  GGYS A",128
	.byte	11+128,4,"  FF8GGYSUE",128	; FROGGYSUE

	.byte	13,10,          "  /I",128
	.byte	13+128,10,      "  /Y",128
	.byte	14,4,    "  __ __/_I",128
	.byte	14+128,4,"  __ __/_Y",128
	.byte	15,4,    " /__]    I/",128
	.byte	15+128,4," /__]    Y/",128
	.byte	16,4,    "/_____   I\",128
	.byte	16+128,4,"/_____EEEE\"
	.byte	255


	; note it is y,x
;       .byte	4,4,
;	.byte	        "DA LA ",128	; DEATER
;	.byte	4+128,4,"DE&FEF",198
;
;	.byte	5,4,    " S C  !.",128
;	.byte	5+128,4,"YS C88I.",128
;
;	.byte	7,3,    "W   M",$22,"SSE  J A",128
;	.byte	7+128,3,"WYF MGSSEH 8YE",128
;
;	.byte	8,3,    " A SAS LA KS",128
;	.byte	8+128,3,"FEYSESEHEEKS",128
;
;	.byte	9,3,    "A  !",$22,"SA .",128
;	.byte	9+128,3,"EYHIOSEH.",128

;	.byte	12,4,    "        /I",128
;	.byte	12+128,4,"        /Y",128
;	.byte	13,4,    "  __ __/_I",128
;	.byte	13+128,4,"  __ __/_Y",128
;	.byte	14,4,    " /__]    I/",128
;	.byte	14+128,4," /__]    Y/",128
;	.byte	15,4,    "/_____   I\",128
;	.byte	15+128,4,"/_____EEEE\"
;	.byte	255

.endif
;.include "email_40_96.inc"



