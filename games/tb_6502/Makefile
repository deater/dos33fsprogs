include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	tb_6502.dsk

tb_6502.dsk:	TB_6502
		$(DOS33) -y tb_6502.dsk BSAVE -a 0x0C00 TB_6502

#TB_6502:	tb_6502
#		make_b ./tb_6502 ./TB_6502 0xC00

TB_6502:	tb_6502.o
	ld65 -o TB_6502 tb_6502.o -C ./apple2_c00.inc

tb_6502.o:	tb_6502.s
		ca65 -o tb_6502.o tb_6502.s -l tb_6502.lst

clean:		
		rm -f *.lst *.o tb_6502 *~ add_to_disk TB_6502 a.out
