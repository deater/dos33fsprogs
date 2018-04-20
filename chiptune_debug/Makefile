include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	chiptune_debug.dsk

chiptune_debug.dsk:	CHIPTUNE_IRQ CHIPTUNE_NOIRQ ./sdemo.raw
	cp chiptune_empty.dsk chiptune_debug.dsk
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_IRQ
	$(DOS33) -y chiptune_debug.dsk BSAVE -a 0x0C00 CHIPTUNE_NOIRQ


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


clean:
	rm -f *~ TITLE.GR *.o *.lst \
		CHIPTUNE_PLAYER CHIPTUNE_IRQ CHIPTUNE_NOIRQ

