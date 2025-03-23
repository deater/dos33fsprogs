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
; 0x2380e5 = 2.3s -- optimize xloop
; 0x21b6bc = 2.2s -- output bytes directly

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
	lda	#10
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
	lda	#20
	sta	XEND

	jsr	decode_image

	jsr	wait_until_keypress

	; blue1

	lda	#8
	sta	XSTART
	lda	#20
	sta	XEND

	lda	#<color_lookup_blue
	sta	color_lookup_smc+1
	lda	#>color_lookup_blue
	sta	color_lookup_smc+2

	jsr	decode_image

	jsr	wait_until_keypress

	; blue2

	lda	#8
	sta	XSTART
	lda	#30
	sta	XEND

	jsr	decode_image

	jsr	wait_until_keypress

	; red1

	lda	#18
	sta	XSTART
	lda	#30
	sta	XEND

	lda	#<color_lookup_red
	sta	color_lookup_smc+1
	lda	#>color_lookup_red
	sta	color_lookup_smc+2

	jsr	decode_image

	jsr	wait_until_keypress

	; red2

	lda	#18
	sta	XSTART
	lda	#40
	sta	XEND

	jsr	decode_image

	jsr	wait_until_keypress


	; yellow1

	lda	#28
	sta	XSTART
	lda	#40
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
	sta	packed_load_smc+2
	lda	#$00
	sta	packed_load_smc+1
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

	; load colors


	;=================================
	; get next color from packed area
	;=================================
	; inline
load_colors:

	ldx	#6

load_color_loop:


get_next_color:

	lda	LEFT		; see if any bits left
	bne	still_left

no_bits_left:
packed_load_smc:
	lda	$A000		; load next value
	sta	CURRENT		; save for later

	inc	packed_load_smc+1	; 16-bit increment
	bne	noflo_inl
	inc	packed_load_smc+2
noflo_inl:
	ldy	#4		; reset to 4*2 bits left
	sty	LEFT

still_left:

	lda	CURRENT		; get value
	and	#$3		; only want bottom 2 bits
	tay			; save for later

	dec	LEFT		; decrement left

	lsr	CURRENT		; adjust current value
	lsr	CURRENT
color_lookup_smc:
	lda	color_lookup_grey,Y	; lookup color

	sta	COLORSG,X	; store it out to temp value
	dex
	bpl	load_color_loop

	;==== done inline

	; set base colors
set_base_colors:
	lda	#0
	sta	AUX0
	sta	MAIN0
	sta	AUX1
	sta	MAIN1

	; skip drawing if out of range

	ldy	XPOS
	cpy	XSTART
	bcc	skip_set_colors
	cpy	XEND
	bcs	skip_set_colors

	; AUX0 PBBBAAAA (19)
	; aux0=(colors[0])|((colors[1]&0x7)<<4);

	lda	COLORSB							; 3
	and	#$7							; 2
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
	ora	COLORSA							; 3
;	sta	AUX0							; 3
	bit	PAGE2
;	lda	AUX0
	sta	(OUTL),Y
									;===
									; 19

	; MAIN0 PDDCCCCB (37 -> 27)
	; main0=(colors[1]>>3)|(colors[2]<<1)|((colors[3]&3)<<5);

	lda	COLORSD							; 3
	and	#$3							; 2
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
	ora	COLORSC							; 3
	sta	MAIN0							; 3
	lda	COLORSB							; 3
	cmp	#8		; bit 3 into carry			; 2
	rol	MAIN0							; 3
	bit	PAGE1
	lda	MAIN0
	sta	(OUTL),Y
									;=====
									; 27
	; AUX1 PFEEEEDD (36)
	; aux1=(colors[3]>>2)|(colors[4]<<2)|((colors[5]&1)<<6);

	lda	COLORSF							; 3
	and	#$1							; 2
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
	ora	COLORSE							; 3
	asl								; 2
	asl								; 2
	sta	AUX1							; 3
	lda	COLORSD							; 3
	lsr								; 2
	lsr								; 2
	ora	AUX1							; 3
;	sta	AUX1							; 3
	iny
	bit	PAGE2
;	lda	AUX1
	sta	(OUTL),Y

									;===
									; 36

	; MAIN1 PGGGGFFF (23 -> 19)
	; main1=(colors[5]>>1)|(colors[6]<<3);

	lda	COLORSG							; 3
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
	ora	COLORSF							; 3
	lsr								; 2
;	sta	MAIN1							; 3
	bit	PAGE1
;	lda	MAIN1
	sta	(OUTL),Y
									;====
									; 19

	jmp	continue_xloop

skip_set_colors:

	lda	#0
	bit	PAGE1
	sta	(OUTL),Y
	bit	PAGE2
	sta	(OUTL),Y

	iny
	bit	PAGE1
	sta	(OUTL),Y
	bit	PAGE2
	sta	(OUTL),Y

continue_xloop:
	iny
	sty	XPOS

	; do xloop

	cpy	#40
	beq	xloop_done

	jmp	xloop
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
