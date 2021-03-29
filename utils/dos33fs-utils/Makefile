include ../../Makefile.inc

all:	dos33 mkdos33fs make_b \
	dos33_raw \
	dos33_text2ascii char2hex


char2hex:		char2hex.o
			$(CC) -o char2hex char2hex.o $(LFLAGS)

char2hex.o:		char2hex.c
			$(CC) $(CFLAGS) -c char2hex.c

###

dos33:			dos33.o \
			dos33_catalog.o \
			dos33_vtoc_bitmap.o
			$(CC) -o dos33 dos33.o \
				dos33_catalog.o \
				dos33_vtoc_bitmap.o $(LFLAGS)

dos33.o:		dos33.c dos33.h
			$(CC) $(CFLAGS) -g -c dos33.c

###

dos33_raw:		dos33_raw.o
			$(CC) -o dos33_raw dos33_raw.o $(LFLAGS)

dos33_raw.o:		dos33_raw.c
			$(CC) $(CFLAGS) -g -c dos33_raw.c

###

dos33_text2ascii:	dos33_text2ascii.o
			$(CC) -o dos33_text2ascii dos33_text2ascii.o $(LFLAGS)

dos33_text2ascii.o:	dos33_text2ascii.c
			$(CC) $(CFLAGS) -c dos33_text2ascii.c

###

make_b:			make_b.o
			$(CC) -o make_b make_b.o $(LFLAGS)

make_b.o:		make_b.c
			$(CC) $(CFLAGS) -c make_b.c

###

mkdos33fs:		mkdos33fs.o dos33_vtoc_bitmap.o
			$(CC) $(LFLAGS) -o mkdos33fs mkdos33fs.o \
				dos33_vtoc_bitmap.o

mkdos33fs.o:		mkdos33fs.c dos33.h
			$(CC) $(CFLAGS) -c mkdos33fs.c

###

dos33_vtoc_bitmap.o:		dos33_vtoc_bitmap.c dos33.h
			$(CC) $(CFLAGS) -c dos33_vtoc_bitmap.c

###

dos33_catalog.o:		dos33_catalog.c dos33.h
			$(CC) $(CFLAGS) -c dos33_catalog.c

###


install:	
		cp dos33 dos33_raw mkdos33fs make_b dos33_text2ascii char2hex $(INSTALL_LOC)

clean:		
		rm -f *~ *.o dos33 dos33_raw mkdos33fs make_b dos33_text2ascii char2hex
		cd tests && make clean
