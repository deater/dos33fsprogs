CC = gcc
C_FLAGS = -O2 -Wall
L_FLAGS =

all:	dos33 asoft_detoken mkdos33fs make_b



asoft_detoken:		   asoft_detoken.o
			   $(CC) $(L_FLAGS) -o asoft_detoken asoft_detoken.o

asoft_detoken.o:	   asoft_detoken.c
			   $(CC) $(C_FLAGS) -c asoft_detoken.c
			 
			   

dos33:	dos33.o
		$(CC) $(L_FLAGS) -o dos33 dos33.o
		
dos33.o:	dos33.c dos33.h
		$(CC) $(C_FLAGS) -c dos33.c
		
make_b:	make_b.o
		$(CC) $(L_FLAGS) -o make_b make_b.o
		
make_b.o:	make_b.c
		$(CC) $(C_FLAGS) -c make_b.c
		
		
mkdos33fs:	mkdos33fs.o
		$(CC) $(L_FLAGS) -o mkdos33fs mkdos33fs.o
		
mkdos33fs.o:	mkdos33fs.c dos33.h
		$(CC) $(C_FLAGS) -c mkdos33fs.c


install:	
		cp dos33 asoft_detoken mkdos33fs make_b /usr/local/bin

clean:		
		rm -f *~ *.o asoft_detoken dos33 make_b mkdos33fs
