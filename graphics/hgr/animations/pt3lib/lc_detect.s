; Code from TotalReplay by 4am and qkumba

;------------------------------------------------------------------------------
; Has64K
; Checks whether computer has functioning language card (64K)
;
; in:    none
; out:   C clear if 64K detected
;        C set if 64K not detected
;        all other flags and registers clobbered
;        ROM in memory (not LC RAM bank)
;------------------------------------------------------------------------------

detect_language_card:

	; enable language card
	; READ_RAM1_WRITE_RAM1

	bit	$C08B
	bit	$C08B

	lda	#$AA			; test #1 for $D0 page
	sta	$D000
	eor	$D000
	bne	no_lc
	lsr	$D000			; test #2 for $D0 page
	lda	#$55
	eor	$D000
	bne	no_lc
	clc
	bcc	done_detect

no_lc:
	sec

done_detect:
	; READ_ROM_NO_WRITE
	bit	$C08A

	rts
