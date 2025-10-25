;license:MIT
;(c) 2020 by 4am
;
; NOTE!: copies code over top of zero page $00..$D9

; for red line:
; auxmem  alternate #$08/#$22
; mainmem alternate #$11/#$44


; AUX       MAIN     AUX      MAIN
; PBBBAAAA  PDDCCCCB PFEEEEDD  PGGGGFFF
; 00001000  00010001 00100010  01000100
;
; A = 1000 B = 1000 C = 1000 D = 1000 E = 1000 F = 1000 G = 1000

;          lores dhgr            lores dhgr
; BLACK =   0000 0000	BROWN  = 1000 0100
; MAGENTA = 0001 1000	ORANGE = 1001 1100
; D.BLUE  = 0010 0001	GREY2  = 1010 0101
; PURPLE  = 0011 1001	PINK   = 1011 1101
; D.GREEN = 0100 0010	L.GREEN= 1100 0110
; GREY1   = 0101 1010	YELLOW = 1101 1110
; M.BLUE  = 0110 0011	AQUA   = 1110 0111
; L.BLUE  = 0111 1011	WHITE  = 1111 1111


do_wipe_redlines:

.macro COPY_TO_0 start, end
; out:   X=0
;        Z=1
        .Local m1
        ldx     #(end-start)
m1:     lda     start-1, x
        sta     $FF, x
        dex
        bne     m1
.endmacro


	COPY_TO_0 start, end
;	jsr	iBuildHGRTables
	jmp	loop


; code that gets copied to zero page, for speed?
;	also execution still works when most memory switched to read/write aux

start:
.org $00
loop:
	jsr	wait_vblank
row1=*+1
	ldx	#$00			; SMC
	jsr	DrawRedLine
row2=*+1
	ldx	#$BF			; SMC
	jsr	DrawRedLine
	ldx	row1
	beq	drl_p1
	dex
	jsr	DrawBlackLine
drl_p1:
	ldx	row2
	inx
	cpx	#$C0
	beq	drl_p2
	jsr	DrawBlackLine
drl_p2:
	lda	KBD
	bmi	drl_exit
	inc	row1
	dec	row2
	lda	row1
	cmp	#$60
	bne	loop

loop2:
	jsr	wait_vblank
	ldx	row1
	cpx	#$C0
	beq	drl_p3
	jsr	DrawRedLine
drl_p3:
	ldx	row2
	bmi	drl_p4
	jsr	DrawRedLine
drl_p4:
	ldx	row1
	dex
	jsr	CopyLine
	ldx	row2
	inx
	jsr	CopyLine
	lda	KBD
	bmi	drl_exit
	inc	row1
	dec	row2
	lda	row1
	cmp	#$C1
	bne	loop2
drl_exit:
	jmp	wait_vblank

DrawRedLine:
	lda	hposn_low, X
	sta	<reddst1+1
	sta	<reddst2+1
	lda	hposn_high, X
	sta	<reddst1+2
	sta	<reddst2+2
	ldy	#$27
	lda	#$11
drl_m1:
	eor	#$55
reddst1:
	sta	$FDFD, Y		; SMC
	dey
	bpl	drl_m1
	sta	WRITEAUXMEM
	ldy	#$27
	lda	#$08
drl_m2:
	eor	#$2A
reddst2:
	sta	$FDFD, Y		; SMC
	dey
	bpl	drl_m2
	sta	WRITEMAINMEM
	rts

DrawBlackLine:
	lda	hposn_low, X
	sta	<blackdst+1
	lda	hposn_high, X
	sta	<blackdst+2
	lda	#$00
	clc
;	HIDE_NEXT_BYTE
	.byte	$24			; bit
dbl_mm:
	sec
	ldy	#$27
blackdst:
	sta	$FDFD, Y		; SMC
	dey
	bpl	blackdst
	sta	WRITEAUXMEM
	bcc	dbl_mm
	sta	WRITEMAINMEM
	rts

CopyLine:
	lda	hposn_low, X
	sta	<copysrc+1
	sta	<copydst+1
	lda	hposn_high, X
	sta	<copydst+2
	eor	#$60
	sta	<copysrc+2
	clc
	; HIDE_NEXT_BYTE
	.byte	$24			; bit
cl_m1:
	sec
	ldy	#$27
copysrc:
	lda	$FDFD, Y		; SMC
copydst:
	sta	$FDFD, Y		; SMC
	dey
	bpl	copysrc
	sta	READAUXMEM
	sta	WRITEAUXMEM
	bcc	cl_m1
	sta	READMAINMEM
	sta	WRITEMAINMEM
	rts
;}
.reloc
end:
