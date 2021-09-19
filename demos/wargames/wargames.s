;
;  wargames.s
;
; like from the movie

.include "hardware.inc"

FRAME_ADD	= $40
EXPLOSION_RADIUS= 10

VGI_CCOLOR      = P0
VGI_CX          = P1
VGI_CY          = P2
VGI_CR          = P3

SSI_FOUND	= $08
NIBCOUNT	= $09
CH		= $24
CV		= $25
BASL		= $27
BASH		= $28

HGR_COLOR	= $E4

FRAMEL		= $F8
FRAMEH		= $F9
CURRENT_MISSILE = $FA
DRAW_PAGE	= $FB
OUTL		= $FC
OUTH		= $FD
MISSILE_LOW	= $FE
MISSILE_HIGH	= $FF


STATUS_WAITING		= $00
STATUS_MOVING		= $01
STATUS_EXPLODING	= $02
STATUS_DONE		= $FF

MISSILE_STATUS = 0
MISSILE_START_FRAME = 1
MISSILE_X = 2
MISSILE_X_FRAC = 3
MISSILE_Y = 4
MISSILE_Y_FRAC = 5
MISSILE_DX_H = 6
MISSILE_DX_L = 7
MISSILE_DY_H = 8
MISSILE_DY_L = 9
MISSILE_DEST_X = 10
MISSILE_DEST_Y = 11
MISSILE_RADIUS = 11

MISSILE_P_DY_H = 6
MISSILE_P_DY_L = 7
MISSILE_P_DDY_H = 8
MISSILE_P_DDY_L = 9


.include "ssi263.inc"


wargames:
	;===========================
	;===========================
	; initial message
	;===========================
	;===========================

;	jmp	exchange	; debug

	lda	#0
	sta	DRAW_PAGE

	jsr	HOME

	lda	#<header
	sta	OUTL
	lda	#>header
	sta	OUTH

	jsr	normal_text

	jsr	move_and_print
	jsr	move_and_print

	; USSR FIRST STRIKE

	jsr	next_step

	; US FIRST STRIKE

	jsr	next_step

	; NATO / WARSAW PACT

	jsr	next_step

	; FAR EAST STRATEGY

	jsr	move_and_print

	jsr	wait_1s

	;===========================
	;===========================
	; exchange
	;===========================
	;===========================
exchange:
	jsr	HGR

	lda	#<map_lzsa
	sta	getsrc_smc+1
	lda	#>map_lzsa
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast


	lda	#0
	sta	FRAMEL
	sta	FRAMEH

	jsr	move_and_print

outer_missile_loop:

	lda	#<missiles
	sta	MISSILE_LOW
	lda	#>missiles
	sta	MISSILE_HIGH

inner_missile_loop:

	ldy	#MISSILE_STATUS
	lda	(MISSILE_LOW),Y

	cmp	#$FE			; means all done
	bne	more_missiles
	jmp	really_done_missile

more_missiles:
	; see if totally done
	lda	(MISSILE_LOW),Y
	bpl	keep_going
	jmp	done_missile_loop
keep_going:
	cmp	#1
	beq	missile_ready
	cmp	#2
	beq	missile_explode

	; else 0, see if match

	ldy	#MISSILE_START_FRAME
	lda	(MISSILE_LOW),Y
	cmp	FRAMEH
	beq	missile_activate
	jmp	done_missile_loop		; not ready

missile_activate:

	; make it ready
	lda	#STATUS_MOVING
	ldy	#MISSILE_STATUS
	sta	(MISSILE_LOW),Y


missile_ready:

missile_draw:

	ldy	#MISSILE_X
	lda	(MISSILE_LOW),Y
	tax

	ldy	#MISSILE_Y
	lda	(MISSILE_LOW),Y

	ldy	#0

	jsr	HPLOT0		; plot at (Y,X), (A)

	ldy	#MISSILE_DEST_Y
	lda	(MISSILE_LOW),Y
	cmp	#$FF
	beq	a_parab

	jsr	missile_move_line
	jmp	done_missile_loop

