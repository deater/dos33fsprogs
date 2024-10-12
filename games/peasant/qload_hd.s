qload_hd:

	; set up prodos entry

	lda	UNIT		;
	ldy	#0

setup_loop:
	lsr
	lsr
	lsr
	lsr
	and	#7
	ora	#$c0
	sta	slot_smc+2
	sta	entry_smc+2	; set up smartport/prodos entry point
	sta	entry2_smc+2	; set up smartport/prodos entry point

slot_smc:
	lda	$cfff
	sta	entry_smc+1	; set up rest of smartport/prodos entry
	sta	entry2_smc+1	; set up rest of smartport/prodos entry


	; init the write code if needed
	; ???

	lda	#1
	sta	CURRENT_DISK

	lda	#LOAD_VID_LOGO
	sta	WHICH_LOAD

main_game_loop:
	jsr	load_file_internal

entry_point_smc:
	jsr	$6000			; most entry points currently $6000

	; CHECK LEVEL_OVER
	;	if high bit set, jump to change_disk

;	lda	LEVEL_OVER
;	bmi	change_disk

	jmp	main_game_loop


	;====================================
	; loads file specified by WHICH_LOAD
	;====================================
load_file_internal:
	ldx	WHICH_LOAD

	lda	load_address_array,X
	sta	ADRHI
	sta	entry_point_smc+2

	lda	which_disk_array,X		; CURRENT DISK
	sta	CURRENT_DISK

	sta	BLOKHI
	inc	BLOKHI		; off by one
	lda	track_array,X	; track
	asl
	asl
	asl
	rol	BLOKHI
	sta	BLOKLO
	lda	sector_array,X	; sector
	lsr			; divide by 2
	clc
	adc	BLOKLO
	sta	BLOKLO


	lda	length_array,X
	clc
	adc	#1
	lsr			; important! blocks=sectors/2
				; need to round up if it was odd
				; careful: this could over-write if not careful
	sta	COUNT

	jsr	seekread

	rts	; todo: tail call

	;===================================================
	;===================================================
	; change disk
	;===================================================
	;===================================================
	; LEVEL_OVER bottom 4 bits hold which exit

	; for hard disk image no need to change

change_disk:

	;==============================================
	; all good, continue
update_disk:

	jmp	main_game_loop




	;================================
	; seek + read blocks
	;================================
	; this calls the smartport PRODOS entrypoint
	;	command=1 READBLOCK
	;	I can't find this documented anywhere
	;	but the paramaters are stored in the zero page
	;================================
	; BLOKHI:BLOKLO = block number to load (???)
	; COUNT = num blocks
seekread:

seekread_loop:
	lda	#1		; READBLOCK
	sta	COMMAND
	lda	ADRHI
	pha
entry_smc:
	jsr	$d1d1
	pla
	sta	ADRHI

	inc	ADRHI		; twice, as 512 byte chunks
	inc	ADRHI

	inc	BLOKLO		; increment block pointer
	bne	no_blokloflo
	inc	BLOKHI
no_blokloflo:


	dec	COUNT
	bne	seekread_loop

	rts


	;=============================
	; do_savegame
	;=============================
	; hack, 512 bytes at $BC00
	; to disk0/track0/sector12 (which is just "6" for us)
do_savegame:
	lda	#$0
	sta	BLOKHI
	sta	ADRLO
	lda	#$6
	sta	BLOKLO
	lda	#$BC
	sta	ADRHI
	lda	#$1
	sta	COUNT

; fallthrough

	;================================
	; seek + write blocks
	;================================
	; this calls the smartport PRODOS entrypoint
	;	command=2 WRITEBLOCK
	;	I can't find this documented anywhere
	;	but the paramaters are stored in the zero page
	;================================
	; BLOKHI:BLOKLO = block number to store (???)
	; COUNT = num blocks
seekwrite:

seekwrite_loop:
	lda	#2		; WRITEBLOCK
	sta	COMMAND
	lda	ADRHI
	pha
entry2_smc:
	jsr	$d1d1
	pla
	sta	ADRHI

	inc	ADRHI		; twice, as 512 byte chunks
	inc	ADRHI

	inc	BLOKLO		; increment block pointer
	bne	no_sblokloflo
	inc	BLOKHI
no_sblokloflo:


	dec	COUNT
	bne	seekwrite_loop

	rts

