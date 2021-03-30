include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
PT3_PLAYER = ../pt3_player

all:	ENDING

#####

ENDING:	ending.o
	ld65 -o ENDING ending.o -C $(LINKER_SCRIPTS)/apple2_1700.inc

ending.o:	ending.s \
	$(PT3_PLAYER)/pt3_lib_core.s \
	$(PT3_PLAYER)/pt3_lib_init.s \
	$(PT3_PLAYER)/pt3_lib_mockingboard_detect.s \
	$(PT3_PLAYER)/pt3_lib_mockingboard_setup.s \
	$(PT3_PLAYER)/pt3_lib_irq_handler.s \
	$(PT3_PLAYER)/interrupt_handler.s \
	graphics/ending/ootw_c16_end.inc \
	music/ootw_outro.pt3
	ca65 -o ending.o ending.s -l ending.lst

#####

graphics/ending/ootw_c16_end.inc:
	cd graphics && make

#####

clean:		
		rm -f *~ *.o *.lst ENDING


distclean:
	cd graphics && make clean
