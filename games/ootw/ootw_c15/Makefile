include ../../../Makefile.inc

COMMON = ..
LINKER_SCRIPTS = ../../../linker_scripts
SPRITES = ../sprites

all:	OOTW_C15

####

OOTW_C15:	ootw_c15.o
	ld65 -o OOTW_C15 ootw_c15.o -C $(LINKER_SCRIPTS)/apple2_1700.inc

ootw_c15.o:	ootw_c15.s \
	$(COMMON)/gr_copy.s \
	$(COMMON)/gr_copy_offset.s \
	$(COMMON)/gr_fast_clear.s \
	$(COMMON)/gr_pageflip.s \
	$(COMMON)/gr_unrle.s \
	$(COMMON)/gr_putsprite.s \
	$(COMMON)/gr_putsprite_flipped.s \
	$(COMMON)/gr_putsprite_crop.s \
	$(COMMON)/gr_trapezoid.s \
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
	graphics/l15_final/ootw_c15_bath.inc \
	graphics/l15_final/ootw_c15_walk.inc \
	graphics/l15_final/ootw_c15_final.inc \
	graphics/l15_final/ootw_c15_walkway.inc \
	graphics/l15_final/ootw_c15_bridge.inc \
	graphics/l15_final/ootw_c15_fall.inc
	ca65 -o ootw_c15.o ootw_c15.s -l ootw_c15.lst

#####

clean:		
		rm -f *~ *.o *.lst OOTW_C15

