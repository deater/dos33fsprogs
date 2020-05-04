CC = gcc
CFLAGS = -O2 -Wall -I.. -g

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	hellmood_memories hellmood_gr hellmood_simple

hellmood_memories:	hellmood_memories.o
	$(CC) -o hellmood_memories hellmood_memories.o $(LFLAGS) $(SDL_LIBS)

hellmood_memories.o:	hellmood_memories.c
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c hellmood_memories.c

hellmood_simple:	hellmood_simple.o
	$(CC) -o hellmood_simple hellmood_simple.o $(LFLAGS) $(SDL_LIBS)

hellmood_simple.o:	hellmood_simple.c
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c hellmood_simple.c


hellmood_gr: hellmood_gr.o
	$(CC) $(LFLAGS) -o hellmood_gr hellmood_gr.o $(GR_SIM) $(SDL_LIBS)

hellmood_gr.o:	hellmood_gr.c
	$(CC) $(CFLAGS) -c hellmood_gr.c

clean:	
	rm -f *~ *.o hellmood_memories hellmood_gr hellmood_simple
