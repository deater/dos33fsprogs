include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	bubble_gr.dsk make_table

bubble_gr.dsk:	HELLO BUBBLE_GR
	cp $(EMPTY_DISK)/empty.dsk bubble_gr.dsk
	$(DOS33) -y bubble_gr.dsk SAVE A HELLO
	$(DOS33) -y bubble_gr.dsk BSAVE -a 0x2000 BUBBLE_GR

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BUBBLE_GR:	bubble_gr.o
	ld65 -o BUBBLE_GR bubble_gr.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

bubble_gr.o:	bubble_gr.s
	ca65 -o bubble_gr.o bubble_gr.s -l bubble_gr.lst

###

make_table:	make_table.o
	$(CC) $(LFLAGS) -o make_table make_table.o

make_table.o:	make_table.c
	$(CC) $(CFLAGS) -c make_table.c

###

clean:	
	rm -f *~ *.o *.lst HELLO BUBBLE_GR

