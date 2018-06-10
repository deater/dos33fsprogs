CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`

GR_SIM = ../gr-sim.a

all:	bounce fixed_point lookup_tables mode7_demo text_demo


####

fixed_point:	fixed_point.o
	$(CC) $(LFLAGS) -o fixed_point fixed_point.o

fixed_point.o:	fixed_point.c
	$(CC) $(CFLAGS) -c fixed_point.c

####

lookup_tables:	lookup_tables.o
	$(CC) $(LFLAGS) -o lookup_tables lookup_tables.o

lookup_tables.o:	lookup_tables.c
	$(CC) $(CFLAGS) -c lookup_tables.c

###

mode7_demo:	mode7_demo.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o mode7_demo mode7_demo.o \
		$(GR_SIM)

mode7_demo.o:	mode7_demo.c
	$(CC) $(CFLAGS) -c mode7_demo.c


###

text_demo:	text_demo.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o text_demo text_demo.o $(GR_SIM)

text_demo.o:	text_demo.c
	$(CC) $(CFLAGS) -c text_demo.c

####

clean:	
	rm -f *~ *.o bounce fixed_point lookup_tables mode7_demo text_demo

