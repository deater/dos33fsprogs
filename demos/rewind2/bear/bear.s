.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"

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

	; setup source pointer

	lda	#$a0
	sta	INH
	lda	#$00
	sta	INL
	sta	LEFT

	lda	#0
	sta	XSTART
	lda	#100
	sta	XEND

	jsr	decode_image

	bit	PAGE1

	jsr	wait_until_keypress

	rts

	;==================================
	; decode image
	;==================================
	; TODO: setup palette
	; set XSTART, XEND

decode_image:
	; AUX0         MAIN0    AUX1      MAIN1
	; PBBBAAAA    PDDCCCCB  PFEEEEDD  PGGGGFFF


	lda	#0	; for(y=0;y<192;y++) {
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

	ldx	#0
load_color_loop:
	jsr	get_next_color
	sta	COLORS0,X
	inx
	cpx	#7
	bne	load_color_loop

	; set base colors
set_base_colors:
	lda	#0
	sta	AUX0
	sta	MAIN0
	sta	AUX1
	sta	MAIN1

	; skip drawing if out of range

	lda	XPOS
	cmp	XSTART
	bcc	skip_set_colors
	cmp	XEND
	bcs	skip_set_colors

	lda	COLORS0
	sta	AUX0
	lda	COLORS1
	and	#$7
	asl
	asl
	asl
	asl
	ora	AUX0
	sta	AUX0	; aux0=(colors[0])|((colors[1]&0x7)<<4);

	lda	COLORS1
	lsr
	lsr
	lsr
	sta	MAIN0
	lda	COLORS2
	asl
	ora	MAIN0
	sta	MAIN0
	lda	COLORS3
	and	#$3
	asl
	asl
	asl
	asl
	asl
	ora	MAIN0
	sta	MAIN0	; main0=(colors[1]>>3)|(colors[2]<<1)|((colors[3]&3)<<5);

	lda	COLORS3
	lsr
	lsr
	sta	AUX1
	lda	COLORS4
	asl
	asl
	ora	AUX1
	sta	AUX1
	lda	COLORS5
	and	#$1
	asl
	asl
	asl
	asl
	asl
	asl
	ora	AUX1
	sta	AUX1	; aux1=(colors[3]>>2)|(colors[4]<<2)|((colors[5]&1)<<6);

	lda	COLORS5
	lsr
	sta	MAIN1

	lda	COLORS6
	asl
	asl
	asl
	ora	MAIN1
	sta	MAIN1	; main1=(colors[5]>>1)|(colors[6]<<3);

skip_set_colors:
	bit	PAGE1
	ldy	#0
	lda	MAIN0
	sta	(OUTL),Y
	iny
	lda	MAIN1
	sta	(OUTL),Y

	bit	PAGE2
	ldy	#0
	lda	AUX0
	sta	(OUTL),Y
	iny
	lda	AUX1
	sta	(OUTL),Y

	inc	OUTL
	inc	OUTL

	; do xloop

	inc	XPOS
	lda	XPOS
	cmp	#20
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


	;=================================
	; get next color from packed area
	;=================================
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

	lda	color_lookups,Y

	rts



color_lookups:
	.byte 0,5,11,15		; default   black/grey/lblue/white
	.byte 0,2,6,14		; green     black/dgreen/lgreen/yellow
        .byte 0,1,3,11		; blue      black/dblue/medblue/lblue
        .byte 0,8,9,13		; red       black/red/purple/pink
        .byte 0,4,12,14		; yellow    black/brown/orange/yellow

bear_packed_zx02:
	.incbin "bear.packed.zx02"
