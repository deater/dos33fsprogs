CC = gcc
CFLAGS = -O2 -Wall
LFLASG =

all: 6502_table table_gen z80_volume c_tone 6502_tone

###

6502_table:	6502_table.o
	$(CC) $(LFLASG) -o 6502_table 6502_table.o

6502_table.o:	6502_table.c
	$(CC) $(CFLAGS) -c 6502_table.c

###

6502_tone:	6502_tone.o
	$(CC) $(LFLASG) -o 6502_tone 6502_tone.o

6502_tone.o:	6502_tone.c
	$(CC) $(CFLAGS) -c 6502_tone.c

###

table_gen:	table_gen.o
	$(CC) $(LFLAGS) -o table_gen table_gen.o

table_gen.o:	table_gen.c
	$(CC) $(CFLAGS) -c table_gen.c

###

z80_volume:	z80_volume.o
	$(CC) $(LFLAGS) -o z80_volume z80_volume.o

z80_volume.o:	z80_volume.c
	$(CC) $(CFLAGS) -c z80_volume.c

###

z80_tone:	z80_tone.o
	$(CC) $(LFLAGS) -o z80_tone z80_tone.o

z80_tone.o:	z80_tone.c
	$(CC) $(CFLAGS) -c z80_tone.c

###

c_tone:	c_tone.o
	$(CC) $(LFLAGS) -o c_tone c_tone.o

c_tone.o:	c_tone.c
	$(CC) $(CFLAGS) -c c_tone.c


###

clean:	
	rm -f *~ *.o z80_volume z80_tone table_gen 6502_table c_tone 6502_tone
