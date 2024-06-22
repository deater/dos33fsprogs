include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK40 LEVEL_MAGLEV LEVEL_OUTSIDE LEVEL_ORB LEVEL_TUNNEL

###

DISK40:	disk40.o
	ld65 -o DISK40 disk40.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk40.o:	disk40.s ../zp.inc
	ca65 -o disk40.o disk40.s -l disk40.lst

####

LEVEL_MAGLEV:	level_maglev.o
	ld65 -o LEVEL_MAGLEV level_maglev.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_maglev.o:	level_maglev.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk40_defines.inc \
		leveldata_maglev.inc \
		graphics_maglev/maglev_graphics.inc
	ca65 -o level_maglev.o level_maglev.s -l level_maglev.lst


####

LEVEL_OUTSIDE:	level_outside.o
	ld65 -o LEVEL_OUTSIDE level_outside.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_outside.o:	level_outside.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk40_defines.inc \
		leveldata_outside.inc \
		graphics_outside/outside_graphics.inc
	ca65 -o level_outside.o level_outside.s -l level_outside.lst

####

LEVEL_ORB:	level_orb.o
	ld65 -o LEVEL_ORB level_orb.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_orb.o:	level_orb.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk40_defines.inc \
		leveldata_orb.inc \
		graphics_orb1/orb1_graphics.inc
	ca65 -o level_orb.o level_orb.s -l level_orb.lst

####

LEVEL_TUNNEL:	level_tunnel.o
	ld65 -o LEVEL_TUNNEL level_tunnel.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_tunnel.o:	level_tunnel.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk40_defines.inc \
		leveldata_tunnel.inc \
		graphics_tunnel/tunnel_graphics.inc
	ca65 -o level_tunnel.o level_tunnel.s -l level_tunnel.lst




####

graphics_maglev/maglev_graphics.inc:
	cd graphics_maglev && make

graphics_outside/outside_graphics.inc:
	cd graphics_outside && make

graphics_orb1/orb1_graphics.inc:
	cd graphics_orb1 && make

graphics_tunnel/tunnel_graphics.inc:
	cd graphics_tunnel && make
####

clean:		
	rm -f *~ *.o *.lst \
		LEVEL_MAGLEV LEVEL_OUTSIDE LEVEL_ORB LEVEL_TUNNEL


####

distclean:
	rm -f *~ *.o *.lst \
		LEVEL_MAGLEV LEVEL_OUTSIDE
	cd graphics_maglev && make clean
	cd graphics_outside && make clean


