CC = gcc
AS = as
LD = ld
ASFLAGS = --32
CFLAGS = -O2 -Wall
LFLAGS =

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`


all:	autumn autumn_asm hellmood_autumn

#

hellmood_autumn:	hellmood_autumn.o
	$(CC) $(LFLAGS) -o hellmood_autumn hellmood_autumn.o $(SDL_LIBS)

hellmood_autumn.o:	hellmood_autumn.c
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c hellmood_autumn.c

#

autumn:	autumn.o
	$(CC) $(LFLAGS) -o autumn autumn.o

autumn.o:	autumn.c
	$(CC) $(CFLAGS) -c autumn.c

#
autumn_asm:	autumn_asm.o
	$(LD) -m elf_i386 -o autumn_asm autumn_asm.o

autumn_asm.o:	autumn_asm.s
	$(AS) $(ASFLAGS) -o autumn_asm.o autumn_asm.s


#
clean:	
	rm -f *~ *.o autumn hellmood_autumn autumn_asm
