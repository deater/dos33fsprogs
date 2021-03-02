;2?CHR$(27)
;3N$=CHR$(14):I$=CHR$(15):B$=CHR$(8):F$=CHR$(10)+B$+B$+B$+B$+B$+B$
;4GOSUB8:?"_____ "F$B$I$"ZA----_"F$B$I$"Z"N$"  o "I$"S_"F$B$I$"Z"N$"__|__"I$"_"N$
;6GOSUB8:?N$"____ "F$I$"Z"N$" =='"I$"_"F$I$"Z"N$"_"I$" \T_"N$
;7GOTO4
;8VTAB1+RND(1)*20:HTABRND(1)*70:RETURN


CH	= $24
CV	= $25

COUT	= $FDED
COUT1	= $FDF0
COUTZ	= $FDF6		; cout but ignore inverse flag

floppy:

	jsr	$C300		; enable 80-column card firmware

	lda	#27		; enable mouse text
	jsr	COUT

	lda	#5
	sta	CH
	sta	CV

	ldx	#0
big_loop:
	lda	big_floppy,X
	beq	big_done
	ora	#$80
	jsr	COUT
	inx
	bne	big_loop
big_done:

	lda	#10
	sta	CH
	sta	CV

	ldx	#0
small_loop:
	lda	small_floppy,X
	beq	small_done
	ora	#$80
	jsr	COUT
	inx
	bne	small_loop
small_done:

done:
	jmp	done


big_floppy:
	.byte 10,"_____ "
	.byte 10,8,8,8,8,8,8,8
	.byte 15,"ZA----_"
	.byte 10,8,8,8,8,8,8,8
	.byte 15,"Z",14,"  o ",15,"S_"
	.byte 10,8,8,8,8,8,8,8
	.byte 15,"Z",14,"__|__",15,"_",14
	.byte 0

small_floppy:
	.byte 10,14,"____ "
	.byte 10,8,8,8,8,8,8
	.byte 15,"Z",14," =='",15,"_"
	.byte 10,8,8,8,8,8,8
	.byte 15,"Z",14,"_",15," \T_",14
	.byte 0