a_parab:
	jsr	missile_move_parab
	jmp	done_missile_loop

missile_explode:

	lda	#7
	sta	VGI_CCOLOR

	ldy	#MISSILE_RADIUS
	lda	(MISSILE_LOW),Y
	clc
	adc	#1
	sta	(MISSILE_LOW),Y

	sta	VGI_CR

	cmp	#EXPLOSION_RADIUS
	bcc	not_done_explosion

	lda	#STATUS_DONE
	ldy	#MISSILE_STATUS
	sta	(MISSILE_LOW),Y

not_done_explosion:


	ldy	#MISSILE_X
	lda	(MISSILE_LOW),Y
	sta	VGI_CX

	ldy	#MISSILE_Y
	lda	(MISSILE_LOW),Y
	sta	VGI_CY

	jsr	vgi_filled_circle


done_missile_loop:
	clc
	lda	MISSILE_LOW
	adc	#12
	sta	MISSILE_LOW
	lda	#0
	adc	MISSILE_HIGH
	sta	MISSILE_HIGH

	jmp	inner_missile_loop

really_done_missile:
	lda	#50
	jsr	WAIT

	clc
	lda	FRAMEL
	adc	#FRAME_ADD
	sta	FRAMEL
	lda	FRAMEH
	adc	#0
	sta	FRAMEH

	cmp	#$90
	bcs	done_missiles

	jmp	outer_missile_loop

done_missiles:

	;============================
	; print WINNER: NONE

	jsr	HOME

	jsr	move_and_print

	jsr	wait_1s
	jsr	wait_1s


	;=========================================
	; print flashing code

	jsr	HOME

	bit	SET_TEXT

	jsr	flash_text

	jsr	move_and_print

	jsr	wait_1s
	jsr	wait_1s

	jsr	normal_text

	;=========================================
	; final message

	jsr	HOME

	lda	#0
	sta	SSI_FOUND


	lda	#4			; assume slot #4 for now
	jsr	detect_ssi263
	bcc	no_ssi

	lda	#1
	sta	SSI_FOUND

	lda	#4			; assume slot #4 for now
	jsr	ssi263_speech_init

no_ssi:

speech_loop:

	; greetings

	; adjust text speed
	lda	#150
	sta	delay_smc+1

	lda	#<greetings
	sta	SPEECH_PTRL
	lda	#>greetings
	sta	SPEECH_PTRH

	jsr	ssi263_speak

	jsr	move_and_print

	; wait for it to complete
	jsr	wait_for_ssi_done

	jsr	wait_1s

	; strange

	lda	#<strange
	sta	SPEECH_PTRL
	lda	#>strange
	sta	SPEECH_PTRH

	jsr	ssi263_speak

	jsr	move_and_print

	jsr	wait_for_ssi_done

	jsr	wait_1s

	; winning

	lda	#<winning
	sta	SPEECH_PTRL
	lda	#>winning
	sta	SPEECH_PTRH

	jsr	ssi263_speak

	jsr	move_and_print
	jsr	move_and_print

	jsr	wait_for_ssi_done

	bit	KEYRESET

	jsr	wait_until_keypress

	; restore text delay to 0

	lda	#0
	sta	delay_smc+1

	jmp	wargames


	;======================
	; wait until keypress
	;======================
wait_until_keypress:

	lda	KEYPRESS
	bpl	wait_until_keypress

	bit	KEYRESET

	rts


.include "ssi263_detect.s"

.include "ssi263_simple_speech.s"

.include "decompress_fast_v2.s"

.include "circles.s"

.include "text_print.s"
.include "gr_offsets.s"

	; the document
	; "Phonetic Speech Dictionary for the SC-01 Speech Synthesizer"
	; sc01-dictionary.pdf
	; was very helpful here

