include ../Makefile.inc

all:	png2gr

png2gr:		png2gr.o
			$(CC) $(LFLAGS) -lpng -o png2gr png2gr.o

png2gr.o:		png2gr.c
			$(CC) $(CFLAGS) -c png2gr.c


install:	
		cp png2gr $(INSTALL_LOC)

clean:		
		rm -f *~ *.o png2gr


