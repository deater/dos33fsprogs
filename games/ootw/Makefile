include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

EMPTY_DISK = ../../empty_disk

all:	ootw.dsk ootw_side2.dsk ootw_side3.dsk

ootw.dsk:	HELLO ./title/TITLE \
		./intro/INTRO ./ootw_c1/OOTW_C1 ./ootw_c2/OOTW_C2 \
		./ootw_c3/OOTW_C3 ./ootw_c4/OOTW_C4 ./ootw_c5/OOTW_C5
	cp $(EMPTY_DISK)/empty.dsk ootw.dsk
	$(DOS33) -y ootw.dsk SAVE A HELLO
	$(DOS33) -y ootw.dsk BSAVE -a 0xd00 ./title/TITLE
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 ./intro/INTRO INTRO
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 ./ootw_c1/OOTW_C1 OOTW_C1
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 ./ootw_c2/OOTW_C2 OOTW_C2
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 ./ootw_c3/OOTW_C3 OOTW_C3
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 ./ootw_c4/OOTW_C4 OOTW_C4
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 ./ootw_c5/OOTW_C5 OOTW_C5

ootw_side2.dsk:	HELLO ./title/TITLE \
	./ootw_c6/OOTW_C6 ./ootw_c7/OOTW_C7 ./ootw_c8/OOTW_C8 \
	./ootw_c9/OOTW_C9 ./ootw_c10/OOTW_C10
	cp $(EMPTY_DISK)/empty.dsk ootw_side2.dsk
	$(DOS33) -y ootw_side2.dsk SAVE A HELLO HELLO
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0xd00 ./title/TITLE
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0x1700 ./ootw_c6/OOTW_C6 OOTW_C6
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0x1700 ./ootw_c7/OOTW_C7 OOTW_C7
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0x1700 ./ootw_c8/OOTW_C8 OOTW_C8
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0x1700 ./ootw_c9/OOTW_C9 OOTW_C9
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0x1700 ./ootw_c10/OOTW_C10 OOTW_C10

ootw_side3.dsk:	HELLO ./title/TITLE ./ending/ENDING \
	./ootw_c11/OOTW_C11 ./ootw_c12/OOTW_C12 ./ootw_c13/OOTW_C13 \
	./ootw_c14/OOTW_C14 ./ootw_c15/OOTW_C15
	cp $(EMPTY_DISK)/empty.dsk ootw_side3.dsk
	$(DOS33) -y ootw_side3.dsk SAVE A HELLO HELLO
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0xd00 ./title/TITLE
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0x1700 ./ootw_c11/OOTW_C11
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0x1700 ./ootw_c12/OOTW_C12
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0x1700 ./ootw_c13/OOTW_C13
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0x1700 ./ootw_c14/OOTW_C14
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0x1700 ./ootw_c15/OOTW_C15
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0x1700 ./ending/ENDING

####

intro/INTRO:
	cd intro && make

ootw_c1/OOTW_C1:
	cd ootw_c1 && make

ootw_c2/OOTW_C2:
	cd ootw_c2 && make

ootw_c3/OOTW_C3:
	cd ootw_c3 && make

ootw_c4/OOTW_C4:
	cd ootw_c4 && make

ootw_c5/OOTW_C5:
	cd ootw_c5 && make

ootw_c6/OOTW_C6:
	cd ootw_c6 && make

ootw_c7/OOTW_C7:
	cd ootw_c7 && make

ootw_c8/OOTW_C8:
	cd ootw_c8 && make

ootw_c9/OOTW_C9:
	cd ootw_c9 && make

ootw_c10/OOTW_C10:
	cd ootw_c10 && make

ootw_c11/OOTW_C11:
	cd ootw_c11 && make

ootw_c12/OOTW_C12:
	cd ootw_c12 && make

ootw_c13/OOTW_C13:
	cd ootw_c13 && make

ootw_c14/OOTW_C14:
	cd ootw_c14 && make

ootw_c15/OOTW_C15:
	cd ootw_c15 && make

ending/ENDING:
	cd ending && make

title/TITLE:
	cd title && make

####


HELLO:  hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####


HELLO2:  hello2.bas
	$(TOKENIZE) < hello2.bas > HELLO2

#####

zip:	ootw.dsk ootw_side2.dsk side3.dsk
	zip ootw.zip ootw.dsk ootw_side2.dsk ootw_side3.dsk

#####

clean:		
		rm -f *~ *.o *.lst HELLO
