include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	thinking.dsk cracking.dsk

cracking.dsk:	COMBO_BOOT
	dd if=COMBO_BOOT of=cracking.dsk bs=256 count=1
	dd if=/dev/zero of=rr2.dsk bs=256 count=559
	cat rr2.dsk >> cracking.dsk


thinking.dsk:	HELLO THINKING RAINBOW_BOX T2 THINKING_FLIP T3 THINKING_SLOW \
	THINKING_ATTEMPT2 THINKING_ATTEMPT3 THINKING_ATTEMPT4 THINKING_ATTEMPT5 \
	THINKING_ATTEMPT6 CRACKING CRACKING_BOT THINKING_BOT COMBO
	cp $(EMPTYDISK) thinking.dsk
	$(DOS33) -y thinking.dsk SAVE A HELLO
	$(DOS33) -y thinking.dsk BSAVE -a 0xc00 COMBO
	$(DOS33) -y thinking.dsk BSAVE -a 0xc00 THINKING
	$(DOS33) -y thinking.dsk BSAVE -a 0x36b THINKING_BOT
	$(DOS33) -y thinking.dsk BSAVE -a 0xc00 CRACKING
	$(DOS33) -y thinking.dsk BSAVE -a 0x36b CRACKING_BOT
	$(DOS33) -y thinking.dsk BSAVE -a 0xC00 THINKING_FLIP
	$(DOS33) -y thinking.dsk BSAVE -a 0xC00 THINKING_SLOW
	$(DOS33) -y thinking.dsk BSAVE -a 0xC00 THINKING_ATTEMPT2
	$(DOS33) -y thinking.dsk BSAVE -a 0xC00 THINKING_ATTEMPT3
	$(DOS33) -y thinking.dsk BSAVE -a 0xC00 THINKING_ATTEMPT4
	$(DOS33) -y thinking.dsk BSAVE -a 0xC00 THINKING_ATTEMPT5
	$(DOS33) -y thinking.dsk BSAVE -a 0xC00 THINKING_ATTEMPT6
	$(DOS33) -y thinking.dsk BSAVE -a 0xC00 RAINBOW_BOX
	$(DOS33) -y thinking.dsk BSAVE -a 0xC00 T2
	$(DOS33) -y thinking.dsk BSAVE -a 0xC00 T3

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

THINKING:	thinking.o
	ld65 -o THINKING thinking.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thinking.o:	thinking.s
	ca65 -o thinking.o thinking.s -l thinking.lst

###

COMBO:	combo.o
	ld65 -o COMBO combo.o -C $(LINKERSCRIPTS)/apple2_c00.inc

combo.o:	combo.s
	ca65 -o combo.o combo.s -l combo.lst

###

COMBO_BOOT:	combo_boot.o
	ld65 -o COMBO_BOOT combo_boot.o -C $(LINKERSCRIPTS)/apple2_800.inc

combo_boot.o:	combo_boot.s
	ca65 -o combo_boot.o combo_boot.s -l combo_boot.lst


###

THINKING_BOT:	thinking_bot.o
	ld65 -o THINKING_BOT thinking_bot.o -C $(LINKERSCRIPTS)/apple2_36b.inc

thinking_bot.o:	thinking_bot.s
	ca65 -o thinking_bot.o thinking_bot.s -l thinking_bot.lst

###

CRACKING:	cracking.o
	ld65 -o CRACKING cracking.o -C $(LINKERSCRIPTS)/apple2_c00.inc

cracking.o:	cracking.s
	ca65 -o cracking.o cracking.s -l cracking.lst

###

CRACKING_BOT:	cracking_bot.o
	ld65 -o CRACKING_BOT cracking_bot.o -C $(LINKERSCRIPTS)/apple2_36b.inc

cracking_bot.o:	cracking_bot.s
	ca65 -o cracking_bot.o cracking_bot.s -l cracking_bot.lst



###

THINKING_FLIP:	thinking_flip.o
	ld65 -o THINKING_FLIP thinking_flip.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thinking_flip.o:	thinking_flip.s
	ca65 -o thinking_flip.o thinking_flip.s -l thinking_flip.lst

###

THINKING_SLOW:	thinking_slow.o
	ld65 -o THINKING_SLOW thinking_slow.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thinking_slow.o:	thinking_slow.s
	ca65 -o thinking_slow.o thinking_slow.s -l thinking_slow.lst


###

THINKING_ATTEMPT2:	thinking_attempt2.o
	ld65 -o THINKING_ATTEMPT2 thinking_attempt2.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thinking_attempt2.o:	thinking_attempt2.s
	ca65 -o thinking_attempt2.o thinking_attempt2.s -l thinking_attempt2.lst

###

THINKING_ATTEMPT3:	thinking_attempt3.o
	ld65 -o THINKING_ATTEMPT3 thinking_attempt3.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thinking_attempt3.o:	thinking_attempt3.s
	ca65 -o thinking_attempt3.o thinking_attempt3.s -l thinking_attempt3.lst

###

THINKING_ATTEMPT4:	thinking_attempt4.o
	ld65 -o THINKING_ATTEMPT4 thinking_attempt4.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thinking_attempt4.o:	thinking_attempt4.s
	ca65 -o thinking_attempt4.o thinking_attempt4.s -l thinking_attempt4.lst


###

THINKING_ATTEMPT5:	thinking_attempt5.o
	ld65 -o THINKING_ATTEMPT5 thinking_attempt5.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thinking_attempt5.o:	thinking_attempt5.s
	ca65 -o thinking_attempt5.o thinking_attempt5.s -l thinking_attempt5.lst

###

THINKING_ATTEMPT6:	thinking_attempt6.o
	ld65 -o THINKING_ATTEMPT6 thinking_attempt6.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thinking_attempt6.o:	thinking_attempt6.s
	ca65 -o thinking_attempt6.o thinking_attempt6.s -l thinking_attempt6.lst



###

RAINBOW_BOX:	rainbow_box.o
	ld65 -o RAINBOW_BOX rainbow_box.o -C $(LINKERSCRIPTS)/apple2_c00.inc

rainbow_box.o:	rainbow_box.s
	ca65 -o rainbow_box.o rainbow_box.s -l rainbow_box.lst

###

T2:	t2.o
	ld65 -o T2 t2.o -C $(LINKERSCRIPTS)/apple2_c00.inc

t2.o:	t2.s
	ca65 -o t2.o t2.s -l t2.lst

###

T3:	t3.o
	ld65 -o T3 t3.o -C $(LINKERSCRIPTS)/apple2_c00.inc

t3.o:	t3.s
	ca65 -o t3.o t3.s -l t3.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO THINKING RAINBOW_BOX T2 THINKING_FLIP T3 THINKING_SLOW \
		THINKING_ATTEMPT2 THINKING_ATTEMPT3 THINKING_ATTEMPT4 THINKING_ATTEMPT5 THINKING_ATTEMPT6 CRACKING \
		THINKING_BOT COMBO
