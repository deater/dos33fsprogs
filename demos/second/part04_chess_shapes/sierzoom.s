; 122 byte sierpinski-like rotozoomer intro
;	for Apple II lo-res 40x48 mode
; based on the code from Hellmood's Memories demo

; by Vince `deater` Weaver <vince@deater.net>

; for Lovebyte 2021

; for a simple sierpinski you more or less just plot
;		X AND Y
; Hellmood's you plot something more or less like
; 	COLOR = ( (Y-(X*T)) & (X+(Y*T) ) & 0xf0
; where T is an incrementing frame value

; to get speed on 6502/Apple II we change the multiplies to
; a series of 16-bit 8.8 fixed point adds

; instead of multiplying X*T and Y*T you know that since you start at 0,0
;	they both start at 0, and you can find X*T by just having an XT
;	value that starts at 0 and add T to it as you move across the
;	screen which is the same result as calculating X*T over and over
; you can do the same thing with Y*T

; t=0;
;
; draw_frame:
;
;	y_t=0;
;	for(y=0;y<48;y++) {
;		y_t+=t;
;		x_t=0;
;		for(x=0;x<40;x++) {
;			color= ((x+y_t) & (y-x_t))&0xf0;
;			plot(x,y);
;			x_t+=t;
;		}
;	}
;	t++;
; goto draw_frame;

	;================================
	; Clear screen and setup graphics
	;================================
sier_zoom:
;	bit	LORES		; drop down to lo-res

;	lda	#0		; start with multiplier 0
;	sta	T_L		; since we are executing in zero page we
;	sta	T_H		; don't need to init these

	lda	#$D3
	sta	T_L
	lda	#$2C
	sta	T_H

; NOTE: start at D3/2C to make it less obvious?

sier_outer:

	ldx	#0		; YY starts at 0

	stx	YY_TL		; YY_T also starts at 0
	stx	YY_TH

sier_yloop:

	; calc YY_T (8.8 fixed point add)
;	clc			; save byte by ignoring carry (slightly
				; changes results but not by much)
	lda	YY_TL
	adc	T_L
	sta	YY_TL
	lda	YY_TH
	adc	T_H
	sta	YY_TH

	txa	; YY		; plot call needs Y/2
	lsr

;	php			; save the bit we shifted into carry


	;================================
	; plot_setup
	;================================
	; vaguely GBASCALC compatible
	; take Y-coord/2 in A, put address in GBASL/H
	; ( A, Y trashed)

splot_setup:

;	lsr			; shift bottom bit into carry		; 2
	tay

	bcc	do_splot_even						; 2nt/3
do_splot_odd:
	lda	#$f0							; 2
	bcs	do_splot_c_done						; 2nt/3
do_splot_even:
	lda	#$0f							; 2
do_splot_c_done:
	sta	smask_smc2+1						;
	eor	#$FF							; 2
	sta	smask_invert_smc1+1					;

	lda	gr_offsets_l,Y	; lookup low-res memory address		; 4
	sta	sgbasl_smc1+1
	sta	sgbasl_smc2+1


        lda	gr_offsets_h,Y						; 4
	clc
        adc	DRAW_PAGE	; add in draw page offset		; 3
	sta	sgbasl_smc1+2
	sta	sgbasl_smc2+2

	;=============================

;	plp
;	jsr	$f806		; trick to calculate MASK by jumping
				; into middle of PLOT routine

	; reset XX to 0

	ldy	#0		; XX=0

	sty	XX_TL		; XX_T also 0
	sty	XX_TH

sier_xloop:

	; want (YY-(XX*T)) & (XX+(YY*T)


	; SAVED = XX+(Y*T)
;	clc			; skip setting carry to save byte

	tya			; XX lives in Y
	adc	YY_TH
	sta	SAVED		; save XX+YY_T

	; calc XX*T
;	clc			; skip setting carry to save byte

	lda	XX_TL		; XX_T=XX_T+T
	adc	T_L
	sta	XX_TL
	lda	XX_TH
	adc	T_H
	sta	XX_TH


	; calc (YY-X_T)
	txa			; YY lives in X
	sec
	sbc	XX_TH

	; want (YY-(XX*T)) & (XX+(YY*T)

	and	SAVED

	and	#$f0

	beq	pink
black:
	lda	#00	; black
	.byte	$2C	; bit trick
pink:
	lda	#$BB	; pink
	sta	scolor_smc+1

	; XX value already in Y




	;================================
	; plot1
	;================================
	; roughly compatible with PLOT1
	; ; PLOT AT (GBASL),Y

splot1:
smask_invert_smc1:
	lda	#$ff		; load mask				; 2
sgbasl_smc1:
	and	$400,Y		; mask to preserve on-screen color	; 4+
	sta	COLOR_MASK	; save temporarily			; 3
scolor_smc:
	lda	#$FF		; load color				; 2
smask_smc2:
	and	#$FF		; mask so only hi/lo we want		; 2
	ora	COLOR_MASK	; combine with on-screen color		; 3
sgbasl_smc2:
	sta	$400,Y		; save back out				; 5

	;====================================

	iny		; XX
	cpy	#40
	bne	sier_xloop

	inx		; YY
	cpx	#48
	bne	sier_yloop

	; inc T
;	clc
	lda	T_L

	; SPEED is HERE!
blah_smc:
	adc	#$60

	sta	T_L
	bcc	no_carry
	inc	T_H
no_carry:

	; speed up the zoom as time goes on
;	inc	blah_smc+1


	; x is 48
flip_pages:
	lda	DRAW_PAGE
	beq	done_page
	inx
done_page:
	; X=48 ($30)	PAGE1=$C054-$30=$C024
	ldy	$C024,X		; set display page to PAGE1 or PAGE2

	eor	#$4             ; flip draw page between $400/$800
	sta	DRAW_PAGE

;	jmp	sier_outer	; can't guarantee a flag value for a 2-byte
				; branch :(


sierzoom_end_smc:
	lda	#25
	jsr	wait_for_pattern
	bcs	done_sierzoom

	jmp	sier_outer

done_sierzoom:
        rts
