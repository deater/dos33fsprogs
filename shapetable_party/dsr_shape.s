; shapetable party
; by Deater for -=dSr=-
; @party 2020

; 252 bytes

; zero page locations
HGR_SHAPE	=	$1A
SEEDL		=	$4E
FRAME		=	$A4
OUR_ROT		=	$A5
RND_EXP		=	$C9
HGR_PAGE	=	$E6
HGR_SCALE	=	$E7
HGR_ROTATION	=	$F9
SCALE		=	$FC
XPOS		=	$FD
YPOS		=	$FF

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
TEXT		=	$FB36	; Set text mode
WAIT		=	$FCA8	; delay 1/2(26+27A+5A^2) us


dsr_demo:

	;=========================================
	; SETUP
	;=========================================


	lda	#$20		; 2	; set HGR page0
	sta	HGR_PAGE	; 2
	sta	XPOS		; 2	; setup XPOS for future

	lda	#$ff		; 2
	jsr	HCLR_COLOR	; 3	; clear HGR page0 to white

	jsr	HGR2		; 3	; set/clear HGR page1 to black
					; Hi-res graphics, no text at bottom
					; Y=0, A=$60 after this call

	sty	FRAME		; 2
	sty	OUR_ROT		; 2

	iny			; 1	; set shape table scale to 1
	sty	HGR_SCALE	; 2

	;=========================
	; draw crowd
	;=========================

	; XPOS already 32 from earlier

	lda	#180		; 2
	sta	YPOS		; 2

crowd_loop:

	jsr	xdraw		; 3	; xdraw on page1

	lsr	HGR_PAGE	; 2	; switch to page0 ($40 -> $20)

	jsr	xdraw		; 3	; xdraw on page 0

	asl	HGR_PAGE	; 2	; switch back to page1 $20 -> $40

	;	clc	; carry should always be 0 from asl
	lda	XPOS		; 2
	adc	#16		; 2
	sta	XPOS		; 2
	bne	crowd_loop	; 2

	; get ready for DSR loop

	ldx	#<shape_dsr	; 2	; point to dSr shape
	stx	shape_smc+1	; 3	; update self-modify code

			;====================================
			;	50 bytes to init/draw crowd

	;=========================================
	; OFFSCREEN RESET
	;=========================================

reset_loop:
	lda	#10		; 2	; set initial x,y
	sta	XPOS		; 2
	sta	YPOS		; 2

	inc	HGR_SCALE	; 2	; increment scale

	;=========================================
	; MAIN LOOP
	;=========================================

main_loop:

	inc	OUR_ROT		; 2
	inc	OUR_ROT		; 2

	; increment FRAME

	inc	FRAME		; 2
	lda	FRAME		; 2

	and	#$1f		; 2
	beq	long_frame	; 2

	lda	#15		; 2
	jsr	draw_and_beep	; 3

done_frame:

	;========================
	; move dSr
	;========================

	inc	YPOS	; 2
	inc	YPOS	; 2
	inc	YPOS	; 2

	lda	XPOS	; 2
	adc	#5	; 2
	sta	XPOS	; 2

	cmp	#250
	bcs	reset_loop
	bcc	main_loop


shape_person:
; Person, shoulders up

;.byte	$01,$00,$04,$00,
.byte	$2d,$25,$3c,$24
.byte	$2c,$2c,$35,$37,$6f,$25,$16,$3f
.byte	$77,$2d,$1e,$37,$2d,$2d,$15,$3f
.byte	$3f,$3f,$3f,$3f,$07,$00

shape_arm:
.byte	$49,$49,$49,$24
.byte	$24,$24,$ac,$36,$36,$36,$00

shape_dsr:
.byte	$2d,$36,$ff,$3f
.byte	$24,$ad,$22,$24,$94,$21,$2c,$4d
.byte	$91,$3f,$36,$00


	;===========================
	; long frame
	;===========================

long_frame:

	bit	PAGE0		; 3	; switch to page0
	lsr	HGR_PAGE	; 2	; switch draw target to page0


	;====================
	; draw arm (inlined)
	;=====================
draw_arm:

	lda	HGR_SCALE	; 2
	pha			; 1

	ldy	#1		; 2
	sty	HGR_SCALE	; 2

	; setup X and Y co-ords
	lda	FRAME
	and	#$f0			; 32, 64, 96, 128, 160, 192, 224, 256
	beq	skip_arm
	tax				; XPOS
	dey				; XPOSH=0
	lda	#180
	jsr	HPOSN		; X= (y,x) Y=(a)

	ldx	#<shape_arm	; 2	; point to arm shape
	jsr	xdraw_custom_shape

skip_arm:
	pla			; 1
	asl			; 1	; make twice as big
	sta	HGR_SCALE	; 2

	lda	#85		; 2	; long tone
	jsr	draw_and_beep	; 3	; draw and beep

	bit	PAGE1		; 3	; display page back to page1

	lsr	HGR_SCALE	; 2	; switch scale back

	asl	HGR_PAGE	; 2	; switch draw page to page1


	bpl	done_frame	; 2	; return


	;=======================
	; xdraw
	;=======================

xdraw:
	; setup X and Y co-ords

	ldy	#0		; XPOSH always 0 for us
	ldx	XPOS
	lda	YPOS
	jsr	HPOSN		; X= (y,x) Y=(a)

shape_smc:
	ldx	#<shape_person	; point to our shape
xdraw_custom_shape:
	ldy	#>shape_person	; code fits in one page so this doesn't change

rot_smc:
	lda	OUR_ROT		; set rotation

	jmp	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit





	;==========================
	; draw/beep/undraw
	;==========================
draw_and_beep:

	pha

;	sty	tone_smc+1	; 3

	jsr	xdraw		; 3

	; check for keypress
	lda	KEYPRESS		; 3	; see if key pressed
	bmi	exit_to_prompt		; 2	; loop if not

	;===========================
	; BEEP (inlined)
	;===========================
beep:

actual_beep:
	; BEEP
	; repeat 30 times
	ldx	#30		; 2
	pla
	tay

tone1_loop:

tone_smc:

;	lda	#15
	tya
	jsr	WAIT		; 3	; not as accurate as the cycle count
					; method before, but saves a few bytes

	lda	FRAME		; 2	; only play tone every 4th frame
	and	#$3		; 2
	bne	no_click	; 2

	bit	SPEAKER		; 3	; click speaker
no_click:
	dex			; 1
	bne	tone1_loop	; 2

	; WAIT equiv: delay 1/2(26+27A+5A^2) us
	; A=2.5 B=13.5 C=13
	; Try X=6 Y=21 cycles=757	C=-744  ; WAIT A=14.76
	; Try X=6 Y=24 cycles=865	C=-852 ; WAIT A=15.95
	; Try X=7 Y=235 cycles=9636	C=-19259 ; WAIT A=85.111



check_finished:
	lda	FRAME		; 2	; end with big dSr
	bne	xdraw		; 2	; xdraw

	;==================================
	; exit to basic
wait_until_keypress:
	lda     KEYPRESS		; 3	; see if key pressed
	bpl     wait_until_keypress	; 2	; loop if not
;	bit     KEYRESET			; clear keyboard buffer
exit_to_prompt:
	jsr     TEXT			; 3     ; return to text mode
	jmp     $3D0			; 3     ; return to Applesoft prompt

