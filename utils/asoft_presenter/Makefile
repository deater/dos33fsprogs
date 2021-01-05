include ../../Makefile.inc

all:	asoft_presenter


asoft_presenter:	asoft_presenter.o
			$(CC) $(LFLAGS) -o asoft_presenter asoft_presenter.o

asoft_presenter.o:	asoft_presenter.c
			$(CC) $(CFLAGS) -c asoft_presenter.c


install:	
		cp asoft_presenter $(INSTALL_LOC)

clean:		
		rm -f *~ *.o asoft_presenter



