; Flyer
; 512 byte Apple II "boot sector" with graphics and Music

; by Vince `deater` Weaver, vince@deater.net	--- d e s i r e ---

; 178 bytes -- original conversion from BASIC
; 176 bytes -- know HGR2 returns with A=0
; 172 bytes -- optimize page flip code
; 170 bytes -- assume XDRAW never got over X=256
; 504 bytes -- merge in the music code
; 507 bytes -- turn off drive motor
; 510 bytes -- add color change bg
; 508 bytes -- assume Y=0 when entering mockingboard init code
; 506 bytes -- optimize frame wrap
; 505 bytes -- shave byte off wicket scale
; 504 bytes -- tail call in xdraw
; 512 bytes -- switch color with music
; 510 bytes -- unneeded reload of A
; 517 bytes -- made flyer go back and forth
; 512 bytes -- removed extra cc, merged to common ZP zero init

; zero page locations

AY_REGS		= $70
FRAME		= $80
SONG_OFFSET	= $81
SONG_COUNTDOWN	= $82


HGR_COLOR	= $E4
HGR_PAGE	= $E6
HGR_SCALE	= $E7
HGR_ROTATION	= $F9
FRAME2		= $DC
HORIZON_Y	= $FD
HORIZON_LINE	= $FE


; soft-switches
KEYPRESS	= $C000
KEYRESET	= $C010
PAGE1		= $C054
PAGE2		= $C055

; ROM calls
HGR2	= $F3D8		; after: A=0, Y=0, HGR_SHAPE=$40/$60
HCLR	= $F3F2		; clear current page to 0
BKGND0	= $F3F4		; clear current page to A
HPOSN	= $F411		; move to (Y,X), (A)	(saves A,X,Y to zero page)
HPLOT0	= $F457		; plot at (Y,X), (A)	(calls HPOSN)
HGLIN	= $F53A		; line to (X,A), (Y)
DRAW0	= $F601
XDRAW0	= $F65D


	.byte	2			; number of sectors to load

	; turn off drive motor
	lda	$C088,X			; turn off drive motor
					; hopefully slot*16 is in X


flyer:

	jsr	HGR2			; HGR2		HGR_PAGE=$40
;	sta	FRAME			; A=0, Y=0 after HGR2
					; init by mockingboard init

	;===================
	; music Player Setup

tracker_song = peasant_song

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"

	; start the music playing

	cli


animate_loop:
	clc
	lda	#96
	adc	FRAME
	sta	HORIZON_LINE		; S=96+FRAME

	; flip draw page $20/$40
	lda	HGR_PAGE
	eor	#$60
	sta	HGR_PAGE

	; flip page
	; have $20/$40 want to map to C054/C055

	asl
	asl			; $20 -> C=1 $00
	asl			; $40 -> C=0 $00

	adc	#0
	tax
	cmp	PAGE1,X

	; clear screen
clear_screen_smc:
	lda	#$00		; clear to this color
	jsr	BKGND0

	;===============
	; draw mountain
	;	FIXME: we in theory only have to do this once
	;		as we never over-write it

	; color = blue (6)

	lda	#$D5
	sta	HGR_COLOR

	; HPLOT 0,96 TO 140,80
	ldy	#0
	ldx	#0
	lda	#96
	jsr	HPLOT0		; plot at (Y,X), (A)

	ldx	#0
	lda	#140
	ldy	#80
	jsr	HGLIN		; line to (X,A),(Y)

	; HPLOT TO 279,96

	ldx	#1
	lda	#23
	ldy	#96
	jsr	HGLIN

	; color = green (1)
	; blue =$D5=1101 0101 want 0010 1010

	lda	#$2A
	sta	HGR_COLOR

horizon_lines_loop:
	lsr	HORIZON_LINE	; S=S/2:Y=96+S
	clc
	lda	#96
	adc	HORIZON_LINE
	sta	HORIZON_Y

	; HPLOT 0,Y TO 279,Y
	ldy	#0
	ldx	#0
;	lda	HORIZON_Y
	jsr	HPLOT0		; plot at (Y,X), (A)

	ldx	#1
	lda	#23
	ldy	HORIZON_Y
	jsr	HGLIN		; line to (X,A),(Y)


	;================
	; draw wicket
	; XDRAW 1 AT 140,Y

	lda	HORIZON_LINE
	lsr
	lsr				; SCALE=1+S/4
	tax
	inx
	stx	HGR_SCALE


;	ldy	#0
	ldx	#140			; X=140
	lda	HORIZON_Y		; Y
	jsr	xdraw

	lda	HORIZON_LINE
	bne	horizon_lines_loop	; IF S>1 THEN 8


	;===================
	; draw ship
	; XDRAW 1 AT 140+16*SIN(H),180

	lda	#2
	sta	HGR_SCALE	; SCALE=2

	;====================
	; move ship

	inc	FRAME2
	lda	FRAME2
	and	#$7
	tay

	ldx	positions,Y
	;=========================
	; draw ship

;	ldx	#140

	lda	#180		; Y=180
	jsr	xdraw

			; H=H+0.3

	;========================
	; wrap frame


	; J=(J+12)*(J<84)
	lda	FRAME
	cmp	#84			; if (J>84) then J=0
	bcc	no_reset_frame		; bge

	; we know carry is set here
	lda	#$F3			; (-13) -12-C

no_reset_frame:
	; we know carry is clear here
	adc	#12			; J=J+12

	sta	FRAME


	;=======================
	; check for keypress
check_keypress:
	lda	KEYPRESS
	bmi	quiet

	jmp	animate_loop

quiet:
	lda	#$3f
	sta	AY_REGS+7

end:
	brk				; end?





	;=======================
	; xdraw
	;=======================
xdraw:
	; setup X and Y co-ords

	ldy	#0		; XPOSH always 0 for us
;	ldx	XPOS
;	lda	YPOS
	jsr	HPOSN		; X= (y,x) Y=(a)

	ldx	#<ship_table
	ldy	#>ship_table

	lda	#0		; set rotation

	jmp	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit


	; optimize, can probably shave byte off
	; was originally in ASCII for basic bot purposes
	; "#%%-...",0
	; but we don't have that limitation
ship_table:
	.byte	$23	; 00 100 011	NLT UP X
	.byte	$25	; 00 100 101	RT  UP X
	.byte	$25	; 00 100 101	RT  UP X
	.byte	$2D	; 00 101 101	RT  RT X
	.byte	$2E	; 00 101 110	DN  RT X
	.byte	$2E	; 00 101 110	DN  RT X
	.byte	$0E	; 00 001 110	NDN RT X
	.byte	$0


positions:
	;	 +4   +8  +8  +4
	.byte  170,174,182,190,194,190,182,174

.include        "interrupt_handler.s"
.include	"mockingboard_constants.s"
; music
.include	"mA2E_3.s"
