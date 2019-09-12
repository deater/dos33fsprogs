include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	pt3_lib.dsk

$(DOS33):
	cd ../dos33fs-utils && make

pt3_lib.dsk:	PT3_TEST HELLO
	cp empty.dsk pt3_lib.dsk
	$(DOS33) -y pt3_lib.dsk SAVE A HELLO
	$(DOS33) -y pt3_lib.dsk BSAVE -a 0x1000 PT3_TEST

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

#

PT3_TEST:	pt3_test.o
	ld65 -o PT3_TEST pt3_test.o -C ../linker_scripts/apple2_1000.inc

pt3_test.o:	pt3_test.s \
	pt3_lib_init.s pt3_lib_core.s pt3_lib_irq_handler.s \
	pt3_lib_mockingboard.s \
	interrupt_handler.s zp.inc
	ca65 -o pt3_test.o pt3_test.s -l pt3_test.lst
#

clean:	
	rm -f *~ *.o *.lst PT3_TEST HELLO
