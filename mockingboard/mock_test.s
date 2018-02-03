; http://macgui.com/usenet/?group=2&id=8366

; Mockingboad programming:
; + Has two 6522 I/O chips
; + Often in slot 4

; $C400  ORB1  function to perform, OUT 1
; $C401  ORA1  data, OUT 1
; $C402  DDRB1 data direction, OUT 1
; $C403  DDRA1 data direction, OUT 1

; $C480  ORB2  function to perform, OUT 2
; $C481  ORA2  data, OUT 2
; $C482  DDRB2 data direction, OUT 2
; $C483  DDRA2 data direction, OUT 2

; To Initialize the 6522s: Store $FF at the DDRxx addresses

; Your program gets access to a PSG via the 6522 by using a few basic
; Function codes which set the PSG's I/O control lines:
;
;  Set Inactive = $04  Set PSG Reg# = $07   Write Data = $06   Reset = $00
;
; To Write to a PSG register: Tell the PSG which Register you wish to access
; (i.e. Set the "current register" #) and Write the data. This is easiest to
; do with subroutines to handle the basic Functions.
;
; Example Subroutines (for Output Channel 1):
;
; Set Reg #     1000:  A9 07   8D 00 C4   A9 04   8D 00 C4   60
; Write Data    100B:  A9 06   8D 00 C4   A9 04   8D 00 C4   60

; Notice that each Function sub ends by setting the PSG control lines to
; Inactive.
; Similarly, to do a Reset (set all PSG regs to zero) ...

; Reset           1016:  A9 00   8D 00 C4   A9 04   8D 00 C4   60

; To put the value $55 in PSG Register 02 (Channel B Freq. fine) ....

; 1080: A9 02         put Reg#  in A
; 1082: 8D 01 C4    store A at the Data address ORA1
; 1085: 20 00 10     JSR to Set Reg#  (sets "current register" to Register
; 2)
; 1088: A9 55         put the value $55 in A
; 108A: 8D 01 C4    store A at the Data address ORA1
; 108D: 20 0B 10    JSR to Write Data  ($55 goes into PSG Register 2)
; 1090: 60              Exit from subroutine

.include	"zp.inc"

	;=============================
	; set low-res graphics, page 0
	;=============================
	jsr     HOME
	jsr     TEXT

forever_loop:
	jmp	forever_loop

.include	"ksptheme_uncompressed.inc"
