; Spiraling Shape

; o/~ Down, Down, Down You Go o/~

; by Vince `deater` Weaver / DsR

; Lovebyte 2024

; Spiral plus some bass notes in 31 bytes

; You can enter it directly onto your Apple II with the following:
; CALL -151
; E9: 20 D8 F3 2C 30 C0 A8 A2  8C A9 60 20 11 F4 A2 DF
; F9: A0 E2 E6 FE A9 01 29 7F  85 E7 20 5D F6 F0 E4
; E9G


; zero page locations
GBASL		=	$26
GBASH		=	$27
HGR_SCALE	=	$E7
HGR_COLLISION	=	$EA		; overlaps our code, but it's OK
					; as it's modified after the HGR2
					; runs

HGR_ROTATION	=	$FE		; IMPORTANT! set this right!
					; we get this for free by loading
					; our code into $E9 in zero page
; ROM locations
HGR2		=	$F3D8
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
HPLOT0		=	$F457

spiraling_shape:
	jsr	HGR2		; Set Hi-resolution  (140x192) mode
				; HGR2 means use PAGE2 and no text at bottom
				; Y=0, A=0 after this call

	; A and Y are 0 here.
	; X is left behind by the boot process?

tiny_loop:
	bit	$C030		; click the speaker for some sound

	tay	; ldy #0		; A always 0 here

	ldx	#140		; center spiral on the screen
				; this is expensive
	lda	#96		; but otherwise doesn't look right

	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??

	ldx	#<our_shape		; load $E2DF
	ldy	#>our_shape		;
	inc	HGR_ROTATION	; rotate the line, also make it larger

	lda	#1		; HGR_ROTATION is HERE ($FE)
				; we also use it for scale

	and	#$7f		; cut off before it gets too awful
	sta	HGR_SCALE

	jsr	XDRAW0		; XDRAW 1 AT X,Y

				; XDRAW does an exclusive-or shape table
				; draw, so it draws the spiral first, then
				; undraws it on the second pass

				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra

	; o/~ No way to stop o/~



our_shape = $E2DF		; location in the Applesoft ROM
				; that holds $11,$F0,$03,$20,$00
				; which makes a nice line when
				; interpreted as a shape table
				; (it points into the code for the FRE()
				;  BASIC routine but that's not important)

