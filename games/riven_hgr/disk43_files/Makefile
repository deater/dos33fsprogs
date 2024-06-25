include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK43 LEVEL_CART LEVEL_BRIDGE LEVEL_LOGGED LEVEL_LOGGED2

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

LEVEL_LOGGED2:	level_logged2.o
	ld65 -o LEVEL_LOGGED2 level_logged2.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_logged2.o:	level_logged2.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk43_defines.inc \
		leveldata_logged2.inc \
		graphics_logged2/logged2_graphics.inc
	ca65 -o level_logged2.o level_logged2.s -l level_logged2.lst




####

MOVIE_MAGLEV_RIDE:	movie_maglev_ride.o
	ld65 -o MOVIE_MAGLEV_RIDE movie_maglev_ride.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

movie_maglev_ride.o:	movie_maglev_ride.s \
	../zp.inc ../hardware.inc ../qload.inc \
	../common_defines.inc disk43_defines.inc \
	end_message/end_message.gr.zx02 \
	movie_maglev_ride/movie_maglev_ride.inc
	ca65 -o movie_maglev_ride.o movie_maglev_ride.s -l movie_maglev_ride.lst



####

graphics_cart/cart_graphics.inc:
	cd graphics_cart && make

graphics_bridge/bridge_graphics.inc:
	cd graphics_bridge && make

graphics_logged/logged_graphics.inc:
	cd graphics_logged && make

graphics_logged2/logged2_graphics.inc:
	cd graphics_logged2 && make

####

clean:		
	rm -f *~ *.o *.lst \
		LEVEL_CART LEVEL_BRIDGE LEVEL_LOGGED

####

distclean:
	rm -f *~ *.o *.lst \
		LEVEL_CART LEVEL_BRIDGE LEVEL_LOGGED
	cd graphics_cart && make clean
	cd graphics_bridge && make clean
	cd graphics_logged && make clean
	cd graphics_logged2 && make clean


