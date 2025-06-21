
        ;=======================
	; draw header offscreen
	;=======================

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

        ; put peasant text

        lda     #<peasant_text
        sta     OUTL
        lda     #>peasant_text
        sta     OUTH

        jsr     hgr_put_string

	; update / print score

	jsr	update_score

	jsr	print_score

	; show prompt

	jsr	setup_prompt


	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE



	;====================================
	; check if allowed to be in haystack

	jsr	check_haystack_exit


	;==========================
	; load updated verb table

	; setup default verb table

	jsr     setup_default_verb_table

	lda	#<VERB_TABLE
	sta	INL
	lda	#>VERB_TABLE
	sta	INH

	jsr	load_custom_verb_table


	;================================
	; setup pointer to update_screen

	lda	#<update_screen
	sta	update_screen_smc+1
	lda	#>update_screen
	sta	update_screen_smc+2

