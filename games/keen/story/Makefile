CFLAGS = -Wall -O2 -g
LFLAGS =

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	story_data.zx02

story_data.zx02:	story_data.out
	$(ZX02) story_data.out story_data.zx02

story_data.out:	story.txt make_story
	./make_story < story.txt > story_data.out

make_story:	make_story.o
	$(CC) $(LFLAGS) -o make_story make_story.c

make_story.o:	make_story.c
	$(CC) $(CFLAGS) -c make_story.c

clean:	
	rm -f *~ *.o make_story story_data.out story_data.zx02
