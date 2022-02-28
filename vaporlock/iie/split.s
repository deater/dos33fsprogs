; split screen?

; by Vince `deater` Weaver

; zero page
GBASL	= $26
GBASH	= $27
V2	= $2D
MASK	= $2E
COLOR	= $30
;CTEMP	= $68
YY	= $69

FRAME	= $FC
SUM	= $FD
SAVEX	= $FE
SAVEY	= $FF

; soft-switches
SET_GR	= $C050
SET_TEXT= $C051
FULLGR	= $C052
TEXTGR	= $C053
PAGE1	= $C054
LORES	= $C056
HIRES	= $C057
VBLANK	= $C019		; *not* RDVBL (VBL signal low)

; ROM routines
SETCOL  = $F864		;; COLOR=A*17
SETGR	= $FB40
VLINE	= $F828			;; VLINE A,$2D at Y
HGR	= $F3E2
HPLOT0  = $F457		; plot at (Y,X), (A)
HGLIN	= $F53A		; line to (X,A),(Y)

	;================================
	; Clear screen and setup graphics
	;================================
split:

	jsr	SETGR		; set lo-res 40x40 mode

	;===================
	; draw lo-res lines

	ldx	#39
draw_lores_lines:
	txa
	tay
	jsr	SETCOL

	lda	#47
	sta	V2
	lda	#0
	jsr	VLINE	; VLINE A,$2D at Y

	dex
	bpl	draw_lores_lines

	;===================
	; draw hi-res lines

	jsr	HGR
	bit	FULLGR		; make it 40x48


	ldx	#0
	ldy	#0
	lda	#96
	jsr	HPLOT0		; plot at (Y,X), (A)

	ldx	#0
	lda	#140
	ldy	#191
	jsr	HGLIN		; line to (X,A),(Y)

	ldx	#1
	lda	#23
	ldy	#96
	jsr	HGLIN		; line to (X,A),(Y)


	; wait for vblank on IIe
	; positive? during vblank

wait_vblank_iie:
	lda	VBLANK
	bmi	wait_vblank_iie		; wait for positive (in vblank)
wait_vblank_done_iie:
	lda	VBLANK			; wait for negative (vlank done)
	bpl	wait_vblank_done_iie

	;
split_loop:
	;===========================
	; text mode first 6*8 (48) lines
	;	each line 65 cycles (25 hblank+40 bytes)

	bit	LORES		; 4
	bit	SET_TEXT	; 4

	; wait 6*8=48 lines
	; (48*65)-8 = 3120-8 = 3112

	jsr	delay_3112

	; lores next 6 lines

	bit	LORES		; 4
	bit	SET_GR		; 4

	jsr	delay_3112

	; hi-res for last 96 lines + horizontal blank
	; vblank = 4550 cycles

	; (96*65)+4550-7 = 6240+4550-7 = 10783

	bit	HIRES		; 4

	; Try X=38 Y=55 cycles=10781

	nop

        ldy     #55                                                     ; 2
loop3:  ldx     #38                                                      ; 2
loop4:  dex                                                             ; 2
        bne     loop4                                                   ; 2nt/3
        dey                                                             ; 2
        bne     loop3                                                   ; 2nt/3



	jmp	split_loop	; 3


	; actually want 3112-12 (6 each for jsr/rts)
	; 3100
	; Try X=6 Y=86 cycles=3097
delay_3112:

	lda	$0		; 3-cycle nop

        ldy     #86                                                     ; 2
loop1:  ldx     #6                                                      ; 2
loop2:  dex                                                             ; 2
        bne     loop2                                                   ; 2nt/3
        dey                                                             ; 2
        bne     loop1                                                   ; 2nt/3

	rts

	; to run on bot, want this to be at $3F5
	; so load at $384

	jmp	split
