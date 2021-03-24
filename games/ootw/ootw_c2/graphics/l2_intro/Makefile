include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_l2intro.inc

#####

ootw_l2intro.inc:	\
	cage_01.lzsa cage_02.lzsa cage_03.lzsa cage_04.lzsa \
	eyes_bg.lzsa eyes_01.lzsa eyes_02.lzsa eyes_03.lzsa \
	eyes_04.lzsa eyes_05.lzsa \
	friend02.lzsa friend03.lzsa friend04.lzsa friend05.lzsa friend06.lzsa
	echo "cage_01_lzsa: .incbin \"cage_01.lzsa\"" > ootw_l2intro.inc
	echo "cage_02_lzsa: .incbin \"cage_02.lzsa\"" >> ootw_l2intro.inc
	echo "cage_03_lzsa: .incbin \"cage_03.lzsa\"" >> ootw_l2intro.inc
	echo "cage_04_lzsa: .incbin \"cage_04.lzsa\"" >> ootw_l2intro.inc
	echo "eyes_bg_lzsa: .incbin \"eyes_bg.lzsa\"" >> ootw_l2intro.inc
	echo "eyes_01_lzsa: .incbin \"eyes_01.lzsa\"" >> ootw_l2intro.inc
	echo "eyes_02_lzsa: .incbin \"eyes_02.lzsa\"" >> ootw_l2intro.inc
	echo "eyes_03_lzsa: .incbin \"eyes_03.lzsa\"" >> ootw_l2intro.inc
	echo "eyes_04_lzsa: .incbin \"eyes_04.lzsa\"" >> ootw_l2intro.inc
	echo "eyes_05_lzsa: .incbin \"eyes_05.lzsa\"" >> ootw_l2intro.inc
	echo "friend_02_lzsa: .incbin \"friend02.lzsa\"" >> ootw_l2intro.inc
	echo "friend_03_lzsa: .incbin \"friend03.lzsa\"" >> ootw_l2intro.inc
	echo "friend_04_lzsa: .incbin \"friend04.lzsa\"" >> ootw_l2intro.inc
	echo "friend_05_lzsa: .incbin \"friend05.lzsa\"" >> ootw_l2intro.inc
	echo "friend_06_lzsa: .incbin \"friend06.lzsa\"" >> ootw_l2intro.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.inc

