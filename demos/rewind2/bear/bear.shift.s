.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"


; 0x2B975E = 2.8s -- initial working code
; 0x2555e9 = 2.4s -- optimize the shifts
; 0x24a147 = 2.3s -- more optimize the shifts
; 0x243587 = 2.3s -- inline get_color
; 0x26B46E = 2.5s -- URGH wasted lots of time on shift version, ended up longer

	;=============================
	; do the bear sequence
	;=============================

bear:
	bit	KEYRESET	; just to be safe

	lda	#0

	;=================================
	; Unpack base image
	;=================================


	lda	#<bear_packed_zx02
        sta	zx_src_l+1
        lda	#>bear_packed_zx02
        sta	zx_src_h+1
        lda	#$A0
        jsr	zx02_full_decomp

	;=================================
	; Set DHGR mode
	;=================================


	bit	SET_GR
        bit	HIRES
        bit	FULLGR
        sta	AN3             ; set double hires
        sta	EIGHTYCOLON     ; 80 column
        sta	SET80COL        ; 80 store

        bit	PAGE1   ; start in page1

	;=================================
	; Unpack further to DHGR
	;=================================


	; full screen grey

	lda	#0
	sta	XSTART
	lda	#100
	sta	XEND

	lda	#<color_lookup_grey
	sta	color_lookup_smc+1
	lda	#>color_lookup_grey
	sta	color_lookup_smc+2

	jsr	decode_image

	jsr	wait_until_keypress

	; green1

	lda	#0
	sta	XSTART
	lda	#5
	sta	XEND

	lda	#<color_lookup_green
	sta	color_lookup_smc+1
	lda	#>color_lookup_green
	sta	color_lookup_smc+2

	jsr	decode_image

	jsr	wait_until_keypress

	; green2

	lda	#0
	sta	XSTART
	lda	#10
	sta	XEND

	jsr	decode_image

	jsr	wait_until_keypress

	; blue1

	lda	#4
	sta	XSTART
	lda	#10
	sta	XEND

	lda	#<color_lookup_blue
	sta	color_lookup_smc+1
	lda	#>color_lookup_blue
	sta	color_lookup_smc+2

	jsr	decode_image

	jsr	wait_until_keypress

	; blue2

	lda	#4
	sta	XSTART
	lda	#15
	sta	XEND

	jsr	decode_image

	jsr	wait_until_keypress

	; red1

	lda	#9
	sta	XSTART
	lda	#15
	sta	XEND

	lda	#<color_lookup_red
	sta	color_lookup_smc+1
	lda	#>color_lookup_red
	sta	color_lookup_smc+2

	jsr	decode_image

	jsr	wait_until_keypress

	; red2

	lda	#9
	sta	XSTART
	lda	#20
	sta	XEND

	jsr	decode_image

	jsr	wait_until_keypress


	; yellow1

	lda	#14
	sta	XSTART
	lda	#20
	sta	XEND

	lda	#<color_lookup_yellow
	sta	color_lookup_smc+1
	lda	#>color_lookup_yellow
	sta	color_lookup_smc+2

	jsr	decode_image

	jsr	wait_until_keypress



	rts


	;==================================
	; decode image
	;==================================
	; set XSTART, XEND

decode_image:
	; AUX0         MAIN0    AUX1      MAIN1
	; PBBBAAAA    PDDCCCCB  PFEEEEDD  PGGGGFFF

	; reset source pointer

	lda	#$a0
	sta	INH
	lda	#$00
	sta	INL
	sta	LEFT

;	lda	#0	; for(y=0;y<192;y++) {
	sta	YPOS

yloop:
	ldy	YPOS
	lda	hposn_low,Y
	sta	OUTL
	lda	hposn_high,Y
	sta	OUTH		; addr=hgr_offset(y);

	lda	#0		; for(x=0;x<20;x++) {
	sta	XPOS
xloop:

	;=================================
	; get next color from packed area
	;=================================
	; inline
load_colors:
	lda	#0		; need to start with even
	sta	ODD

	ldx	#3

