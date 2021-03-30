include ../../../Makefile.inc

COMMON = ..
LINKER_SCRIPTS = ../../../linker_scripts
SPRITES = ../sprites

all:	OOTW_C9

####

OOTW_C9:	ootw_c9.o
	ld65 -o OOTW_C9 ootw_c9.o -C $(LINKER_SCRIPTS)/apple2_1700.inc

ootw_c9.o:	ootw_c9.s \
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
	graphics/l9_swim/ootw_c9_swim.inc
	ca65 -o ootw_c9.o ootw_c9.s -l ootw_c9.lst

#####

graphics/l9_swim/ootw_c9_swim.inc:
	cd graphics && make

#####

clean:		
	rm -f *~ *.o *.lst OOTW_C9

#####

distclean:		
	make clean
	cd graphics && make clean

