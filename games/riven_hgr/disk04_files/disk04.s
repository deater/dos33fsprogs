.include "../zp.inc"
.include "../disk02_files/disk02_defines.inc"
.include "../disk05_files/disk05_defines.inc"
.include "../disk38_files/disk38_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$04		; BCD

which_disk_bin:
	.byte	4

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, BRIDGE1, BRIDGE2, TUNNEL1
	.byte	$40,$40,$40,$40 ; TUNNEL3,TUNNEL4,TUNNEL7

track_array:
	.byte	0, 2, 7,12	; TITLE, BRIDGE1, BRIDGE2, TUNNEL1
	.byte	17,22,28,0	; TUNNEL3,TUNNEL4,TUNNEL7

sector_array:
	.byte	8, 0, 0, 0	; TITLE, BRIDGE1, BRIDGE2, TUNNEL1
	.byte	0,0,0,0		; TUNNEL3,TUNNEL4,TUNNEL7

length_array:
	.byte	8, 80,80,80	; TITLE, BRIDGE1, BRIDGE2, TUNNEL1
	.byte	80,96,96,0	; TUNNEL3,TUNNEL4,TUNNEL7


disk_exit_disk: ; note: not BCD anymore
	.byte	2
	.byte	38
	.byte	5
	.byte	0
	.byte	0
	.byte	0

disk_exit_disk_bcd:
	.byte	$02
	.byte	$38
	.byte	$05
	.byte	0
	.byte	0
	.byte	0


disk_exit_dni_h:
	.byte	0
	.byte	1		; 1*25 + 2*5 + 3*1
	.byte	0
	.byte	0
	.byte	0
	.byte	0

disk_exit_dni_l:
	.byte	$02
	.byte	$23
	.byte	$10
	.byte	0
	.byte	0
	.byte	0

			;
disk_exit_load:
	.byte	LOAD_BRIDGE
	.byte	LOAD_ENTRY
	.byte	LOAD_CHAIR
	.byte	0
	.byte	0
	.byte	LOAD_CYAN
disk_exit_level:
	.byte	RIVEN_BRIDGE
	.byte	RIVEN_DOOR
	.byte	RIVEN_CHAIR
	.byte	0
	.byte	0
	.byte	0

disk_exit_direction:
	.byte	DIRECTION_W
	.byte	DIRECTION_W
	.byte	DIRECTION_N
	.byte	0
	.byte	0
	.byte	0
