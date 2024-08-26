.include "../zp.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$60		; BCD

which_disk_bin:
	.byte	60

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, SPIRES
	.byte	$40,$00,$00,$00 ;

track_array:
	.byte	0, 2, 9,15	; TITLE, SPIRES
	.byte	21,0,0,0	;

sector_array:
	.byte	8, 0, 0, 0	; TITLE, SPIRES
	.byte	0,0,0,0		;

length_array:
	.byte	8,112,96,80	; TITLE, SPIRES
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
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	LOAD_CYAN
disk_exit_level:
	.byte	0
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
