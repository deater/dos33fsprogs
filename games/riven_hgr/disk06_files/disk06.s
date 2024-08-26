.include "../zp.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$06		; BCD

which_disk_bin:
	.byte	6

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, ATRUS, 
	.byte	$40,$00,$00,$00 ;

track_array:
	.byte	0, 2, 8,15	; TITLE, ATRUS, 
	.byte	22,0,0,0	;

sector_array:
	.byte	8, 0, 0, 0	; TITLE, ATRUS,
	.byte	0,0,0,0		;

length_array:
	.byte	8, 96,112,80	; TITLE, ATRUS, 
	.byte	80,0,0,0


disk_exit_disk: ; note: not BCD anymore
	.byte	4
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0

disk_exit_disk_bcd:
	.byte	$04
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
	.byte	0
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
	.byte	DIRECTION_E
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
