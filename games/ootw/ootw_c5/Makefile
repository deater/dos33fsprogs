include ../../../Makefile.inc

COMMON = ..
SPRITES = ../sprites
LINKER_SCRIPTS = ../../../linker_scripts

all:	OOTW_C5

####

OOTW_C5:	ootw_c5.o
	ld65 -o OOTW_C5 ootw_c5.o -C $(LINKER_SCRIPTS)/apple2_1700.inc

ootw_c5.o:	ootw_c5.s \
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
	ootw_c5_cave.s \
	$(COMMON)/collision.s \
	$(COMMON)/door.s \
	$(COMMON)/laser.s \
	$(COMMON)/gun.s \
	$(COMMON)/blast.s \
	$(COMMON)/shield.s \
	$(SPRITES)/physicist.inc \
	graphics/l5_cave/ootw_c5_cave.inc
	ca65 -o ootw_c5.o ootw_c5.s -l ootw_c5.lst

###

graphics/l5_cave/ootw_c5_cave.inc:	
	cd graphics && make

###

clean:		
		rm -f *~ *.o *.lst OOTW_C5

###

distclean:		
	make clean
	cd graphics && make clean

