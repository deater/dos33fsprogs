include ../../../Makefile.inc

COMMON = ..
SPRITES = ../sprites
LINKER_SCRIPTS = ../../../linker_scripts

all:	OOTW_C1

####

OOTW_C1:	ootw_c1.o
	ld65 -o OOTW_C1 ootw_c1.o -C $(LINKER_SCRIPTS)/apple2_1700.inc

ootw_c1.o:	ootw_c1.s \
	$(COMMON)/gr_copy.s \
	$(COMMON)/gr_fast_clear.s \
	$(COMMON)/gr_pageflip.s \
	$(COMMON)/gr_unrle.s \
	$(COMMON)/gr_putsprite.s \
	$(COMMON)/gr_putsprite_flipped.s \
	$(COMMON)/gr_putsprite_crop.s \
	$(COMMON)/gr_hlin.s \
	$(COMMON)/gr_make_quake.s \
	$(COMMON)/gr_overlay.s \
	$(COMMON)/zp.inc \
	$(COMMON)/keyboard.s \
	$(COMMON)/collision.s \
	$(COMMON)/physicist.s \
	$(COMMON)/random16.s \
	ootw_c1_sluggy.s ootw_c1_beast.s \
	ootw_c1_arrival.s ootw_c1_rope.s earthquake.s ootw_c1_mesa.s \
	ootw_c1_pool.s ootw_c1_cavern.s \
	graphics/l1_pool/ootw_pool.inc \
	graphics/l1_underwater/ootw_underwater.inc \
	graphics/l1_caves/ootw_cavern.inc \
	graphics/l1_caves/ootw_cavern2.inc \
	graphics/l1_caves/ootw_cavern3.inc \
	graphics/l1_rope/ootw_rope.inc \
	graphics/l1_rope/ootw_swing.inc \
	graphics/l1_end/ootw_l1end.inc \
	$(SPRITES)/physicist.inc \
	$(SPRITES)/physicist_l1_swim.inc \
	$(SPRITES)/slugs.inc \
	$(SPRITES)/l1_background.inc \
	$(SPRITES)/beast.inc \
	graphics/l1_beast_end/ootw_beast_end.inc \
	graphics/l1_beast_intro/ootw_beast_intro.inc \
	graphics/l1_slug_end/ootw_slug_end.inc
	ca65 -o ootw_c1.o ootw_c1.s -l ootw_c1.lst


#####

clean:		
		rm -f *~ *.o *.lst *.lz4 OOTW_C1
