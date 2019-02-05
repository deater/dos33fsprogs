include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	intro_elevator.inc

#####

intro_elevator.inc:	$(PNG2RLE) intro_elevator.png
	$(PNG2RLE) asm intro_elevator.png elevator_rle > intro_elevator.inc

#####

clean:		
		rm -f *~ *.inc
