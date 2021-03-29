include ../../../Makefile.inc

COMMON = ..
LINKER_SCRIPTS = ../../../linker_scripts
SPRITES = ../sprites

all:	OOTW_C4

####

OOTW_C4:	ootw_c4.o
	ld65 -o OOTW_C4 ootw_c4.o -C $(LINKER_SCRIPTS)/apple2_1700.inc

ootw_c4.o:	ootw_c4.s \
	$(COMMON)/gr_copy.s \
	$(COMMON)/gr_twoscreen_scroll.s \
	$(COMMON)/gr_fast_clear.s \
	$(COMMON)/gr_pageflip.s \
	$(COMMON)/gr_unrle.s \
	$(COMMON)/gr_hlin.s \
	$(COMMON)/gr_putsprite.s \
	$(COMMON)/gr_putsprite_flipped.s \
	$(COMMON)/gr_putsprite_crop.s \
	$(COMMON)/keyboard.s \
	$(COMMON)/gr_run_sequence.s \
	$(COMMON)/physicist.s \
	$(COMMON)/collision.s \
	$(COMMON)/alien.s \
	$(COMMON)/alien_laser.s \
	ootw_c4_city.s ootw_c4_action.s \
	$(COMMON)/door.s \
	$(COMMON)/laser.s \
	$(COMMON)/shield.s \
	$(COMMON)/blast.s \
	$(COMMON)/gun.s \
	$(COMMON)/charger.s \
	$(SPRITES)/physicist.inc \
	graphics/l4_city/ootw_c4_city.inc
	ca65 -o ootw_c4.o ootw_c4.s -l ootw_c4.lst

###

graphics/l4_city/ootw_c4_city.inc:	
	cd graphics && make


###

clean:		
		rm -f *~ *.o *.lst *.lz4 OOTW_C4


distclean:
	cd graphics && make clean
