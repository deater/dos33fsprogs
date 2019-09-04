; This took a while to track down
; On Apple II/II+ the horiz blanking addr are $1000 higher than on IIe
; So on II+ were outside video area, so unlikely to be our set value
;	(unless I foolishly use $ff which some uninitialized mem is set to)
; Lots of this color fiddling is to make sure you don't accidentally
;	get runs of colors on IIe due to the horiz blank

; 0-5 aqua 6-12 = grey, 13 - 20 = yellow, 21-23 = aqua rainbow 14
;
;
;16	0	YA
;17	1	YA
;18	2	YA
;19	3	YA
;20	4	YA
;21	5	AA
;22	6	AG
;23	7	AG
;0	8	AG
;1	9	AG
;2	10	AG
;3	11	AG
;4	12	AG
;5	13	AY ****
;6	14	GY RAINBOW
;7	15	GY
;8	16	GY
;9	17	GY
;10	18	GY
;11	19	GY
;12	20	GY
;13	21	YA
;14	22	YA
;15	23	YA



	;==============================
	; setup graphics for vapor lock
	;==============================
vapor_lock:

	; Clear Page0
	lda	#$0
	sta	DRAW_PAGE
	lda	#$ee				; full screen white $ff
	jsr	clear_gr

	lda	#$dd
	ldy	#40
	jsr	clear_page_loop			; make bottom half yellow $dd

	lda	#$aa
	ldy	#24
	jsr	clear_page_loop			; make middle grey2 $aa

	lda	#$ee
	ldy	#10
	jsr	clear_page_loop			; make top half aqua $ee

	; set up a rainbow to aid in exact lock

	ldy	#00
rainbow_loop:
	tya
	sta	$728+20,Y
	iny
	cpy	#20
	bne	rainbow_loop

;btt:
;	jmp	btt


	;=====================================================
	; attempt vapor lock
	;  by reading the "floating bus" we can see most recently
	;  written value of the display
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

	; first make sure we have a full line of $aa

	lda	#$aa							; 2
zxloop:
	ldx	#$04							; 2
wiloop:
	cmp	$C051		; read the floating bus			; 4
	bne	zxloop		; if not, start from scratch		; 2/3
	dex			; we were, dec				; 2
	bne	wiloop		; if not 4 of them, restart		; 3/2

	; if we get here we read 4 proper pixels, 11 apart (2+4+2+2+3)
	; 0 11 22 33, clock at 34
	; 1 12 23 34, clock at 35
	; 2 13 24 35, clock at 36
	; 3 14 25 36, clock at 37
	; 4 15 26 37, clock at 38
	; 5 16 27 38, clock at 39
	; 6 17 28 39, clock at 40


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
	; happens at line 13*8 = 104

	lda	#$dd							; 2
zloop:
	ldx	#$04							; 2
qloop:
	cmp	$C051		; read floating bus			; 4
	bne	zloop							; 2/3
	dex								; 2
	bne	qloop							; 3/2
								;============
								;	11

	; Found it!
	; if we get here we read 4 proper pixels, 11 apart (2+4+2+2+3)
	; 0 11 22 33, clock at 34
	; 1 12 23 34, clock at 35
	; 2 13 24 35, clock at 36
	; 3 14 25 36, clock at 37
	; 4 15 26 37, clock at 38
	; 5 16 27 38, clock at 39
	; 6 17 28 39, clock at 40




;btt:
;	jmp	btt

	; In theory near end of line 104

	; now skip ahead 8 lines and read from the rainbow pattern we set
	; up to find our exact location

	; delay 65 * 8 = 520
	; we back off a few to make sure we're not in the horiz blank
	; try to delay 510

	; *NOTE* sometimes we end up going one (or rarely, two??) lines too far
	; so instead try going 7 lines ahead, and if still dd then one more

	; so single step until we get a rainbow color

	; go to next line, -10
	lda	#28				; 2
	jsr	delay_a				; delay 25+28 = 53
						; total delay = 55

vl_try_again:
	lda	#29				; 2
	jsr	delay_a				; delay 25+29 = 54
						; total delay = 56



	lda	$C051				; 4
	cmp	#$dd				; 2
	beq	vl_try_again			; 3
						; -1


	; now near end of line 112
	;lda	$0	; nop to match old code	; 3
;	nop	; nop to match old code	; 2

	lda	$C051				; 4
;kbb:
;	jmp	kbb

        ; we are in theory on line $728 = 14*8 = 112
        ; so 112*65 = 7280 cycles from start

        ; we are actualy 25+20+A pixels in
        ; 7325+A

        ; Our goal is line 114 at 7410 cycles
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


	;==================================
	; Vapor HLINE
	;==================================
	; FIXME: merge with generic hline code?
	; Color in A
	; Y has which line
hline:
	pha							; 3
	ldx	gr_offsets,y					; 4+
	stx	hline_loop+1					; 4
	lda	gr_offsets+1,y					; 4+
	clc							; 2
	adc	DRAW_PAGE					; 3
	sta	hline_loop+2					; 4
	pla							; 4
	ldx	#39						; 2
hline_loop:
	sta	$5d0,X		; 38				; 5
	dex							; 2
	bpl	hline_loop					; 2nt/3
	rts							; 6


	;==========================
	; Clear gr screen
	;==========================
        ; Color in A
clear_gr:
	ldy	#46
clear_page_loop:
	jsr	hline
	dey
	dey
	bpl	clear_page_loop
	rts



	; Some random related work
	; Docs:
	;	Lancaster
	;	Bishop
	;	Sather

	; Vaguely relevant but no help with the Apple II+ issue
	;
	;	Eamon: Screen display and timing synchronization
	;		on the Apple IIe and Apple IIgs
	;
	;	Adams: Visually presented verbal stimuli by assembly
	;		language on the Apple II computer.
	;	Cavanagh and Anstis: Visual psychophysics on the
	;		Apple II: Getting started
