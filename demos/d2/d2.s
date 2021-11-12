; HGR Demo2

; by deater (Vince Weaver) <vince@deater.net>

; 1484

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

d2:

	;===================
	; music Player Setup


	lda	#<peasant_song
	sta	SONG_L
	lda	#>peasant_song
	sta	SONG_H

	; assume mockingboard in slot#4

	; TODO: inline?

	jsr	mockingboard_init



	;================================
	; Clear screen and setup graphics
	;================================

	jsr	HGR2		; set hi-res 140x192, page2, fullscreen
				; A and Y both 0 at end

	sty	FRAME		; start at 0

	;==================
	; create sinetable

	;ldy	#0		; Y is 0
sinetable_loop:
	tya							; 2
	and	#$3f	; wrap sine at 63 entries		; 2

	cmp	#$20
	php		; save pos/negative for later

	and	#$1f

	cmp	#$10
	bcc	sin_left		; blt

sin_right:
	; sec	carry should be set here
	eor	#$FF
	adc	#$20			; 32-X
sin_left:
	tax
	lda	sinetable_base,X				; 4+

	plp
	bcc	sin_done

sin_negate:
	; carry set here
	eor	#$ff
	adc	#0

sin_done:
	sta	sinetable,Y

	iny
	bne	sinetable_loop

	; NOTE: making gbash/gbasl table wasn't worth it


	;=====================
	; setup credits
	; TODO: inline?

	jsr	print_message



	;==========================
	; beginning of demo
	;==========================


	jsr	dsr_spin

	; start music, no music for spin

start_interrupts:
	cli

forever:
	;=====================
	; orange/green effect

	jsr	moving

	;=====================
	; clear screen

	jsr	fast_hclr

	jsr	flip_page

	;=====================
	; wires effect

	jsr	wires

	;=====================
	; oval effect

	jsr	oval

	;=====================
	; repeat

	bit	TEXTGR

	jmp	forever



	;===========================
	; common flip page routine

flip_page:
	ldy	#$0
        lda     HGR_PAGE        ; will be $20/$40
        cmp     #$20
        beq     done_flip_page
        iny
done_flip_page:
        ldx     PAGE1,Y     ; set display page to PAGE1 or PAGE2

        eor     #$60            ; flip draw page between $2000/$4000
        sta     HGR_PAGE

        rts

	;===================
	; print message
	;===================
print_message:

	; TODO: inline?

	jsr	clear_both_bottoms

	ldx	#12
print_message_loop:
	lda	message1,X
	sta	$6d2,X
	sta	$Ad2,X
	lda	message2,X
	sta	$6ea,X
	sta	$Aea,X
	dex
	bpl	print_message_loop

	rts


;      01234567890123456789012345678901234567890"
;message1:
;.byte "THE APPLE II HAS NO PALETTE ROTATION"
;message2:
;.byte "WE ARE DOING THIS THE HARD WAY...   "

.macro hiasc str
.repeat .strlen(str),I
.byte .strat(str,I) | $80
.endrep
.endmacro

message1:
hiasc "CODE:  DEATER"
message2:
hiasc "MUSIC: MA2E  "

.include	"dsr_shape.s"
.include	"moving.s"
.include	"wires.s"
.include	"oval.s"
.include	"clear_bottom.s"

; music
.include	"mA2E_2.s"
.include        "interrupt_handler.s"
; must be last
.include        "mockingboard_setup.s"
