include ../../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk
PICTUREDSK = ~/research/picturedsk.git/picturedsk
LINKER_SCRIPTS = ../../linker_scripts/

all:	make_points d.inc e.inc s.inc i.inc r.inc


####

d.inc:	make_points d.points
	./make_points < d.points 14 77 > d.inc

e.inc:	make_points e.points
	./make_points < e.points 220 77 > e.inc

s.inc:	make_points s.points
	./make_points < s.points 108 77 > s.inc

i.inc:	make_points i.points
	./make_points < i.points 154 77 > i.inc

r.inc:	make_points r.points
	./make_points < r.points 176 77 > r.inc

####

make_points:	make_points.o
	$(CC) -o make_points make_points.o

make_points.o:	make_points.c
	$(CC) $(CFLAGS) -c make_points.c

####

clean:	
	rm -f *~ *.o make_points *.inc
