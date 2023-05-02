include ../../Makefile.inc

all:	text_to_ed


###

text_to_ed:	text_to_ed.o notes.o
	$(CC) -o text_to_ed text_to_ed.o notes.o $(LFLAGS) -lm

text_to_ed.o:	text_to_ed.c notes.h
	$(CC) $(CFLAGS) -c text_to_ed.c

notes.o:	notes.c notes.h
	$(CC) $(CFLAGS) -c notes.c

###

clean:	
	rm -f *~ *.o *.lst text_to_ed

