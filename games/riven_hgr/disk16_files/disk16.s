.include "../zp.inc"
.include "../disk10_files/disk10_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$16		; BCD

which_disk_bin:
	.byte	16

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, BRIDGE, BRIDGE2, DOME
	.byte	$40,$00,$00,$00 ;

track_array:
	.byte	0, 2, 9,15	; TITLE, BRIDGE, BRIDGE2, DOME
	.byte	21,0,0,0	;

sector_array:
	.byte	8, 0, 0, 0	; TITLE, BRIDGE, BRIDGE2, DOME
	.byte	0,0,0,0		;

length_array:
	.byte	8,112,96,80	; TITLE, BRIDGE, BRIDGE2, DOME
	.byte	80,0,0,0


disk_exit_disk: ; note: not BCD anymore
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0

disk_exit_disk_bcd:
	.byte	$10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0


disk_exit_dni_h:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0

disk_exit_dni_l:
	.byte	$20
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0

			;
disk_exit_load:
	.byte	LOAD_32
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	LOAD_CYAN
disk_exit_level:
	.byte	RIVEN_32
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
disk_exit_direction:
	.byte	DIRECTION_N
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
