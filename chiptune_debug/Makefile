include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	chiptune_debug.dsk

chiptune_debug.dsk:	CHIPTUNE_IRQ CHIPTUNE_NOIRQ CHIPTUNE_25HZ CHIPTUNE_BARE ./sdemo.raw
	cp chiptune_empty.dsk chiptune_debug.dsk
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_IRQ
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_NOIRQ
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_25HZ
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_BARE


CHIPTUNE_IRQ:	chiptune_irq.o
	ld65 -o CHIPTUNE_IRQ chiptune_irq.o -C ../linker_scripts/apple2_c00.inc

chiptune_irq.o:	chiptune_player.s \
	mockingboard_a.s \
	interrupt_handler.s \
	zp.inc
	ca65 -o chiptune_irq.o chiptune_player.s -l chiptune_irq.lst

CHIPTUNE_NOIRQ:	chiptune_noirq.o
	ld65 -o CHIPTUNE_NOIRQ chiptune_noirq.o -C ../linker_scripts/apple2_c00.inc

chiptune_noirq.o:	chiptune_player.s \
	mockingboard_a.s \
	interrupt_handler.s \
	zp.inc
	ca65 -D NOIRQ=1 -o chiptune_noirq.o chiptune_player.s -l chiptune_noirq.lst

CHIPTUNE_25HZ:	chiptune_25Hz.o
	ld65 -o CHIPTUNE_25HZ chiptune_25Hz.o -C ../linker_scripts/apple2_c00.inc

chiptune_25Hz.o:	chiptune_player.s \
	mockingboard_a.s \
	interrupt_handler.s \
	zp.inc
	ca65 -D F25HZ=1 -o chiptune_25Hz.o chiptune_player.s -l chiptune_25Hz.lst


CHIPTUNE_BARE:	chiptune_bare.o
	ld65 -o CHIPTUNE_BARE chiptune_bare.o -C ../linker_scripts/apple2_c00.inc

chiptune_bare.o:	chiptune_bare.s
	ca65 -o chiptune_bare.o chiptune_bare.s -l chiptune_bare.lst


clean:
	rm -f *~ TITLE.GR *.o *.lst \
		CHIPTUNE_PLAYER CHIPTUNE_IRQ CHIPTUNE_NOIRQ CHIPTUNE_25HZ

