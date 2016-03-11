include ../Makefile.inc

all:	asoft_detoken tokenize_asoft integer_detoken asoft_compact

asoft_compact:		asoft_compact.o
			$(CC) $(LFLAGS) -o asoft_compact asoft_compact.o

asoft_compact.o:	asoft_compact.c
			$(CC) $(CFLAGS) -c asoft_compact.c

asoft_detoken:		asoft_detoken.o
			$(CC) $(LFLAGS) -o asoft_detoken asoft_detoken.o

asoft_detoken.o:	asoft_detoken.c
			$(CC) $(CFLAGS) -c asoft_detoken.c

integer_detoken:	integer_detoken.o
			$(CC) $(LFLAGS) -o integer_detoken integer_detoken.o

integer_detoken.o:	integer_detoken.c
			$(CC) $(CFLAGS) -c integer_detoken.c

tokenize_asoft:		tokenize_asoft.o
			$(CC) $(LFLAGS) -o tokenize_asoft tokenize_asoft.o

tokenize_asoft.o:	tokenize_asoft.c
			$(CC) $(CFLAGS) -c tokenize_asoft.c


install:	
		cp asoft_detoken tokenize_asoft integer_detoken $(INSTALL_LOC)

clean:	
		rm -f *~ *.o asoft_detoken tokenize_asoft \
			integer_detoken asoft_compact


