;========================================================================
; EVERYTHING IS CYCLE COUNTED
;========================================================================

; Note, can save cycles if we don't have early-exit (check)
; also if we don't have to convert from 1.77

; the logic here:
;
; if (current_line==0) && (subframe==0) {
;	set_pattern();
;; }
; if (subframe==0) {
;	decode_line();
; }
; else {
; }
; if (pattern_done) {
;    
; }
; subframe++;
; if (subframe==speed) {
;	subframe=0;
;	current_line++;
;	if (current_line==64) {
;		pattern++;
;		current_line=0;
;	}
; }

	;=====================================
	;=====================================
	;=====================================
	; pt3 make frame
	;=====================================
	;=====================================
	;=====================================

	; update pattern or line if necessary
	; then calculate the values for the next frame

	; 8+373=381


	; Paths
	;
	;	A (current_line)
	;
	;	B (current subframe)
	;
	;	C (pattern_done)
	;
	;	D (always)
	;
	;	F
	;
	;	C

	;=============================
	; State A
	;=============================
pt3_make_frame:
	; see if we need a new pattern
	; we do if line==0 and subframe==0
	; allow fallthrough where possible
current_line_smc:
	lda	#$d1							; 2
	beq	check_subframe						; 3
									; -1

	;=============================
	; State B
	;=============================
	;
pattern_good:
	; see if we need a new line

current_subframe_smc:
	lda	#$d1							; 2
	bne	line_good						; 3
									; -1

	;=============================
	; State C
	;=============================
	;
pt3_new_line:
	; decode a new line
	jsr	pt3_decode_line						; 6+?

	; check if pattern done early

pt3_pattern_done_smc:
	lda	#$d1							; 2

	bne	line_good						; 2/3

	;=============================
	; State D
	;=============================

	;==========================
	; pattern done early!

early_end:
	; A is pattern_done which is zero at this point
	inc	current_pattern_smc+1   ; increment pattern		; 6
	sta	current_line_smc+1					; 4
	sta	current_subframe_smc+1					; 4

	; always goes to set_pattern here?

	jmp	set_pattern						; 3

	;=============================
	; State E
	;=============================
check_subframe:
	lda	current_subframe_smc+1					; 4
	bne	pattern_good						; 2/3


	;=============================
	; State F
	;=============================
set_pattern:
	; load a new pattern in
	jsr	pt3_set_pattern						;6+?

	jmp	pt3_new_line						; 3

	;=============================
	; State D
	;=============================
	;

line_good:

	; Increment everything

	inc	current_subframe_smc+1	; subframe++			; 6
	lda	current_subframe_smc+1					; 4

	; if we hit pt3_speed, move to next
pt3_speed_smc:
	eor	#$d1							; 2

	bne	do_frame						; 3
									; -1

	;=============================
	; State G
	;=============================
	;

next_line:
	sta	current_subframe_smc+1	; reset subframe to 0		; 4

	inc	current_line_smc+1	; and increment line		; 6
	lda	current_line_smc+1					; 4

	eor	#64			; always end at 64.		; 2
	bne	do_frame		; is this always needed?	; 2/3

next_pattern:
	sta	current_line_smc+1	; reset line to 0		; 4

	inc	current_pattern_smc+1	; increment pattern		; 6



;==============================================
; falls through to do_frame
