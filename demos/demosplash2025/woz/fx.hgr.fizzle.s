;license:MIT
;(c) 2017-2021 by qkumba/4am/John Brooks

; vmw - convert to ca65, de-macro a bit

	; original copied to 0 page for speed
	; we don't really need that much speed here?
	; also we need the zero page

do_wipe_fizzle:

	; OVERCOPY_TO_0 start, end
	;$FF clobbered
	;X=0
	;Y=0
	;jmp   loop

;start:
;.org $00
;!pseudopc 0 {
         ;X=0
         ;Y=0

	ldx	#0
	ldy	#0

fizzle_loop:
	txa
fizzle_loop1:
	eor	#$1B                  ; LFSR form 0x1B00 with period 8191
fwait:
	dex
	bne	fwait
	tax
fizzle_loop2:
	txa
	ora	#$20		; change high dest page (page1)
	sta	dst+2
	eor	#$60
	sta	src+2		; change high src page (page2)
	jsr	src		; copies from page2 to page1

	txa
	lsr
	tax
	tya
	ror
	tay
	bcc	fizzle_loop2
	bne	fizzle_loop
	bit	KEYPRESS
	bmi	fexit
	txa
	bne	fizzle_loop1

src:
	lda	$FD00, Y		; SMC high byte
dst:
	sta	$FD00, Y		; SMC high byte
fexit:
	rts

