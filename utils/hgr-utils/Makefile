include ../../Makefile.inc

CFLAGS = -O2 -Wall -g

all:	pcx2hgr png2hgr png2dhgr shape_table dump_table \
	hgr2png hgr_make_sprite dhgr_make_sprite \
	png2font dhgr2png \
	png2tiles png2largefont png2dhgr4 png2dhgr_raw

###

dump_table:		dump_table.o
			$(CC) -o dump_table dump_table.o $(LFLAGS)

dump_table.o:		dump_table.c
			$(CC) $(CFLAGS) -c dump_table.c
###

shape_table:		shape_table.o
			$(CC) -o shape_table shape_table.o $(LFLAGS)

shape_table.o:		shape_table.c
			$(CC) $(CFLAGS) -c shape_table.c

pcx2hgr:		pcx2hgr.o
			$(CC) -o pcx2hgr pcx2hgr.o $(LFLAGS)

pcx2hgr.o:		pcx2hgr.c
			$(CC) $(CFLAGS) -c pcx2hgr.c
###

png2hgr:		png2hgr.o
			$(CC) -o png2hgr png2hgr.o $(LFLAGS) -lpng

png2hgr.o:		png2hgr.c
			$(CC) $(CFLAGS) -c png2hgr.c

###

png2tiles:		png2tiles.o
			$(CC) -o png2tiles png2tiles.o $(LFLAGS) -lpng

png2tiles.o:		png2tiles.c
			$(CC) $(CFLAGS) -c png2tiles.c


###

png2font:		png2font.o
			$(CC) -o png2font png2font.o $(LFLAGS) -lpng

png2font.o:		png2font.c
			$(CC) $(CFLAGS) -c png2font.c

###

png2largefont:		png2largefont.o
			$(CC) -o png2largefont png2largefont.o $(LFLAGS) -lpng

png2largefont.o:		png2largefont.c
			$(CC) $(CFLAGS) -c png2largefont.c



###

hgr_make_sprite:		hgr_make_sprite.o
			$(CC) -o hgr_make_sprite hgr_make_sprite.o $(LFLAGS) -lpng

hgr_make_sprite.o:		hgr_make_sprite.c
			$(CC) $(CFLAGS) -c hgr_make_sprite.c

###

dhgr_make_sprite:		dhgr_make_sprite.o
			$(CC) -o dhgr_make_sprite dhgr_make_sprite.o $(LFLAGS) -lpng

dhgr_make_sprite.o:		dhgr_make_sprite.c
			$(CC) $(CFLAGS) -c dhgr_make_sprite.c



###

hgr2png:		hgr2png.o
			$(CC) -o hgr2png hgr2png.o $(LFLAGS) -lpng

hgr2png.o:		hgr2png.c
			$(CC) $(CFLAGS) -c hgr2png.c

###

dhgr2png:		dhgr2png.o
			$(CC) -o dhgr2png dhgr2png.o $(LFLAGS) -lpng

dhgr2png.o:		dhgr2png.c
			$(CC) $(CFLAGS) -c dhgr2png.c

###

png2dhgr:		png2dhgr.o
			$(CC) -o png2dhgr png2dhgr.o $(LFLAGS) -lpng

png2dhgr.o:		png2dhgr.c
			$(CC) $(CFLAGS) -c png2dhgr.c

###

png2dhgr_raw:		png2dhgr_raw.o
			$(CC) -o png2dhgr_raw png2dhgr_raw.o $(LFLAGS) -lpng

png2dhgr_raw.o:		png2dhgr_raw.c
			$(CC) $(CFLAGS) -c png2dhgr_raw.c


###

png2dhgr4:		png2dhgr4.o
			$(CC) -o png2dhgr4 png2dhgr4.o $(LFLAGS) -lpng

png2dhgr4.o:		png2dhgr4.c
			$(CC) $(CFLAGS) -c png2dhgr4.c




install:	
		cp pcx2hgr shape_table png2hgr hgr2png hgr_make_sprite png2font png2largefont $(INSTALL_LOC)

clean:		
		rm -f *~ *.o pcx2hgr shape_table dump_table \
			png2hgr png2dhgr png2dhgr_raw hgr2png \
			dhgr_make_sprite hgr_make_sprite \
			png2font png2tiles png2largefont dhgr2png png2dhgr4

