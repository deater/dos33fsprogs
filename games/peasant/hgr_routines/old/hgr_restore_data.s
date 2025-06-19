	; background restore parameters
	; currently 5, should check this and error if we overflow

save_valid:
	.byte   0, 0, 0, 0, 0, 0
save_xstart:
	.byte   0, 0, 0, 0, 0, 0
save_xend:
	.byte   0, 0, 0, 0, 0, 0
save_ystart:
	.byte   0, 0, 0, 0, 0, 0
save_yend:
	.byte   0, 0, 0, 0, 0, 0
