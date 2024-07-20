.include "../zp.inc"
.include "../disk43_files/disk43_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$50		; BCD

which_disk_bin:
	.byte	50

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, START
	.byte	$40,$00,$00,$00 ;

track_array:
	.byte	0, 2, 9,16	; TITLE, START
	.byte	22,0,0,0	;

sector_array:
	.byte	8, 0, 0, 0	; TITLE, START
	.byte	0,0,0,0		;

length_array:
	.byte	8, 96,84, 96	; TITLE, START
	.byte	80,0,0,0

	; disk 50

disk_exit_disk: ; note: not BCD anymore
	.byte	0
	.byte	0
	.byte	0
	.byte	0

disk_exit_disk_bcd: ; note: not BCD anymore
	.byte	0
	.byte	0
	.byte	0
	.byte	0


disk_exit_dni_h:
	.byte	0		; 41 = 1*25 + 3*5 + 1
	.byte	0
	.byte	0
	.byte	0
disk_exit_dni_l:
	.byte	0
	.byte	0
	.byte	0
	.byte	0

			;
disk_exit_load:
	.byte	0
	.byte	0
	.byte	0
	.byte	LOAD_CYAN
disk_exit_level:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
disk_exit_direction:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
