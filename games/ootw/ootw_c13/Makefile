include ../../../Makefile.inc

COMMON = ..
LINKER_SCRIPTS = ../../../linker_scripts
SPRITES = ../sprites

all:	OOTW_C13

####

OOTW_C13:	ootw_c13.o
	ld65 -o OOTW_C13 ootw_c13.o -C $(LINKER_SCRIPTS)/apple2_1700.inc

ootw_c13.o:	ootw_c13.s \
	$(COMMON)/gr_copy.s \
	$(COMMON)/gr_copy_offset.s \
	$(COMMON)/gr_fast_clear.s \
	$(COMMON)/gr_pageflip.s \
	$(COMMON)/gr_unrle.s \
	$(COMMON)/gr_putsprite.s \
	$(COMMON)/gr_putsprite_flipped.s \
	$(COMMON)/gr_putsprite_crop.s \
	$(COMMON)/keyboard.s \
	$(COMMON)/gr_run_sequence.s \
	$(COMMON)/physicist.s \
	$(COMMON)/collision.s \
	$(COMMON)/door.s \
	$(COMMON)/laser.s \
	$(COMMON)/gun.s \
	$(COMMON)/blast.s \
	$(COMMON)/shield.s \
	$(SPRITES)/physicist.inc \
	graphics/l13_room/ootw_c13_room.inc
	ca65 -o ootw_c13.o ootw_c13.s -l ootw_c13.lst

#####

graphics/l13_room/ootw_c13_room.inc:
	cd graphics && make

#####

clean:		
	rm -f *~ *.o *.lst OOTW_C13

#####

distclean:		
	make clean
	cd graphics && make clean


