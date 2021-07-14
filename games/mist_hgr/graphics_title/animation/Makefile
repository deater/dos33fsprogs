#include ../Makefile.inc

CC = gcc
CFLAGS = -O2 -Wall

B2D = ../../../utils/bmp2dhr/b2d
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
MAKE_VGI = ../../../graphics/hgr/vgi/make_vgi_asm

all:	dump_sprite \
	myst_dock_anim1.hgr myst_dock_anim2.hgr myst_dock_anim3.hgr \
	myst_dock_anim4.hgr myst_dock_anim5.hgr myst_dock_anim6.hgr \
	myst_dock_anim7.hgr myst_dock_anim8.hgr myst_dock_anim9.hgr \
	myst_dock_anim10.hgr myst_dock_anim11.hgr myst_dock_anim12.hgr \
	myst_dock_anim13.hgr

####

dump_sprite:	dump_sprite.o
	$(CC) $(LFLAGS) -o dump_sprite dump_sprite.o

dump_sprite.o:	dump_sprite.c
	$(CC) $(CFLAGS) -c dump_sprite.c

####

%.hgr:	%.png
	$(PNG2HGR) $< > $@

####

clean:		
		rm -f *~ *.o *.lst *.hgr dump_sprite
