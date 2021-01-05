include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG2GR = ../../utils/gr-utils/png2gr

all:	chiptune_debug.dsk

chiptune_debug.dsk:	CHIPTUNE_IRQ CHIPTUNE_NOIRQ CHIPTUNE_25HZ \
		CHIPTUNE_BARE CHIPTUNE_MIN CHIPTUNE_TINY CHIPTUNE_READBACK \
		CHIPTUNE_RIGHT CHIPTUNE_SMALLEST

	cp chiptune_empty.dsk chiptune_debug.dsk
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_IRQ
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_NOIRQ
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_25HZ
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_BARE
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_MIN
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_TINY
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_READBACK
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_RIGHT
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_SMALLEST


CHIPTUNE_IRQ:	chiptune_irq.o
	ld65 -o CHIPTUNE_IRQ chiptune_irq.o -C ../../linker_scripts/apple2_c00.inc

chiptune_irq.o:	chiptune_player.s \
	mockingboard_a.s \
	interrupt_handler.s \
	zp.inc
	ca65 -o chiptune_irq.o chiptune_player.s -l chiptune_irq.lst

CHIPTUNE_NOIRQ:	chiptune_noirq.o
	ld65 -o CHIPTUNE_NOIRQ chiptune_noirq.o -C ../../linker_scripts/apple2_c00.inc

chiptune_noirq.o:	chiptune_player.s \
	mockingboard_a.s \
	interrupt_handler.s \
	zp.inc
	ca65 -D NOIRQ=1 -o chiptune_noirq.o chiptune_player.s -l chiptune_noirq.lst

CHIPTUNE_25HZ:	chiptune_25Hz.o
	ld65 -o CHIPTUNE_25HZ chiptune_25Hz.o -C ../../linker_scripts/apple2_c00.inc

chiptune_25Hz.o:	chiptune_player.s \
	mockingboard_a.s \
	interrupt_handler.s \
	zp.inc
	ca65 -D F25HZ=1 -o chiptune_25Hz.o chiptune_player.s -l chiptune_25Hz.lst


CHIPTUNE_BARE:	chiptune_bare.o
	ld65 -o CHIPTUNE_BARE chiptune_bare.o -C ../../linker_scripts/apple2_c00.inc

chiptune_bare.o:	chiptune_bare.s
	ca65 -o chiptune_bare.o chiptune_bare.s -l chiptune_bare.lst

CHIPTUNE_MIN:	chiptune_min.o
	ld65 -o CHIPTUNE_MIN chiptune_min.o -C ../../linker_scripts/apple2_c00.inc

chiptune_min.o:	chiptune_min.s
	ca65 -o chiptune_min.o chiptune_min.s -l chiptune_min.lst

CHIPTUNE_TINY:	chiptune_tiny.o
	ld65 -o CHIPTUNE_TINY chiptune_tiny.o -C ../../linker_scripts/apple2_c00.inc

chiptune_tiny.o:	chiptune_tiny.s
	ca65 -o chiptune_tiny.o chiptune_tiny.s -l chiptune_tiny.lst

CHIPTUNE_RIGHT:	chiptune_right.o
	ld65 -o CHIPTUNE_RIGHT chiptune_right.o -C ../../linker_scripts/apple2_c00.inc

chiptune_right.o:	chiptune_right.s
	ca65 -o chiptune_right.o chiptune_right.s -l chiptune_right.lst

CHIPTUNE_SMALLEST:	chiptune_smallest.o
	ld65 -o CHIPTUNE_SMALLEST chiptune_smallest.o -C ../../linker_scripts/apple2_c00.inc

chiptune_smallest.o:	chiptune_smallest.s
	ca65 -o chiptune_smallest.o chiptune_smallest.s -l chiptune_smallest.lst



CHIPTUNE_READBACK:	chiptune_readback.o
	ld65 -o CHIPTUNE_READBACK chiptune_readback.o -C ../../linker_scripts/apple2_c00.inc

chiptune_readback.o:	chiptune_readback.s
	ca65 -o chiptune_readback.o chiptune_readback.s -l chiptune_readback.lst


clean:
	rm -f *~ TITLE.GR *.o *.lst \
		CHIPTUNE_PLAYER CHIPTUNE_IRQ CHIPTUNE_NOIRQ CHIPTUNE_25HZ \
		CHIPTUNE_MIN CHIPTUNE_TINY CHIPTUNE_READBACK CHIPTUNE_RIGHT \
		CHIPTUNE_SMALLEST

