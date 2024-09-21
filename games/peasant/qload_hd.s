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

slot_smc:
	lda	$cfff
	sta	entry_smc+1	; set up rest of smartport/prodos entry


	; init the write code if needed
	; ???

	lda	#0
	sta	CURRENT_DISK

	lda	#LOAD_VID_LOGO
	sta	WHICH_LOAD

main_game_loop:
	jsr	load_file

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
load_file:
	ldx	WHICH_LOAD

	lda	load_address_array,X
	sta	ADRHI
	sta	entry_point_smc+2

	lda	CURRENT_DISK
	sta	BLOKHI
	inc	BLOKHI		; off by one
	lda	track_array,X	; track
	asl
	asl
	asl
	rol	BLOKHI
	sta	BLOKLO
	lda	sector_array,X	; sector
	lsr
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

change_disk:

;	lda	LEVEL_OVER
;	and	#$f
;	sta	LEVEL_OVER
;	tax

	; set up locations
;	lda	DISK_EXIT_DISK,X
;	sta	CURRENT_DISK

;	lda	DISK_EXIT_LOAD,X
;	sta	WHICH_LOAD
;	lda	DISK_EXIT_LEVEL,X
;	sta	LOCATION
;	lda	DISK_EXIT_DIRECTION,X
;	sta	DIRECTION

;	lda	DISK_EXIT_DNI_H,X
;	sta	NUMBER_HIGH
;	lda	DISK_EXIT_DNI_L,X
;	sta	NUMBER_LOW


	; see if disk we want is in drive


	;==========================
	; load QLOAD table
	;	check if disk matches
;verify_disk:

;	jsr	load_qload_offsets



	;==============================================
	; all good, continue
update_disk:

	jmp	main_game_loop



.if 0
load_qload_offsets:
	lda	#$12
	sta	ADRHI

	lda	CURRENT_DISK
	sta	BLOKHI
	inc	BLOKHI		; off by one
	lda	#0		; track
	asl
	asl
	asl
	rol	BLOKHI
	sta	BLOKLO
	lda	#$2		; sector
	lsr
	clc
	adc	BLOKLO
	sta	BLOKLO

;	lda	#$0
;	sta	load_track

;	lda	#$02		; track 0 sector 2
;	sta	load_sector

	lda	#$1
	sta	COUNT

	jmp	seekread

.endif

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
