
	.byte	1		; number of sectors for ROM to load

wboot_entry:
	ldx	$2B		; load slot into X
				; possibly unnecessary, already there?

	lda	$C088,X		; turn off drive motor

	; put $CX00 in $10:$11, where X is slot
	; allows rebooting later

	txa
	lsr
	lsr
	lsr
	lsr
	ora	#$c0
	sta	$11

	lda	#$00
	sta	$10

	; make sure we are in 40col mode
	; with monitor I/O working

	jsr	$FE89		; SETKBD (simulate keypress?)
	jsr	$FE93		; SETVID (simulate video output?)
	jsr	$FB2F		; INIT (clear screen/etc)
	jsr	$FE84		; SETNORM (set normal video)
	jsr	$FC58		; HOME	(clear screen)

	; print our message

	ldx	#$00		; loop either 256 chars or until hit zero
loop:
	lda	message,X
	beq	done
	ora	#$80
	jsr	$FDED		; COUT
	inx
	bne	loop
done:

	; wait for keypress

	jsr	$fd0c		; RDKEY

	; resboot from current disk (set earlier)
	jmp	($0010)

message:
	.byte	$0D,$0D,$0D,$0D,$0D
	.byte	"        APPLE II MYST - DISK 3",$0D,$0D,$0D
	.byte	"         PLEASE INSERT DISK 1",$0D,$0D
	.byte	"        PRESS ANY KEY TO REBOOT",$0D
	.byte	$00

