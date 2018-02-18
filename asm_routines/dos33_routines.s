;     File I/O routines based on sample code in
;       "Beneath Apple DOS" by Don Worth and Pieter Lechner

; FIXME: make these a parameter
disk_buff	EQU	$6000
read_size	EQU	$2A00	; (3*256*14)

;; For the disk-read code
;RWTSH	  EQU $F1
;RWTSL	  EQU $F0
;DOSBUFH	  EQU $EF
;DOSBUFL   EQU $EE
;FILEMH    EQU $ED
;FILEML	  EQU $EC

;; DOS Constants
OPEN     EQU $01
CLOSE    EQU $02
READ     EQU $03
WRITE    EQU $04
DELETE   EQU $05
CATALOG  EQU $06
LOCK     EQU $07
UNLOCK   EQU $08
RENAME   EQU $09
POSITION EQU $0A
INIT     EQU $0B
VERIFY   EQU $0C

LOCATE_FILEM_PARAM EQU $3DC
LOCATE_RWTS_PARAM  EQU $3E3
FILEMANAGER        EQU $3D6


	;================================
	; read from disk
	;================================
	;
	;
read_file:
	jsr     LOCATE_FILEM_PARAM  	; $3DC entry point
					; load file manager param list
					; returns Y=low A=high

	sta	FILEMH
	sty	FILEML

;	ldy	#7	 		; file type offset = 7
;	lda	#0			; 0 = text
;	sta	(FILEML),y

	ldy	#8			; filename ptr offset = 8
	lda	#<filename
	sta	(FILEML),y
	iny
	lda	#>filename
	sta	(FILEML),y

	ldx	#1	 		; open existing file

	jsr	dos33_open		; open file

	jsr	dos33_read		; read buffer

	jsr	dos33_close		; close file

	clc

	rts

;=================================
; get_dos_buffer
;=================================
;
; Dos buffer format
; 0x000-0x0ff = data buffer
; 0x100-0x1ff = t/s list buffer
; 0x200-0x22c = file manager workarea (45 bytes)
; 0x22d-0x24a = file name buffer

; 0x24b-0x24c = address of file manager workarea
; 0x24d-0x24e = address of t/s list buffer
; 0x24f-0x250 = adress of data sector buffer
; 0x251-0x252 = address of file name field for the next buffer

; In DOS, $3D2 points to 0x22d of first buffer
;    add 0x24 to get chain pointer


dos33_open:
	; allocate one of the DOS buffers so we don't have to set them up

allocate_dos_buffer:
	lda     $3D2			; DOS load point
	sta	DOSBUFH
	ldy	#0
	sty	DOSBUFL

buf_loop:
	lda	(DOSBUFL),Y		; locate next buffer
	pha				; push on stack
					; we need this later
					; to test validity

	iny				; increment y
	lda	(DOSBUFL),Y		; load next byte
	sta	DOSBUFH			; store to buffer pointerl

	pla				; restore value from stack

	sta	DOSBUFL			; store to buffer pointerh

	bne	found_buffer		; if not zero, found a buffer

	lda	DOSBUFH			; also if not zero, found a buffer
	bne     found_buffer		; no buffer found, exit

	sec				; failed

	rts

found_buffer:
	ldy  	#0			; get filename
	lda	(DOSBUFL),Y		; get first byte
	beq	good_buffer		; if zero, good buffer

					; in use
	ldy	#$24	   		; point to next
	bne	buf_loop		; and loop

good_buffer:
	lda 	#$78
	sta	(DOSBUFL),Y		; mark as in use (can be any !0)

keep_opening:
	ldy	#0
	lda	#OPEN			; set operation code to OPEN
	sta	(FILEML),y

	ldy	#2	  		; point to record length
	lda	#0			; set it to zero (16-bits)
	sta	(FILEML),y
	iny
	sta	(FILEML),y

	iny		  		; point to volume num (0=any)
	sta	(FILEML),y

	jsr	LOCATE_RWTS_PARAM	; get current RWTS parameters
					; so we can get disk/slot info

	sty	RWTSL
	sta	RWTSH

	ldy	#1
	lda	(RWTSL),y		; get slot*16
	lsr	a
	lsr	a
	lsr	a
	lsr	a			; divide by 16

	ldy	#6			; address of slot
	sta	(FILEML),y		; store it

	ldy	#2
	lda	(RWTSL),y		; get drive
	ldy	#5			; address of drive
	sta	(FILEML),y

filemanager_interface:

	ldy 	#$1E
dbuf_loop:
	lda	(DOSBUFL),y		; get three buffer pointers
	pha				; push onto stack
	iny				; increment pointer
	cpy	#$24			; have we incremented 6 times?
	bcc	dbuf_loop		; if not, loop

	ldy	#$11			; point to the end of the same struct
					; in file manager
fmgr_loop:
	pla				; pop value
	sta	(FILEML),Y		; store it
	dey				; work backwards
	cpy	#$c			; see if we are done
	bcs	fmgr_loop		; loop

	jmp	FILEMANAGER		; #3D6
					; run filemanager
					; will return for us

;====================
; close DOS file
;====================

dos33_close:
        ldy    #0    			; command offset
	lda    #CLOSE			; load close
	sta    (FILEML),y

	jsr    filemanager_interface

	ldy    #0		    	; mark dos buffer as free again
	tya
	sta    (DOSBUFL),y

	rts

;=========================
; read from dos file
;=========================

dos33_read:
        ldy   #0			; command offset
	lda   #READ
	sta   (FILEML),y

	iny   				; point to sub-opcode
	lda   #2			; "range of bytes"
	sta   (FILEML),y

	ldy   #6			; point to number of bytes to read
	lda   #>read_size
	sta   (FILEML),y		; we want to read 255 bytes
	iny
	lda   #<read_size
	sta   (FILEML),y

	ldy   #8			; buffer address
	lda   #<disk_buff
	sta   (FILEML),y
	iny
	lda   #>disk_buff
	sta   (FILEML),y

	bne   filemanager_interface     ; same as JMP

filename:
; OUT.0
.byte 'O'+$80,'U'+$80,'T'+$80,'.'+$80,'0'+$80
.byte $A0,$A0,$A0,$A0,$A0
.byte $A0,$A0,$A0,$A0,$A0
.byte $A0,$A0,$A0,$A0,$A0
.byte $A0,$A0,$A0,$A0,$A0
.byte $A0,$A0,$A0,$A0,$A0
