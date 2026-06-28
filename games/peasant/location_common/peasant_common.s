; some common actions that are needed in all the peasantry levels


; + kerrek body countdown
; + rain-storm count down

; + haystack check		(nope!  only needed at 4 locations)
; + night-time count down	(nope!  it's geography based not time based)

	;======================================================

check_common_entry:


	; only happens if INV1_KERREK_BELT and KERREK_STATE low bits <15
kerrek_body_countdown:
	lda	INVENTORY_1
	and	#INV1_KERREK_BELT
	beq	kerrek_body_countdown_done

	lda	KERREK_STATE
	and	#$f
	cmp	#15
	bcs	kerrek_body_countdown_done

	inc	KERREK_STATE

kerrek_body_countdown_done:

	rts



