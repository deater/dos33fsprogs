;=====================================
; Rasterbars in Space (Title Screen)
;
; a cycle-counting racing-the-beam game
;
; by deater (Vince Weaver) <vince@deater.net>
;=====================================

; Zero Page
.include "zp.inc"

; hardware addresses/soft_switches
.include "hardware.inc"

.include "qload.inc"



	;==================
	; show title screen
	;==================
view_title:

	jsr	title_screen

	;==================
	; Display Text
	;==================

	jsr	instructions

	rts



	;================================
	; Show the title screen
	; return when a key is pressed
	;================================



title_screen:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE

	;=============================
	; Load title graphic page1

	lda	#<spacebars_title_low
	sta	zx_src_l+1
	lda	#>spacebars_title_low
	sta	zx_src_h+1

	lda	#$0c			;  to $c00

	jsr	zx02_full_decomp


;	lda	#$0c
;	sta	BASH
;	lda	#$00
;	sta	BASL                    ; load image to $c00

;	lda	#<spacebars_title_low
;	sta	GBASL
;	lda	#>spacebars_title_low
;	sta	GBASH
;	jsr	load_rle_gr

	lda	#4
	sta	DRAW_PAGE

	jsr	gr_copy_to_current	; copy to page2

	; GR part
	bit	PAGE2
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	;=============================
	; Load graphic page2


	lda	#<spacebars_title_high
	sta	zx_src_l+1
	lda	#>spacebars_title_high
	sta	zx_src_h+1

	lda	#$0c			;  to $c00

	jsr	zx02_full_decomp


;	lda	#$0c
;	sta	BASH
;	lda	#$00
;	sta	BASL                    ; load image to $c00

;	lda	#<spacebars_title_high
;	sta	GBASL
;	lda	#>spacebars_title_high
;	sta	GBASH
;	jsr	load_rle_gr

	lda	#0
	sta	DRAW_PAGE

	; GR part
	bit	PAGE1


	;==============================
	; setup graphics for vapor lock
	;==============================
	jsr	vapor_lock

	; found first line of black after green, at up to line 26 on screen
        ; so we want roughly 22 lines * 4 = 88*65 = 5720 + 4550 = 10270
	; - 65 (for the scanline we missed) = 10205 - 12 = 10193

	jsr	gr_copy_to_current		; 6+ 9292
	; 10193 - 9298 = 895
	; Fudge factor (unknown) -30 = 865

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	; Try X=88 Y=2 cycles=893 R2

	nop
        ldy     #2							; 2
loopA:
        ldx	#88							; 2
loopB:
        dex                                                             ; 2
        bne     loopB                                                   ; 2nt/3

        dey                                                             ; 2
        bne     loopA                                                   ; 2nt/3

        jmp     display_loop
.align  $100


	;================================================
	; Display Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; We want to alternate between page2 and page2 every 65 cycles
        ;       vblank = 4550 cycles to do scrolling


	; 2 + 48*(  (4+2+25*(2+3)) + (4+2+23*(2+3)+4+5)) + 9)
	;     48*[(6+125)-1] + [(6+115+10)-1]

display_loop:

	ldy	#96						; 2

outer_loop:

	bit	PAGE1						; 4
	ldx	#12		; 65 cycles with PAGE1		; 2
page1_loop:			; delay 61+bit
	dex							; 2
	bne	page1_loop					; 2/3


	; bit(4) -1(fallthrough) + loop*5 -1(fallthrouh)+4 extra = 61
	; 5L = 55

	bit	PAGE2						; 4
	ldx	#11		; 65 cycles with PAGE2		; 2
				;
page2_loop:			; delay 115+(7 loop)+4 (bit)+4(extra)
	dex							; 2
	bne	page2_loop					; 2/3

	dey							; 2
	bne	outer_loop					; 2/3



	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be      4550+1 -2-9 -7= 4533

	jsr	do_nothing				; 6

	lda	KEYPRESS				; 4
	bpl	no_keypress				; 3
	jmp	return
no_keypress:

	jmp	display_loop				; 3



	;=================================
	; do nothing
	;=================================
	; and take 4533-6 = 4527 cycles to do it
do_nothing:

	; Try X=4 Y=174 cycles=4525 R2

	nop	; 2

	ldy	#174							; 2
loop1:
	ldx	#4							; 2
loop2:
	dex								; 2
	bne	loop2							; 2nt/3

	dey								; 2
	bne	loop1							; 2nt/3

return:
	rts								; 6


.include "gr_simple_clear.s"
;.include "keypress.s"
.include "gr_copy.s"

.include "instructions.s"
.align $100
.include "vapor_lock.s"
.include "delay_a.s"

spacebars_title_low:
.incbin "graphics/sb_title_low.zx02"
spacebars_title_high:
.incbin "graphics/sb_title_high.zx02"