greetings:
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_KV	; KV	; Greetings
	.byte PHONEME_R		; R
;	.byte PHONEME_E1	; E1
	.byte PHONEME_Y		; Y
	.byte PHONEME_T		; T
	.byte PHONEME_I		; I
	.byte PHONEME_NG	; NG
	.byte PHONEME_Z		; Z

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_P		; P	; Professor
	.byte PHONEME_R		; R
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_F		; F
	.byte PHONEME_EH1	; EH1
;	.byte PHONEME_EH1	; EH1
	.byte PHONEME_S		; S
	.byte PHONEME_O		; O
;	.byte PHONEME_O		; O
	.byte PHONEME_R		; R

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_F		; F	; Falken
	.byte PHONEME_AW	; AW
	.byte PHONEME_L		; L
	.byte PHONEME_K		; K
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_N		; N

	.byte $FF

strange:

	; A strange game.

;	.byte PHONEME_A1	; A1	; A
	.byte PHONEME_AY	; AY
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_S		; S	; strange
	.byte PHONEME_T		; T
	.byte PHONEME_R		; R
;	.byte PHONEME_A1	; A1
	.byte PHONEME_AY	; AY
	.byte PHONEME_Y		; Y
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_J		; J
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_KV	; G	; game
;	.byte PHONEME_A1	; A1
	.byte PHONEME_AY	; AY
	.byte PHONEME_Y		; Y
	.byte PHONEME_M		; M
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte $FF

winning:
	; The only winning move is not to play.

	.byte PHONEME_THV	; THV	; The
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_OU	; O1	; Only
;	.byte PHONEME_O2	; O2
	.byte PHONEME_N		; N
	.byte PHONEME_L		; L
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_W		; W	; Winning
	.byte PHONEME_I		; I1
;	.byte PHONEME_I3	; I3
	.byte PHONEME_N		; N
	.byte PHONEME_N		; N
	.byte PHONEME_I		; I
	.byte PHONEME_NG	; NG
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_W		; M	; Move
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_V		; V
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_I		; I1	; Is
;	.byte PHONEME_I3	; I3
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_N		; N	; Not
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_T		; T	; To
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_P		; P	; Play
	.byte PHONEME_L		; L
	.byte PHONEME_A		; A1
	.byte PHONEME_I		; I3
	.byte PHONEME_Y		; Y

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte $FF


map_lzsa:
	.incbin "map.lzsa"


header:
	.byte 0,0,"STRATEGY:",0
	.byte 24,0,"WINNER:",0
	.byte 0,1,"USSR FIRST STRIKE",0
	.byte 27,1,"NONE",0
	.byte 0,2,"U.S. FIRST STRIKE",0
	.byte 27,2,"NONE",0
	.byte 0,3,"NATO / WARSAW PACT",0
	.byte 27,3,"NONE",0
	.byte 0,4,"FAR EAST STRATEGY",0

far_east:
	.byte 11,21,"FAR EAST STRATEGY",0

winner:
	.byte 14,21,"WINNER: NONE",0

code:
	.byte 15,21,"CPE1704TKS",0

ending:
	.byte 0,0,"GREETINGS PROFESSOR FALKEN",0
	.byte 0,10,"A STRANGE GAME",0
	.byte 0,11,"THE ONLY WINNING MOVE IS",0
	.byte 0,12,"NOT TO PLAY.",0

;	.byte "HOW ABOUT A NICE GAME OF CHESS",0


	;===================
	; next step
	;===================
next_step:
	jsr	move_and_print

	jsr	wait_1s

	jsr	move_and_print

	jsr	wait_1s

	rts

	;==================
	; wait 1s
	;==================
wait_1s:
	ldx	#10

wait_1s_loop:
	lda	#200
	jsr	WAIT

	dex
	bne	wait_1s_loop

	rts

	;============================
	; missile move line
	;============================

