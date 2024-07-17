.include "../zp.inc"
.include "../disk01_files/disk01_defines.inc"
.include "disk00_defines.inc"

which_disk_bcd:
	.byte	$00		; BCD

which_disk_bin:
	.byte	0

load_address_array:
	.byte	$40,$40,$40,$60	; TITLE, CYAN, ATRUS, CAPTURED
	.byte	$40,$40,$00,$00	; CHO, START

track_array:
        .byte	0, 2, 10,18	; TITLE, CYAN, ATRUS, CAPTURED
	.byte	26,31,0,0	; CHO, START

sector_array:
        .byte	8, 0, 0, 0	; TITLE, CYAN, ATRUS, CAPTURED
	.byte	0,0,0,0		; CHO, START
length_array:
        .byte	8, 127,127,80	; TITLE, CYAN, ATRUS, CAPTURED
	.byte	80,64,0,0	; CHO. START


disk_exit_disk: ; note: not BCD anymore
	.byte 1		; start of game
	.byte 0
	.byte 0
	.byte 0
disk_exit_disk_bcd:
	.byte $01		; start of game
	.byte 0
	.byte 0
	.byte 0
disk_exit_dni_h:
	.byte $00		; 01 = 1
	.byte 0
	.byte 0
	.byte 0
disk_exit_dni_l:
	.byte $01
	.byte 0
	.byte 0
	.byte 0

	; want to go to disk01, LOAD_ARRIVAL, RIVEN_ARRIVAL_NEAR, N

disk_exit_load:
	.byte LOAD_ARRIVAL	; LOAD_ARRIVAL
	.byte 0
	.byte 0
	.byte LOAD_CYAN
disk_exit_level:
	.byte 1			; RIVEN_ARRIVAL_NEAR
	.byte 0
	.byte 0
	.byte 0
disk_exit_direction:
	.byte DIRECTION_N
	.byte 0
	.byte 0
	.byte 0
