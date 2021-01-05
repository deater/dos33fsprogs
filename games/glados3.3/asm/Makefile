all:	STILL_ALIVE.BIN

STILL_ALIVE.BIN:	still_alive.o
	ld65 -o STILL_ALIVE.BIN still_alive.o -C ./apple2_c00.inc

still_alive.o:	still_alive.s
	ca65 -o still_alive.o still_alive.s -l still_alive.lst

clean:          
	rm -f *.lst *.o *~ STILL_ALIVE.BIN speaker_timing