missile_move_line:

	; add X
	clc
	ldy	#MISSILE_DX_L
	lda	(MISSILE_LOW),Y
	ldy	#MISSILE_X_FRAC
	adc	(MISSILE_LOW),Y
	sta	(MISSILE_LOW),Y

	ldy	#MISSILE_DX_H
	lda	(MISSILE_LOW),Y
	ldy	#MISSILE_X
	adc	(MISSILE_LOW),Y
	sta	(MISSILE_LOW),Y

	; add Y
	clc
	ldy	#MISSILE_DY_L
	lda	(MISSILE_LOW),Y
	ldy	#MISSILE_Y_FRAC
	adc	(MISSILE_LOW),Y
	sta	(MISSILE_LOW),Y

	ldy	#MISSILE_DY_H
	lda	(MISSILE_LOW),Y
	ldy	#MISSILE_Y
	adc	(MISSILE_LOW),Y
	sta	(MISSILE_LOW),Y


	; see if at end
	ldy	#MISSILE_Y
	lda	(MISSILE_LOW),Y
	ldy	#MISSILE_DEST_Y
	cmp	(MISSILE_LOW),Y
	bne	not_match

	ldy	#MISSILE_X
	lda	(MISSILE_LOW),Y
	ldy	#MISSILE_DEST_X
	cmp	(MISSILE_LOW),Y
	bne	not_match

is_match:
	lda	#STATUS_EXPLODING
	ldy	#MISSILE_STATUS
	sta	(MISSILE_LOW),Y

	lda	#0
	ldy	#MISSILE_RADIUS
	sta	(MISSILE_LOW),Y
not_match:
	rts



	;============================
	; missile move parabola
	;============================

missile_move_parab:

	; add X
	clc
	ldy	#MISSILE_X_FRAC
	lda	(MISSILE_LOW),Y
	ldy	#MISSILE_X
	adc	(MISSILE_LOW),Y
	sta	(MISSILE_LOW),Y

	; add Y
	clc
	ldy	#MISSILE_P_DY_L
	lda	(MISSILE_LOW),Y
	ldy	#MISSILE_Y_FRAC
	adc	(MISSILE_LOW),Y
	sta	(MISSILE_LOW),Y

	ldy	#MISSILE_P_DY_H
	lda	(MISSILE_LOW),Y
	ldy	#MISSILE_Y
	adc	(MISSILE_LOW),Y
	sta	(MISSILE_LOW),Y

	; add dY
	clc
	ldy	#MISSILE_P_DDY_L
	lda	(MISSILE_LOW),Y
	ldy	#MISSILE_P_DY_L
	adc	(MISSILE_LOW),Y
	sta	(MISSILE_LOW),Y

	ldy	#MISSILE_P_DDY_H
	lda	(MISSILE_LOW),Y
	ldy	#MISSILE_P_DY_H
	adc	(MISSILE_LOW),Y
	sta	(MISSILE_LOW),Y


	; see if at end
	ldy	#MISSILE_X
	lda	(MISSILE_LOW),Y
	ldy	#MISSILE_DEST_X
	cmp	(MISSILE_LOW),Y
	bne	not_parab_match

is_parab_match:
	lda	#STATUS_EXPLODING
	ldy	#MISSILE_STATUS
	sta	(MISSILE_LOW),Y

	lda	#0
	ldy	#MISSILE_RADIUS
	sta	(MISSILE_LOW),Y
not_parab_match:
	rts



	; status frame    x/x    y/y    dx/dx dy/dy destx desty/radius
missiles:

parabolas:
;.byte $00, 4, 164,$00, 75,$00, $FC,$8C, $00,$16, 80,255

.include "coords.inc"

;  status grame x/x     y/y      dy/dy    ddy/ddy destx/desty

wait_for_ssi_done:
	lda	SSI_FOUND
	beq	ssi_no_need
wait1:
	lda	speech_busy
	bne	wait1

ssi_no_need:
	rts
