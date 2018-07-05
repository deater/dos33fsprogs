.include "zp.inc"

	H2	= $2C
;	V2	= $2D
;	TEMPY	= $FB

	HGR	= $F3E2
	HPLOT0	= $F457
	HCOLOR	= $F6EC
;	HLINE	= $F819
;	VLINE	= $F828
;	COLOR	= $F864
;	TEXT 	= $FB36
;	HOME	= $FC58

	jsr	TEXT
	jsr	HOME

	lda	#0
	sta	DISP_PAGE
	lda	#0
	sta	DRAW_PAGE

	lda	#0
	sta	CH
	sta	CV
	lda	#<line1
	sta	OUTL
	lda	#>line1
	sta	OUTH
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	; draw the moon
	lda	#0
	sta	CV
	lda	#3
	sta	CH
	jsr	htab_vtab	; vtab(1); htab(4)
	lda	#32	; inverse space
	ldy	#0
	sta	(BASL),Y

	inc	CV
	dec	CH
	jsr	htab_vtab
	lda	#32
	ldy	#0
	sta	(BASL),Y

	inc	CV
	jsr	htab_vtab
	lda	#32
	ldy	#0
	sta	(BASL),Y

	inc	CV
	inc	CH
	jsr	htab_vtab
	lda	#32
	ldy	#0
	sta	(BASL),Y

	; Wait

	jsr	wait_until_keypressed

	; GR part
	bit	LORES
	bit	SET_GR
	bit	FULLGR

	lda	#$44
	sta	COLOR

	lda	#39
	sta	V2

	lda	#28

line_loop:
	pha

	ldy	#0

	jsr	hlin_double

	pla
	clc
	adc	#2
	cmp	#48
	bne	line_loop

	; Wait

	jsr	wait_until_keypressed

	bit	HIRES


	; Wait

	jsr	wait_until_keypressed

	;=====================================================
	; attempt vapor lock
	;  by reading the "floating bus" we can see most recently
	;  written value of the display
	; we look for $44 (which is the green grass on low-res)
	;=====================================================
	; See:
	; 	Have an Apple Split by Bob Bishop
	; 	Softalk, October 1982

	; Challenges: each scan line scans 40 bytes.
	; The blanking happens at the *beginning*
	; So 65 bytes are scanned, starting at adress of the line - 25

	; the scan takes 8 cycles, look for 4 repeats of the value
	; to avoid false positive found if the horiz blanking is mirroring
	; the line (max 3 repeats in that case)

vapor_lock_loop:
	LDA #$44
zloop:
	LDX #$04
qloop:
	CMP $C051
	BNE zloop
	DEX
	BNE qloop

	; found first line of low-res green, need to kill time
	; until we can enter at top of screen
	; so we want roughly 5200+4550 - 65 (for the scanline we missed)

	; want 9685
	; Try X=34 Y=55 cycles=9681

	lda	#0							; 2
	lda	#0							; 2

	ldy	#55							; 2
loopA:
	ldx	#34							; 2
loopB:
	dex								; 2
	bne	loopB							; 2nt/3

	dey								; 2
	bne	loopA							; 2nt/3

	;=====================================================
	;=====================================================
	; Loop forever display loop
	;=====================================================
	;=====================================================
display_loop:
	; each scan line 65 cycles
	;	1 cycle each byte (40cycles) + 25 for horizontal
	;	Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	;	16666     = 17030      x=1021.8
	;         1000        x


	; TODO: find beginning of scan
	;	Text mode for 6*8=48 scanlines (3120 cycles)
	;	hgr for 64 scalines (4160 cycles)
	;	gr for 80 scalines (5200 cycles)
	;	vblank = 4550 cycles

	; text
	bit	SET_TEXT						; 4

	; want 3120-4 = 3116 cycles
	; inner loop = 2+(x*5)-1 = 5x+1
	; outer loop = 2+(y*5+y*inner)-1 = 1+5y+y*(5x+1)
	;			1+5y+5xy+y
	;			1+6y+5xy
	;			1+y(6+5x)

	; Try X=11 Y=51 cycles=3112 (R 4)

	lda	#0							; 2
	lda	#0							; 2


	ldy	#51							; 2
loop2:
	ldx	#11							; 2
loop1:
	dex								; 2
	bne	loop1							; 2nt/3

	dey								; 2
	bne	loop2							; 2nt/3

;=============================================

	; hgr
	bit	HIRES							; 4
	bit	SET_GR							; 4


	; want 4160-8 = 4152 cycles
	;			1+y(6+5x)
	; Try X=91 Y=9 cycles=4150, R2

	lda	#0							; 2



	ldy	#9							; 2
loop3:
	ldx	#91							; 2
loop4:
	dex								; 2
	bne	loop4							; 2nt/3

	dey								; 2
	bne	loop3							; 2nt/3

;===========================================================================


	; gr
	bit	LORES							; 4

	; want 5200 - 4 = 5196 cycles
	;			1+y(6+5x)
	; Try X=17 Y=57 cycles=5188, R8


	lda	#0							; 2
	lda	#0							; 2
	lda	#0							; 2
	lda	#0							; 2

	ldy	#57							; 2
loop5:
	ldx	#17							; 2
loop6:
	dex								; 2
	bne	loop6							; 2nt/3

	dey								; 2
	bne	loop5							; 2nt/3

;========================================================================

	; vertical blank

	; want 4550-3 = 4547 cycles
	;			1+y(6+5x)

	; Try X=13 Y=64 cycles=4545 R2


	; DRAW SPRITES
	; do this during blanking interval

	lda	#>blob					; 2
	sta	INH					; 3
	lda	#<blob					; 2
	sta	INL					; 3

	lda	#17					; 2
	sta	XPOS					; 3
	lda	#30					; 2
	sta	YPOS					; 3

        jsr     put_sprite				; 6
							;=========
							; 26

							; + 672
							;========
							; 698

	; blob= 698
	; 4547 - 698
	; 3849 is new number
	; Try X=58 Y=13 cycles=3849





