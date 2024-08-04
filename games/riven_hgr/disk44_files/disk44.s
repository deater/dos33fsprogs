.include "../zp.inc"
.include "../disk43_files/disk43_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$44		; BCD

which_disk_bin:
	.byte	44

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, FISH, PATH
	.byte	$40,$00,$00,$00 ;

track_array:
	.byte	0, 2, 8,14	; TITLE, FISH, PATH
	.byte	20,0,0,0	;

sector_array:
	.byte	8, 0, 0, 0	; TITLE, FISH, PATH
	.byte	0,0,0,0		;

length_array:
	.byte	8, 96,96, 96	; TITLE, FISH, PATH
	.byte	96,0,0,0

	; disk 44

disk_exit_disk: ; note: not BCD anymore
	.byte	43
	.byte	43
	.byte	0
	.byte	0
	.byte	0
	.byte	0

disk_exit_disk_bcd:
	.byte	$43
	.byte	$43
	.byte	0
	.byte	0
	.byte	0
	.byte	0



disk_exit_dni_h:
	.byte	$01		; 43 = 1*25 + 3*5 + 3
	.byte	$01
	.byte	0
	.byte	0
	.byte	0
	.byte	0
disk_exit_dni_l:
	.byte	$33
	.byte	$33
	.byte	0
	.byte	0
	.byte	0
	.byte	0

			;
disk_exit_load:
	.byte	LOAD_LOGGED4
	.byte	LOAD_LOGGED3
	.byte	0
	.byte	0
	.byte	0
	.byte	LOAD_CYAN
disk_exit_level:
	.byte	RIVEN_LOGGED4
	.byte	RIVEN_LOGGED3
	.byte	0
	.byte	0
	.byte	0
	.byte	0
disk_exit_direction:
	.byte	DIRECTION_W
	.byte	DIRECTION_E
	.byte	0
	.byte	0
	.byte	0
	.byte	0

