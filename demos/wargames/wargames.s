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

HGR_COLOR	= $E4

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

	cmp	#15
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

	;=========================================

	jsr	HOME

	lda	#4			; assume slot #4 for now
	jsr	detect_ssi263

	lda	irq_count
	clc
	adc	#'A'			; hack to show if detected or not
	sta	$400			; (B is detected, A is not)

	lda	#4			; assume slot #4 for now
	jsr	ssi263_speech_init


speech_loop:

	; trogdor

	lda	#<trogdor
	sta	SPEECH_PTRL
	lda	#>trogdor
	sta	SPEECH_PTRH

	jsr	ssi263_speak

	jsr	wait_until_keypress

	jmp	speech_loop

wait_until_keypress:

	lda	KEYPRESS
	bpl	wait_until_keypress

	bit	KEYRESET

	rts


.include "ssi263_detect.s"

.include "ssi263_simple_speech.s"

.include "decompress_fast_v2.s"

.include "circles.s"

	; the document
	; "Phonetic Speech Dictionary for the SC-01 Speech Synthesizer"
	; sc01-dictionary.pdf
	; was very helpful here

trogdor:
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

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

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

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

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
	.byte "STRATEGY:                WINNER:",0
	.byte "USSR FIRST STRIKE",0
	.byte "U.S. FIRST STRIKE",0
	.byte "NATO / WARSAW PACT",0
	.byte "FAR EAST STRATEGY",0


ending:
	.byte "GREETINGS PROFESSOR FALKEN",0
	.byte "A STRANGE GAME",0
	.byte "THE ONLY WINNING MOVE IS"
	.byte "NOT TO PLAY.",0


code:
	.byte "CPE1704TKS",0




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