;	lda	#0							; 2
;	lda	#0							; 2

	ldy	#13							; 2
loop7:
	ldx	#58							; 2
loop8:
	dex								; 2
	bne	loop8							; 2nt/3

	dey								; 2
	bne	loop7							; 2nt/3

	jmp	display_loop						; 3

wait_until_keypressed:
	lda	KEYPRESS			; check if keypressed
	bpl	wait_until_keypressed		; if not, loop
	bit	KEYRESET
	rts




	;=============================================
	; put_sprite
	;=============================================
	; Sprite to display in INH,INL
	; Location is XPOS,YPOS
	; Note, only works if YPOS is multiple of two


	; time= 28 setup
	;    Y*outerloop
	;    outerloop = 34 setup
	;	X*innerloop
	;	innerloop = 30 if $00 17+13(done)
	;		    54 if if $XX 16+8+8+9(put_all)+13(done)
	;		    68 if $X0 16+8+7+5+19(put_sprite_mask)+13(done)
	;		    63 if $0X 16+7+8+19(put_sprite_mask)+13(done)
	;       -1 for last iteration
	;    18 (-1 for last)
	;     6 return

	; so cost = 28 + Y*(34+18)+ (INNER-X) -1 + 6
	;         = 33 + Y*(52)+(INNER-X)
	;	  = 33 + Y*(52)+ [30A + 54B + 68C + 63D]-X

	; blob, x=3, y=3, B=9
	;	33 + 3*(52)+[54*9]-3 = 672

	; bird_stand_right = X=6, Y=7 A=28 B=9 C=2 D=3
	;	= 33 + 7*53+(30*28+53*9+68*2+63*3)-6 = 2040 cycles
put_sprite:

	ldy	#0		; byte 0 is xsize			; 2
	lda	(INL),Y							; 5
	sta	CH		; xsize is in CH			; 3
	iny								; 2

	lda	(INL),Y		; byte 1 is ysize			; 5
	sta	CV		; ysize is in CV			; 3
	iny								; 2

	lda	YPOS		; make a copy of ypos			; 3
	sta	TEMPY		; as we modify it			; 3
								;===========
								;	28
put_sprite_loop:
	sty	TEMP		; save sprite pointer			; 3
	ldy	TEMPY							; 3
	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	clc								; 2
	adc	XPOS		; add in xpos				; 3
	sta	OUTL		; store out low byte of addy		; 3
	lda	gr_offsets+1,Y	; look up high byte			; 4
	adc	DRAW_PAGE	;					; 3
	sta	OUTH		; and store it out			; 3
	ldy	TEMP		; restore sprite pointer		; 3

				; OUTH:OUTL now points at right place

	ldx	CH		; load xsize into x			; 3
								;===========
								;	34
put_sprite_pixel:
	lda	(INL),Y			; get sprite colors		; 5
	iny				; increment sprite pointer	; 2

	sty	TEMP			; save sprite pointer		; 3
	ldy	#$0							; 2

	; check if completely transparent
	; if so, skip

	cmp	#$0			; if all zero, transparent	; 2
	beq	put_sprite_done_draw	; don't draw it			; 2nt/3
								;==============
								;	 16/17

	sta	COLOR			; save color for later		; 3

	; check if top pixel transparent

	and	#$f0			; check if top nibble zero	; 2
	bne	put_sprite_bottom	; if not skip ahead		; 2nt/3
								;==============
								;	7/8

	lda	#$f0			; setup mask			; 2
	sta	MASK							; 3
	bmi	put_sprite_mask		; always?			; 3
								;=============
								;	  8

put_sprite_bottom:
	lda	COLOR			; re-load color			; 3
	and	#$0f			; check if bottom nibble zero	; 2
	bne	put_sprite_all		; if not, skip ahead		; 2nt/3
								;=============
								;	7/8

	lda	#$0f							; 2
	sta	MASK			; setup mask			; 3

put_sprite_mask:
	lda	(OUTL),Y		; get color at output		; 5
	and	MASK			; mask off unneeded part	; 3
	ora	COLOR			; or the color in		; 3
	sta	(OUTL),Y		; store it back			; 6

	jmp	put_sprite_done_draw	; we are done			; 3

put_sprite_all:
	lda	COLOR			; load color			; 3
	sta	(OUTL),Y		; and write it out		; 6
								;============
								;	  9

put_sprite_done_draw:

	ldy	TEMP			; restore sprite pointer	; 3

	inc	OUTL			; increment output pointer	; 5
	dex				; decrement x counter		; 2
	bne	put_sprite_pixel	; if not done, keep looping	; 2nt/3
								;==============
								;	12/13

	inc	TEMPY			; each line has two y vars	; 5
	inc	TEMPY							; 5
	dec	CV			; decemenet total y count	; 5
	bne	put_sprite_loop		; loop if not done		; 2nt/3
								;==============
								;	17/18

	rts				; return			; 6






line1:.asciiz	"   *                            .      "
line2:.asciiz	"  *    .       T A L B O T          .  "
line3:.asciiz	"  *           F A N T A S Y            "
line4:.asciiz	"   *            S E V E N              "
line5:.asciiz	" .                          .    .     "
line6:.asciiz	"             .                         "

.include "../asm_routines/gr_offsets.s"
.include "../asm_routines/text_print.s"
.include "../asm_routines/gr_hlin_double.s"
.include "tfv_sprites.inc"

.align	$1000

.incbin	"KATC.BIN"
