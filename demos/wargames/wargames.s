;
;  wargames.s
;
; like from the movie

.include "hardware.inc"

VGI_CCOLOR      = P0
VGI_CX          = P1
VGI_CY          = P2
VGI_CR          = P3

NIBCOUNT	= $09
CH		= $24
CV		= $25
BASL		= $27
BASH		= $28

HGR_COLOR	= $E4

DRAW_PAGE	= $FA
OUTL		= $FB
OUTH		= $FC
MISSILE_LOW	= $FD
MISSILE_HIGH	= $FE
FRAME		= $FF

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
MISSILE_RADIUS = 12


.include "ssi263.inc"


wargames:
	;===========================
	;===========================
	; initial message
	;===========================
	;===========================

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

	jsr	HGR

	lda	#<map_lzsa
	sta	getsrc_smc+1
	lda	#>map_lzsa
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast


	lda	#0
	sta	FRAME
missile_loop:

	lda	#<missiles
	sta	MISSILE_LOW
	lda	#>missiles
	sta	MISSILE_HIGH

	ldy	#0
	lda	(MISSILE_LOW),Y

	; see if totally done
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
	cmp	FRAME
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

missile_move:

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
not_match:
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

	cmp	#12
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

	lda	#50
	jsr	WAIT

	inc	FRAME
	beq	done_missiles

	jmp	missile_loop

done_missiles:

	;============================
	; print WINNER: NONE

	jsr	move_and_print

	jsr	wait_1s


	;=========================================
	; print flashing code

	jsr	HOME

	bit	SET_TEXT

	jsr	flash_text

	jsr	move_and_print

	jsr	wait_1s

	jsr	normal_text

	;=========================================
	; final message

	jsr	HOME


	lda	#4			; assume slot #4 for now
	jsr	detect_ssi263

	lda	#4			; assume slot #4 for now
	jsr	ssi263_speech_init


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

wait1:
	lda	speech_busy
	bne	wait1

	jsr	wait_1s

	; strange

	lda	#<strange
	sta	SPEECH_PTRL
	lda	#>strange
	sta	SPEECH_PTRH

	jsr	ssi263_speak

	jsr	move_and_print

wait2:
	lda	speech_busy
	bne	wait2

	jsr	wait_1s

	; winning

	lda	#<winning
	sta	SPEECH_PTRL
	lda	#>winning
	sta	SPEECH_PTRH

	jsr	ssi263_speak

	jsr	move_and_print
	jsr	move_and_print

wait3:
	lda	speech_busy
	bne	wait3

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





missiles:
	.byte $00	; status
	.byte $10	; start frame
	.byte 10,$10	; x-location
	.byte 50,$10	; y-location
	.byte $01,$00	; deltax
	.byte $00,$00	; deltay
	.byte 100,50	; destination
	.byte $00	; radius
	.byte $00,$00,$00	; padding

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
