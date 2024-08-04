include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK43 LEVEL_CART LEVEL_BRIDGE LEVEL_LOGGED \
	LEVEL_LOGGED3 LEVEL_LOGGED4 LEVEL_LOGGED5 \
	MOVIE_CART_RIDE

####

DISK43:	disk43.o
	ld65 -o DISK43 disk43.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk43.o:	disk43.s ../zp.inc
	ca65 -o disk43.o disk43.s -l disk43.lst

####

LEVEL_CART:	level_cart.o
	ld65 -o LEVEL_CART level_cart.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_cart.o:	level_cart.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk43_defines.inc \
		leveldata_cart.inc \
		graphics_cart/cart_graphics.inc
	ca65 -o level_cart.o level_cart.s -l level_cart.lst

####

LEVEL_BRIDGE:	level_bridge.o
	ld65 -o LEVEL_BRIDGE level_bridge.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_bridge.o:	level_bridge.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk43_defines.inc \
		leveldata_bridge.inc \
		graphics_bridge/bridge_graphics.inc
	ca65 -o level_bridge.o level_bridge.s -l level_bridge.lst

####

LEVEL_LOGGED:	level_logged.o
	ld65 -o LEVEL_LOGGED level_logged.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_logged.o:	level_logged.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk43_defines.inc \
		leveldata_logged.inc \
		graphics_logged/logged_graphics.inc
	ca65 -o level_logged.o level_logged.s -l level_logged.lst

####

LEVEL_LOGGED3:	level_logged3.o
	ld65 -o LEVEL_LOGGED3 level_logged3.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_logged3.o:	level_logged3.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk43_defines.inc \
		leveldata_logged3.inc \
		graphics_logged3/logged3_graphics.inc
	ca65 -o level_logged3.o level_logged3.s -l level_logged3.lst

####

LEVEL_LOGGED4:	level_logged4.o
	ld65 -o LEVEL_LOGGED4 level_logged4.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_logged4.o:	level_logged4.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk43_defines.inc \
		leveldata_logged4.inc \
		graphics_logged4/logged4_graphics.inc
	ca65 -o level_logged4.o level_logged4.s -l level_logged4.lst

####

LEVEL_LOGGED5:	level_logged5.o
	ld65 -o LEVEL_LOGGED5 level_logged5.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_logged5.o:	level_logged5.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk43_defines.inc \
		leveldata_logged5.inc \
		graphics_logged5/logged5_graphics.inc
	ca65 -o level_logged5.o level_logged5.s -l level_logged5.lst



####

MOVIE_CART_RIDE:	movie_cart_ride.o
	ld65 -o MOVIE_CART_RIDE movie_cart_ride.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

movie_cart_ride.o:	movie_cart_ride.s \
	../zp.inc ../hardware.inc ../qload.inc \
	../common_defines.inc ../flip_pages.s disk43_defines.inc \
	movie_cart_ride/movie_cart_ride.inc \
	../disk39_files/movie_maglev_ride/overlays/overlay_combined.zx02
	ca65 -o movie_cart_ride.o movie_cart_ride.s -l movie_cart_ride.lst

####

graphics_cart/cart_graphics.inc:
	cd graphics_cart && make

graphics_bridge/bridge_graphics.inc:
	cd graphics_bridge && make

graphics_logged/logged_graphics.inc:
	cd graphics_logged && make

graphics_logged3/logged3_graphics.inc:
	cd graphics_logged3 && make

graphics_logged4/logged4_graphics.inc:
	cd graphics_logged4 && make

graphics_logged5/logged5_graphics.inc:
	cd graphics_logged5 && make

movie_cart_ride/movie_cart_ride.inc:
	cd movie_cart_ride && make


####

clean:		
	rm -f *~ *.o *.lst \
		LEVEL_CART LEVEL_BRIDGE LEVEL_LOGGED \
		LEVEL_LOGGED3 LEVEL_LOGGED4 LEVEL_LOGGED5

####

distclean:
	rm -f *~ *.o *.lst \
		LEVEL_CART LEVEL_BRIDGE LEVEL_LOGGED \
		LEVEL_LOGGED3 LEVEL_LOGGED4 LEVEL_LOGGED5
	cd graphics_cart && make clean
	cd graphics_bridge && make clean
	cd graphics_logged && make clean
	cd graphics_logged3 && make clean
	cd graphics_logged4 && make clean
	cd graphics_logged5 && make clean

