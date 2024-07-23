.include "../zp.inc"
.include "../disk43_files/disk43_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$44		; BCD

which_disk_bin:
	.byte	44

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, FISH
	.byte	$40,$00,$00,$00 ;

track_array:
	.byte	0, 2, 9,16	; TITLE, FISH
	.byte	22,0,0,0	;

sector_array:
	.byte	8, 0, 0, 0	; TITLE, FISH
	.byte	0,0,0,0		;

length_array:
	.byte	8, 96,84, 96	; TITLE, FISH
	.byte	80,0,0,0

	; disk 44

disk_exit_disk: ; note: not BCD anymore
	.byte	0
	.byte	0
	.byte	0
	.byte	0

disk_exit_disk_bcd:
	.byte	0
	.byte	0
	.byte	0
	.byte	0


disk_exit_dni_h:
	.byte	$01		; 43 = 1*25 + 3*5 + 3
	.byte	0
	.byte	0
	.byte	0
disk_exit_dni_l:
	.byte	$33
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
