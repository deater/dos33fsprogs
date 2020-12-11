; Draw Status Bar

update_status_bar:
	rts

draw_status_bar:

	jsr	inverse_text
	lda	#<help_string
	sta	OUTL
	lda	#>help_string
	sta	OUTH
	jsr	move_and_print
	jsr	normal_text
	jsr	move_and_print
	jsr	move_and_print

	jsr	inverse_text
	jsr	move_and_print

	rts


help_string:
	.byte 3,20,"        PRESS 'H' FOR HELP        ",0

score_string:
	;           012456789012345678901234567890123456789
	.byte 0,22,"SCORE   HEALTH   FIREPOWER    INVENTORY",0
	.byte 0,23,"00010  XXXXXXXX  =-=-                  ",0
	.byte 7,23,"        ",0
