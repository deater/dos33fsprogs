include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c16_end.inc

#####

ootw_c16_end.inc:	\
	blank.lzsa wing_bg.lzsa \
	left_unfurl1.lzsa left_unfurl2.lzsa \
	right_unfurl1.lzsa right_unfurl2.lzsa \
	sky_bg.lzsa \
	rooftop00.lzsa rooftop01.lzsa rooftop02.lzsa rooftop03.lzsa onboard.lzsa \
	flying01.lzsa flying03.lzsa flying05.lzsa flying07.lzsa flying09.lzsa \
	flying11.lzsa \
	the_end01.lzsa the_end02.lzsa the_end03.lzsa the_end04.lzsa the_end05.lzsa \
	the_end06.lzsa the_end07.lzsa the_end08.lzsa the_end09.lzsa the_end10.lzsa
	echo "wing_bg_lzsa: .incbin \"wing_bg.lzsa\"" > ootw_c16_end.inc
	echo "left_unfurl1_lzsa: .incbin \"left_unfurl1.lzsa\"" >> ootw_c16_end.inc
	echo "left_unfurl2_lzsa: .incbin \"left_unfurl2.lzsa\"" >> ootw_c16_end.inc
	echo "right_unfurl1_lzsa: .incbin \"right_unfurl1.lzsa\"" >> ootw_c16_end.inc
	echo "right_unfurl2_lzsa: .incbin \"right_unfurl2.lzsa\"" >> ootw_c16_end.inc
	echo "sky_bg_lzsa: .incbin \"sky_bg.lzsa\"" >> ootw_c16_end.inc
	echo "rooftop00_lzsa: .incbin \"rooftop00.lzsa\"" >> ootw_c16_end.inc
	echo "rooftop01_lzsa: .incbin \"rooftop01.lzsa\"" >> ootw_c16_end.inc
	echo "rooftop02_lzsa: .incbin \"rooftop02.lzsa\"" >> ootw_c16_end.inc
	echo "rooftop03_lzsa: .incbin \"rooftop03.lzsa\"" >> ootw_c16_end.inc
	echo "onboard_lzsa: .incbin \"onboard.lzsa\"" >> ootw_c16_end.inc
	echo "flying01_lzsa: .incbin \"flying01.lzsa\"" >> ootw_c16_end.inc
	echo "flying03_lzsa: .incbin \"flying03.lzsa\"" >> ootw_c16_end.inc
	echo "flying05_lzsa: .incbin \"flying05.lzsa\"" >> ootw_c16_end.inc
	echo "flying07_lzsa: .incbin \"flying07.lzsa\"" >> ootw_c16_end.inc
	echo "flying09_lzsa: .incbin \"flying09.lzsa\"" >> ootw_c16_end.inc
	echo "flying11_lzsa: .incbin \"flying11.lzsa\"" >> ootw_c16_end.inc
	echo "the_end01_lzsa: .incbin \"the_end01.lzsa\"" >> ootw_c16_end.inc
	echo "the_end02_lzsa: .incbin \"the_end02.lzsa\"" >> ootw_c16_end.inc
	echo "the_end03_lzsa: .incbin \"the_end03.lzsa\"" >> ootw_c16_end.inc
	echo "the_end04_lzsa: .incbin \"the_end04.lzsa\"" >> ootw_c16_end.inc
	echo "the_end05_lzsa: .incbin \"the_end05.lzsa\"" >> ootw_c16_end.inc
	echo "the_end06_lzsa: .incbin \"the_end06.lzsa\"" >> ootw_c16_end.inc
	echo "the_end07_lzsa: .incbin \"the_end07.lzsa\"" >> ootw_c16_end.inc
	echo "the_end08_lzsa: .incbin \"the_end08.lzsa\"" >> ootw_c16_end.inc
	echo "the_end09_lzsa: .incbin \"the_end09.lzsa\"" >> ootw_c16_end.inc
	echo "the_end10_lzsa: .incbin \"the_end10.lzsa\"" >> ootw_c16_end.inc
	echo "blank_lzsa: .incbin \"blank.lzsa\"" >> ootw_c16_end.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.gr *.inc

