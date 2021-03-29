include ../../../Makefile.inc

COMMON = ..
SPRITES = ../sprites
LINKER_SCRIPTS = ../../../linker_scripts

all:	OOTW_C3

####

OOTW_C3:	ootw_c3.o
	ld65 -o OOTW_C3 ootw_c3.o -C $(LINKER_SCRIPTS)/apple2_1700.inc

ootw_c3.o:	ootw_c3.s \
	$(COMMON)/gr_copy.s \
	$(COMMON)/gr_copy_offset.s \
	$(COMMON)/gr_fast_clear.s \
	$(COMMON)/gr_pageflip.s \
	$(COMMON)/gr_unrle.s \
	$(COMMON)/gr_putsprite.s \
	$(COMMON)/gr_putsprite_flipped.s \
	$(COMMON)/gr_putsprite_crop.s \
	$(COMMON)/keyboard.s \
	ootw_c3_vent.s \
	$(SPRITES)/physicist_rolling.inc \
	graphics/l3_vent/ootw_c3_vent.inc
	ca65 -o ootw_c3.o ootw_c3.s -l ootw_c3.lst

#####

graphics/l3_vent/ootw_c3_vent.inc:
	cd graphics && make

#####

clean:		
		rm -f *~ *.o *.lst *.lz4 OOTW_C3


