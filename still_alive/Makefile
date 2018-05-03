include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33

all:	still_alive.dsk

still_alive.dsk:	STILL_ALIVE ./SA.KRW
	$(DOS33) -y still_alive.dsk BSAVE -a 0x0C00 STILL_ALIVE
	$(DOS33) -y still_alive.dsk SAVE B ./SA.KRW

STILL_ALIVE:	still_alive.o
	ld65 -o STILL_ALIVE still_alive.o -C ../linker_scripts/apple2_c00.inc

still_alive.o:	still_alive.s \
	../asm_routines/mockingboard.s \
	../asm_routines/dos33_routines.s \
	../asm_routines/lz4_decode.s \
	../asm_routines/keypress_minimal.s \
	interrupt_handler.s \
	ascii_art.inc zp.inc
	ca65 -o still_alive.o still_alive.s -l still_alive.lst

clean:	
	rm -f *~ *.o *.lst STILL_ALIVE