load_color_loop:


get_next_color:

	lda	LEFT
	bne	still_left

	ldy	#0
	lda	(INL),Y
	sta	CURRENT

	inc	INL
	bne	noflo_inl
	inc	INH
noflo_inl:
	ldy	#4
	sty	LEFT

still_left:

	lda	CURRENT
	and	#$3
	tay

	dec	LEFT

	lsr	CURRENT
	lsr	CURRENT

	; color is in Y

color_lookup_smc:
	lda	color_lookup_grey,Y

	ldy	ODD
	bne	odd

even:
	sta	MAIN1,X
	inc	ODD
	cpx	#0
	beq	oog_done		; if x=0 then done
	bne	load_color_loop		; bra

odd:
	dec	ODD
	asl
	asl
	asl
	asl
	ora	MAIN1,X
	sta	MAIN1,X
	dex
	bpl	load_color_loop		; bra

oog_done:
	; set base colors
set_base_colors:

	; skip drawing if out of range

	lda	XPOS
	cmp	XSTART
	bcc	skip_colors
	cmp	XEND
	bcs	skip_colors

do_set_colors:
	; load colors

	; OOG
	; AUX0         MAIN0    AUX1      MAIN1
	; PBBBAAAA    PDDCCCCB  PFEEEEDD  PGGGGFFF

	; MAIN1         AUX1     MAIN0    AUX0
	; PGGGGFFF PFEEEEDD PDDCCCCB PBBBAAAA

	; MAIN1         AUX1     MAIN0    AUX0
	; 0000GGGG FFFFEEEE DDDDCCCC BBBBAAAA
skip_set_colors:
	ldy	#0							; 2

	bit	PAGE2							; 4
	lda	AUX0							; 3
;	and	#$7f							; 2
	sta	(OUTL),Y						; 6

;	rol	AUX0							; 5
	rol								; 2
	rol	MAIN0							; 5
	rol	AUX1							; 5
	rol	MAIN1		; 000GGGGF FFFEEEED DDDCCCCB		; 5
	lda	MAIN0							; 3
;	and	#$7f							; 2
	bit	PAGE1							; 4
	sta	(OUTL),Y						; 6

;	rol	MAIN0							; 5
	rol								; 2
	rol	AUX1							; 5
	rol	MAIN1		; 00GGGGFF FFEEEEDD			; 5
	lda	AUX1							; 3
;	and	#$7f							; 2
	iny								; 2
	bit	PAGE2							; 4
	sta	(OUTL),Y						; 6

;	rol	AUX1							; 5
	rol								; 2
	rol	MAIN1							; 5
	lda	MAIN1							; 3
	bit	PAGE1							; 4
	sta	(OUTL),Y						; 6
									;====
									; 79
	jmp	blah


skip_colors:
	ldy	#0

	bit	PAGE1
	lda	#0
	sta	(OUTL),Y
	iny
	sta	(OUTL),Y

	bit	PAGE2
	ldy	#0
	sta	(OUTL),Y
	iny
	sta	(OUTL),Y

blah:
	inc	OUTL
	inc	OUTL

	; do xloop

	inc	XPOS
	lda	XPOS
	cmp	#20
	beq	xloop_done

	jmp	xloop
;	bne	xloop
xloop_done:


	; do yloop

	inc	YPOS
	lda	YPOS
	cmp	#192
	beq	yloop_done
	jmp	yloop
yloop_done:

	rts






color_lookup_grey:
	.byte 0,5,11,15		; default   black/grey/lblue/white
color_lookup_green:
	.byte 0,2,6,14		; green     black/dgreen/lgreen/yellow
color_lookup_blue:
        .byte 0,1,3,11		; blue      black/dblue/medblue/lblue
color_lookup_red:
        .byte 0,8,9,13		; red       black/red/purple/pink
color_lookup_yellow:
        .byte 0,4,12,14		; yellow    black/brown/orange/yellow

bear_packed_zx02:
	.incbin "bear.packed.zx02"
