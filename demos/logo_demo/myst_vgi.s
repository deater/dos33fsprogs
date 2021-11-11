; VGI Myst for LOGO demo

;.include "zp.inc"
;.include "hardware.inc"

VGI_BUFFER      = $F0
VGI_TYPE        = $F0
P0              = $F1
P1              = $F2
P2              = $F3
P3              = $F4
P4              = $F5
P5              = $F6
P6              = $F7
VGIL            = $F8
VGIH            = $F9

TEMP0           = $FA
TEMP1           = $FB
TEMP2           = $FC
TEMP3           = $FD
TEMP4           = $FE
TEMP5           = $FF


vgi_myst:

	; swap in ROM

	; READ_ROM_NO_WRITE
        bit     $C08A

	; save ZP
	ldx	#$FF
save_loop:
	lda	$0,X
	sta	vgi_save,X
	dex
	bne	save_loop

	jsr	vgi_make_tables

	lda	#$20
	sta	$E6		 ; setup page1

	; get pointer to image data

	; Rocket

	lda	#<rocket_data
	sta	VGIL
	lda	#>rocket_data
	sta	VGIH

	jsr	play_vgi

	; restore ZP

	ldx	#$FF
restore_loop:
	lda	vgi_save,X
	sta	$00,X

	dex
	bne	restore_loop


	; restore settings

	; READ_RAM1_WRITE_RAM1

	bit	$C08B
	bit	$C08B


	rts


.include "vgi_common.s"

.include "rocket.data"

vgi_save = $a00

