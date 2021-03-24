include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c2_laser.inc

#####

ootw_c2_laser.inc:	\
	laser_bg.lzsa \
	laserg01.lzsa laserg02.lzsa laserg03.lzsa laserg04.lzsa \
	laserg05.lzsa laserg06.lzsa laserg07.lzsa laserg08.lzsa blank.lzsa
	echo "laser_bg_lzsa: .incbin \"laser_bg.lzsa\"" > ootw_c2_laser.inc
	echo "laserg_01_lzsa: .incbin \"laserg01.lzsa\"" >> ootw_c2_laser.inc
	echo "laserg_02_lzsa: .incbin \"laserg02.lzsa\"" >> ootw_c2_laser.inc
	echo "laserg_03_lzsa: .incbin \"laserg03.lzsa\"" >> ootw_c2_laser.inc
	echo "laserg_04_lzsa: .incbin \"laserg04.lzsa\"" >> ootw_c2_laser.inc
	echo "laserg_05_lzsa: .incbin \"laserg05.lzsa\"" >> ootw_c2_laser.inc
	echo "laserg_06_lzsa: .incbin \"laserg06.lzsa\"" >> ootw_c2_laser.inc
	echo "laserg_07_lzsa: .incbin \"laserg07.lzsa\"" >> ootw_c2_laser.inc
	echo "laserg_08_lzsa: .incbin \"laserg08.lzsa\"" >> ootw_c2_laser.inc
	echo "laserg_blank_lzsa: .incbin \"blank.lzsa\"" >> ootw_c2_laser.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.gr *.inc

