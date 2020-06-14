
; zero page locations
HGR_SHAPE	=	$1A
SEEDL		=	$4E
FRAME		=	$A4
RND_EXP		=	$C9
HGR_PAGE	=	$E6
HGR_SCALE	=	$E7
HGR_ROTATION	=	$F9
SCALE		=	$FC
XPOS		=	$FD
XPOSH		=	$FE
YPOS		=	$FF

; soft switches
; Soft Switches
KEYPRESS	=	$C000
KEYRESET	=	$C010
SPEAKER		=	$C030
PAGE0           =       $C054
PAGE1           =       $C055

; ROM calls
RND		=	$EFAE
HGR2		=	$F3D8
HCLR		=	$F3F2
HCLR_COLOR	=	$F3F4
HPOSN		=	$F411
XDRAW0		=	$F65D
WAIT		=	$FCA8	; delay 1/2(26+27A+5A^2) us

dsr_demo:

	;=========================================
	; SETUP
	;=========================================


	lda	#$20		; clear HGR page0 to white
	sta	HGR_PAGE

	lda	#$ff
	jsr	HCLR_COLOR

	jsr	HGR2		; clear HGR page1 to black
				; Hi-res graphics, no text at bottom
				; Y=0, A=$60 after this call

	ldx	#1
	stx	HGR_SCALE

	ldx	#30
	stx	XPOS
	lda	#0
	sta	XPOSH
	sta	FRAME
	lda	#180
	sta	YPOS

crowd_loop:

	jsr	xdraw		; draw

	lsr	HGR_PAGE	; $40 -> $20

	jsr	xdraw		; draw

	asl	HGR_PAGE	; $20 -> $40

	clc
	lda	XPOS
	adc	#20
	sta	XPOS
	cmp	#250
	bne	crowd_loop

	; get ready for DSR loop

	ldx	#<shape_dsr	; point to our shape
	stx	shape_smc+1


	;=========================================
	; OFFSCREEN RESET
	;=========================================


reset_loop:
	lda	#10
	sta	XPOS
	sta	YPOS

	lda	#2
	sta	HGR_SCALE

	;=========================================
	; MAIN LOOP
	;=========================================

main_loop:

	; increment FRAME

	inc	FRAME
	lda	FRAME

	and	#$f
	beq	long_frame

	jsr	draw_beep

done_frame:

	inc	rot_smc+1

	;========================
	; move dSr
	;========================

	lda	YPOS
	adc	#2
	sta	YPOS

	lda	XPOS
	adc	#5
	sta	XPOS
	cmp	#250
	bcs	reset_loop
	bcc	main_loop


	;===========================
	; long frame
	;===========================

long_frame:

	bit	PAGE0
	lsr	HGR_PAGE

	asl	HGR_SCALE

	ldy	#235
	sty	tone_smc+1

	jsr	draw_beep

	asl	HGR_PAGE
	lsr	HGR_SCALE

	bit	PAGE1

	jmp	done_frame


xdraw:
	ldy	XPOSH		; setup X and Y co-ords
	ldx	XPOS
	lda	YPOS
	jsr	HPOSN		; X= (y,x) Y=(a)

shape_smc:
	ldx	#<shape_person	; point to our shape
	ldy	#>shape_person

rot_smc:
	lda	#0		; ROT=0


	jmp	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit


	;==========================
	; draw/beep/undraw
	;==========================
draw_beep:
	jsr	xdraw		; draw
	jsr	beep		; make noise/delay

	ldy	#24
	sty	tone_smc+1

	jmp	xdraw		; draw



scale_lookup:
;.byte 1,2,3,4,5,4,3,2

shape_person:
; Person, shoulders up

;.byte	$01,$00,$04,$00,
.byte	$2d,$25,$3c,$24
.byte	$2c,$2c,$35,$37,$6f,$25,$16,$3f
.byte	$77,$2d,$1e,$37,$2d,$2d,$15,$3f
.byte	$3f,$3f,$3f,$3f,$07,$00

shape_arm:
;.byte	$49,$49,$49,$24
;.byte	$24,$24,$ac,$36,$36,$36,$00

shape_dsr:
.byte	$2d,$36,$ff,$3f
.byte	$24,$ad,$22,$24,$94,$21,$2c,$4d
.byte	$91,$3f,$36,$00


	;===========================
	; BEEP
	;===========================
beep:
	lda	FRAME
	and	#$3
	beq	actual_beep

	lda	#100
	jmp	WAIT

actual_beep:
	; BEEP
	; repeat 34 times
	lda	#30			; 2
tone1_loop:
	ldy	#21			; 2
	jsr	delay_tone		; 3

	ldy	#24			; 2
	jsr	delay_tone		; 3

tone_smc:
	ldy	#21			; 2
	jsr	delay_tone		; 3

	sec				; 1
	sbc	#1			; 2
	bne	tone1_loop		; 2

	rts				; 1


	; Try X=6 Y=21 cycles=757
	; Try X=6 Y=24 cycles=865
	; Try X=7 Y=235 cycles=9636

delay_tone:
loopC:	ldx	#6			; 2
loopD:	dex				; 1
	bne	loopD			; 2
	dey				; 1
	bne	loopC			; 2

	bit	SPEAKER			; 3	; click speaker

	rts				; 1

