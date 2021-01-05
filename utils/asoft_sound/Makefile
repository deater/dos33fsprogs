include ../Makefile.inc

all:	asoft_sound

asoft_sound:		asoft_sound.o
			$(CC) $(LFLAGS) -o asoft_sound asoft_sound.o

asoft_sound.o:	asoft_sound.c
			$(CC) $(CFLAGS) -c asoft_sound.c


install:	
		cp asoft_sound $(INSTALL_LOC)

clean:	
		rm -f *~ *.o asoft_sound
