include ../../../Makefile.inc

COMMON = ..
SPRITES = ../sprites

LINKER_SCRIPTS = ../../../linker_scripts

all:	OOTW_C2

####

OOTW_C2:	ootw_c2.o
	ld65 -o OOTW_C2 ootw_c2.o -C $(LINKER_SCRIPTS)/apple2_1700.inc

ootw_c2.o:	ootw_c2.s \
	$(COMMON)/gr_copy.s \
	$(COMMON)/gr_copy_offset.s \
	$(COMMON)/gr_fast_clear.s \
	$(COMMON)/gr_pageflip.s \
	$(COMMON)/gr_unrle.s \
	$(COMMON)/gr_hlin.s \
	$(COMMON)/gr_putsprite.s \
	$(COMMON)/gr_putsprite_flipped.s \
	$(COMMON)/gr_putsprite_crop.s \
	$(COMMON)/keyboard.s \
	$(COMMON)/gr_run_sequence.s \
	audio.s \
	$(COMMON)/alien_laser.s \
	$(COMMON)/physicist.s \
	$(COMMON)/alien.s \
	$(COMMON)/friend.s \
	$(COMMON)/collision.s \
	$(COMMON)/door.s \
	$(COMMON)/laser.s \
	$(COMMON)/shield.s \
	$(COMMON)/blast.s \
	$(COMMON)/gun.s \
	ootw_c2_miners.s \
	$(SPRITES)/physicist.inc \
	$(SPRITES)/alien.inc \
	$(SPRITES)/friend.inc \
	ootw_c2_cage.s ootw_c2_jail.s ootw_c2_elevator.s ootw_c2_intro.s \
	graphics/l2_cage/ootw_c2_cage.inc \
	graphics/l2_jail/ootw_c2_jail.inc \
	graphics/l2_intro/ootw_l2intro.inc \
	graphics/l2_laser/ootw_c2_laser.inc
	ca65 -o ootw_c2.o ootw_c2.s -l ootw_c2.lst

#####
graphics/l2_cage/ootw_c2_cage.inc:	
	cd graphics && make


#####

clean:		
		rm -f *~ *.o *.lst *.lz4 OOTW_C2

