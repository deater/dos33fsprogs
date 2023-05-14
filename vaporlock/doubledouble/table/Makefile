LFLAGS = -lm

all:	sin.table

sin.table:	table
	./table > sin.table

table:	table.o
	$(CC) -o table table.o $(LFLAGS)

table.o:	table.c
	$(CC) -c table.c

clean:	
	rm -f *~ *.o table sin.table
