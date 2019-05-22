CC = gcc
CFLAGS = -O2 -Wall
LFLASG =

all: 6502_table table_gen z80_table

###

6502_table:	6502_table.o
	$(CC) $(LFLASG) -o 6502_table 6502_table.o

6502_table.o:	6502_table.c
	$(CC) $(CFLAGS) -c 6502_table.c

###

table_gen:	table_gen.o
	$(CC) $(LFLAGS) -o table_gen table_gen.o

table_gen.o:	table_gen.c
	$(CC) $(CFLAGS) -c table_gen.c

###

z80_table:	z80_table.o
	$(CC) $(LFLAGS) -o z80_table z80_table.o

z80_table.o:	z80_table.c
	$(CC) $(CFLAGS) -c z80_table.c

###

clean:	
	rm -f *~ *.o z80_table table_gen 6502_table




