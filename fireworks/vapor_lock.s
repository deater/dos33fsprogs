	;==============================
	; setup graphics for vapor lock
	;==============================
vapor_lock:

	; Clear Page0
	lda	#$0
	sta	DRAW_PAGE
	lda	#$ff				; full screen dark green $44
	jsr	clear_gr

	lda	#$aa
	ldy	#24
	jsr	clear_page_loop			; make top half red $11

	ldy	#00				; 0
	sty	$728+20
	iny					; 1
	sty	$728+21
	iny					; 2
	sty	$728+22
	iny					; 3
	sty	$728+23
	iny					; 4
	sty	$728+24
	iny					; 5
	sty	$728+25
	iny					; 6
	sty	$728+26
	iny					; 7
	sty	$728+27
	iny					; 8
	sty	$728+28
	iny					; 9
	sty	$728+29
	iny					; a
	sty	$728+30
	iny					; b
	sty	$728+31
	iny					; c
	sty	$728+32
	iny					; d
	sty	$728+33
	iny					; e
	sty	$728+34
	iny					; f
	sty	$728+35
	iny                                     ; 10
	sty	$728+36
	iny
	sty	$728+37
	iny
	sty	$728+38
	iny
	sty	$728+39

;btt:
;	jmp	btt


	;=====================================================
	; attempt vapor lock
	;  by reading the "floating bus" we can see most recently
	;  written value of the display
	; we look for $55 (which is the grey line)
	;=====================================================
	; See:
	;	Have an Apple Split by Bob Bishop
        ;	Softalk, October 1982

	; Challenges: each scan line scans 40 bytes.
	; The blanking happens at the *beginning*
	; So 65 bytes are scanned, starting at adress of the line - 25

	; the scan takes 8 cycles, look for 4 repeats of the value
	; to avoid false positive found if the horiz blanking is mirroring
	; the line (max 3 repeats in that case)

vapor_lock_loop:

	; first make sure we have a full line of red
	; we can only read every 

	lda	#$aa							; 2
zxloop:
	ldx	#$04							; 2
wiloop:
	cmp	$C051		; read the floating bus			; 4
	bne	zxloop		; if not red, start from scratch	; 2/3
	dex			; we were red, dec			; 2
	bne	wiloop		; if not 4 of them, restart		; 3/2

	; if we get here we read 4 proper pixels, 11 apart

;                                 X          X          X          X
;                                  X          X          X          X
;                                   X          X          X          X
;                                    X          X          X          X
;                                     X          X          X          X
;                                      X          X          X          X
;                                       X          X          X          X
;	0123456789012345678901234 0123456789012345678901234567890123456789
;                 1         2               1         2         3
;	hsync                     pixels
;       XXXXXXXXXXXXXXXXXXXXXXXXX 4444444444444444444444444444440123456789

	; now look for the color change that
	; happens at line 12*8 = 96
	lda	#$ff							; 2
zloop:
	ldx	#$04							; 2
qloop:
	cmp	$C051		; read floating bus			; 4
	bne	zloop							; 2/3
	dex								; 2
	bne	 qloop							; 3/2
								;============
								;	11

	; delay 65 *1
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0

	; delay 65 *1
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0

	; delay 65 *1
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0

	; delay 65 *1
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0

	; delay 65 *1
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0

	; delay 65 *1
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0

	; delay 65 *1
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0

	; delay 65 *1
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0
	inc	$0


	lda	$C051
;kbb:
;	jmp	kbb

        ; we are in theory on line $728 = 14*8 = 112
        ; so 112*65 = 7280 cycles from start

        ; we are actualy 25+20+A pixels in
        ; 7325+A

        ; 114 is at 7410 cycles
	; 7410 - 7325 = 85

        ; so kill 85-A cycles
	; -6 to do subtraction
	; -6 for rts
	; -25 for delay_a overhead

        eor	#$ff				; 2
        sec					; 2
        adc	#48				; 2

	jsr	delay_a				; should total 48 cycles


done_vapor_lock:
	rts                                                     ; 6
