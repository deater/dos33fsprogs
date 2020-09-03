test_entry:


load_new = $119D
load_address=$11C0
load_track=load_address+1
load_sector=load_address+2
load_length=load_address+3

	; make sure we are in 40col mode
	; with monitor I/O working

	jsr	$FE89		; SETKBD (simulate keypress?)
	jsr	$FE93		; SETVID (simulate video output?)
	jsr	$FB2F		; INIT (clear screen/etc)
	jsr	$FE84		; SETNORM (set normal video)
	jsr	$FC58		; HOME	(clear screen)


	;=============================
	; print title
	;=============================
	lda	#<message1
	sta	print_smc+1
	lda	#>message1
	sta	print_smc+2
	jsr	print_message

	; wait for keypress

	jsr	$fd0c		; RDKEY


	;=============================
	; print reading disk1 message
	;=============================
	lda	#<message2
	sta	print_smc+1
	lda	#>message2
	sta	print_smc+2
	jsr	print_message

	; wait for keypress

;	jsr	$fd0c		; RDKEY

	;================================
	; read t0/s0 into c0
	;================================

	lda	#$c
	sta	load_address
	lda	#$00
	sta	load_track
	lda	#$00
	sta	load_sector
	lda	#$1
	sta	load_length

	jsr	load_new


	lda	$c00
	and	#$f
	clc
	adc	#'0'
	sta	message3+15

	lda	$c00
	lsr
	lsr
	lsr
	lsr
	and	#$f
	clc
	adc	#'0'
	sta	message3+14



	;=============================
	; print read1 result message
	;=============================
	lda	#<message3
	sta	print_smc+1
	lda	#>message3
	sta	print_smc+2
	jsr	print_message

	; wait for keypress

	jsr	$fd0c		; RDKEY

	;=============================
	; print insert disk2 message
	;=============================
	lda	#<message4
	sta	print_smc+1
	lda	#>message4
	sta	print_smc+2
	jsr	print_message

	; wait for keypress

	jsr	$fd0c		; RDKEY

	;===============================
	; print read disk2 try1 message
	;===============================
	lda	#<message5
	sta	print_smc+1
	lda	#>message5
	sta	print_smc+2
	jsr	print_message


	lda	#$c
	sta	load_address
	lda	#$00
	sta	load_track
	lda	#$00
	sta	load_sector
	lda	#$1
	sta	load_length

	jsr	load_new


	lda	$c00
	and	#$f
	clc
	adc	#'0'
	sta	message6+15

	lda	$c00
	lsr
	lsr
	lsr
	lsr
	and	#$f
	clc
	adc	#'0'
	sta	message6+14


	;=============================
	; print result2 message
	;=============================
	lda	#<message6
	sta	print_smc+1
	lda	#>message6
	sta	print_smc+2
	jsr	print_message

	lda	$c00
	cmp	#$20
	beq	no_bug_found

	;=============================
	; print bug found
	;=============================
	lda	#<message9
	sta	print_smc+1
	lda	#>message9
	sta	print_smc+2
	jsr	print_message

no_bug_found:


	; wait for keypress

	jsr	$fd0c		; RDKEY

	;===============================
	; print read disk2 try2 message
	;===============================
	lda	#<message7
	sta	print_smc+1
	lda	#>message7
	sta	print_smc+2
	jsr	print_message


	lda	#$c
	sta	load_address
	lda	#$00
	sta	load_track
	lda	#$00
	sta	load_sector
	lda	#$1
	sta	load_length

	jsr	load_new


	lda	$c00
	and	#$f
	clc
	adc	#'0'
	sta	message8+15

	lda	$c00
	lsr
	lsr
	lsr
	lsr
	and	#$f
	clc
	adc	#'0'
	sta	message8+14


	;=============================
	; print result3 message
	;=============================
	lda	#<message8
	sta	print_smc+1
	lda	#>message8
	sta	print_smc+2
	jsr	print_message



	;============================
	; forever
	;============================
forever:
	jmp	forever

	;============================
	; print message
	;============================

print_message:

	ldx	#$00		; loop either 256 chars or until hit zero
loop1:
print_smc:
	lda	message1,X
	beq	done1
	ora	#$80
	jsr	$FDED		; COUT
	inx
	bne	loop1
done1:
	rts


message1:
	.byte   "TESTING DISK-SWITCH BUG",$0d
	.byte	"=======================",$0d,$0d,0

message2:
	.byte	"READING DISK1 T0:S0 TO $C00",$0d,$0d,0

message3:
	.byte	"  BYTE 0 WAS $GG (EXPECTED $01)",$0d,$0d,0

message4:
	.byte	"PLEASE PUT IN DISK2",$0d,$0d,0

message5:
	.byte	"READING DISK2 T0:S0 TO $C00",$0d,$0d,0

message6:
	.byte	"  BYTE 0 WAS $GG (EXPECTED $20)",$0d,$0d,0

message7:
	.byte	"READING DISK2 T0:S0 TO $C00 AGAIN",$0d,$0d,0

message8:
	.byte	"  BYTE 0 WAS $GG (EXPECTED $20)",$0d,$0d,0

message9:
	.byte	"*** BUG FOUND ***",$0d,$0d,0
