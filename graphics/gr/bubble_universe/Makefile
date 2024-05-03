include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	bubble_gr.dsk make_table

bubble_gr.dsk:	HELLO BUBBLE_GR BUBBLE_COLOR BUBBLE_SMALL BUBBLE_TINY \
	COOL_LINES
	cp $(EMPTY_DISK)/empty.dsk bubble_gr.dsk
	$(DOS33) -y bubble_gr.dsk SAVE A HELLO
	$(DOS33) -y bubble_gr.dsk BSAVE -a 0x2000 BUBBLE_GR
	$(DOS33) -y bubble_gr.dsk BSAVE -a 0x2000 BUBBLE_COLOR
	$(DOS33) -y bubble_gr.dsk BSAVE -a 0x2000 BUBBLE_SMALL
	$(DOS33) -y bubble_gr.dsk BSAVE -a 0x2000 BUBBLE_TINY
	$(DOS33) -y bubble_gr.dsk BSAVE -a 0x2000 COOL_LINES

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BUBBLE_GR:	bubble_gr.o
	ld65 -o BUBBLE_GR bubble_gr.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

bubble_gr.o:	bubble_gr.s
	ca65 -o bubble_gr.o bubble_gr.s -l bubble_gr.lst

###

BUBBLE_COLOR:	bubble_color.o
	ld65 -o BUBBLE_COLOR bubble_color.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

bubble_color.o:	bubble_color.s
	ca65 -o bubble_color.o bubble_color.s -l bubble_color.lst

###

BUBBLE_SMALL:	bubble_small.o
	ld65 -o BUBBLE_SMALL bubble_small.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

bubble_small.o:	bubble_small.s
	ca65 -o bubble_small.o bubble_small.s -l bubble_small.lst

###

BUBBLE_TINY:	bubble_tiny.o
	ld65 -o BUBBLE_TINY bubble_tiny.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

bubble_tiny.o:	bubble_tiny.s
	ca65 -o bubble_tiny.o bubble_tiny.s -l bubble_tiny.lst

###

COOL_LINES:	cool_lines.o
	ld65 -o COOL_LINES cool_lines.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

cool_lines.o:	cool_lines.s
	ca65 -o cool_lines.o cool_lines.s -l cool_lines.lst


###

make_table:	make_table.o
	$(CC) $(LFLAGS) -o make_table make_table.o

make_table.o:	make_table.c
	$(CC) $(CFLAGS) -c make_table.c

###

clean:	
	rm -f *~ *.o *.lst make_table \
		HELLO BUBBLE_GR BUBBLE_COLOR BUBBLE_SMALL BUBBLE_TINY COOL_LINES


