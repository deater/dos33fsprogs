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

	;===================
	; print message
	;===================
print_message:

.include	"clear_bottom.s"

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


	;==========================
	; beginning of demo
	;==========================


.include	"dsr_shape.s"

	; start music, no music for spin

start_interrupts:
	cli

forever:
	;=====================
	; orange/green effect

.include "moving.s"

	;=====================
	; clear screen

	jsr	fast_hclr

	jsr	flip_page

	;=====================
	; wires effect

.include "wires.s"

;	jsr	wires

	;=====================
	; oval effect

;	jsr	oval

.include "oval.s"

	;=====================
	; repeat

	; switch things up for the second round

	lda	#$7f
	sta	color_smc+1
	lda	#159
	sta	moving_size_smc+1
	sta	oval_size_smc+1
	lda	#<colorlookup2
	sta	colorlookup_smc+1

	; make split screen so credits are visible

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



shape_dsr:
.byte   $2d,$36,$ff,$3f
.byte   $24,$ad,$22,$24,$94,$21,$2c,$4d
.byte   $91,$3f,$36,$00

even_lookup:
.byte   $D7,$DD,$F5, $D5,$D5,$D5,$D5
odd_lookup:
.byte   $AA,$AA,$AA, $AB,$AE,$BA,$EA

colorlookup2:
.byte $11,$55,$5d,$7f,$5d,$55,$11,$00

colorlookup:
.byte $22,$aa,$ba,$ff,$ba,$aa,$22       ; use 00 from sinetable

sinetable_base:
; this is actually (32*sin(x))
.byte $00,$03,$06,$09,$0C,$0F,$11,$14
.byte $16,$18,$1A,$1C,$1D,$1E,$1F,$1F
.byte $20

sinetable=$8000

; music
.include	"mA2E_2.s"
.include        "interrupt_handler.s"
; must be last
.include        "mockingboard_setup.s"
