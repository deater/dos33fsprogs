include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG2GR = ../../utils/gr-utils/png2gr
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk

all:	pt3_lib_ch6.dsk

$(DOS33):
	cd ../../utils/dos33fs-utils && make

pt3_lib_ch6.dsk:	PT3_TEST HELLO
	cp $(EMPTY_DISK)/empty.dsk pt3_lib_ch6.dsk
	$(DOS33) -y pt3_lib_ch6.dsk SAVE A HELLO
	$(DOS33) -y pt3_lib_ch6.dsk BSAVE -a 0x1000 PT3_TEST

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

#

PT3_TEST:	pt3_test.o
	ld65 -o PT3_TEST pt3_test.o -C ../../linker_scripts/apple2_1000.inc

pt3_test.o:	pt3_test.s \
	pt3_lib_detect_model.s \
	pt3_lib_init.s pt3_lib_core.s pt3_lib_irq_handler.s \
	pt3_lib_common.s pt3_lib_core2.s visual.s \
	pt3_lib_mockingboard_detect.s pt3_lib_mockingboard_setup.s \
	interrupt_handler.s zp.inc
	ca65 -o pt3_test.o pt3_test.s -l pt3_test.lst
#

clean:	
	rm -f *~ *.o *.lst PT3_TEST HELLO
