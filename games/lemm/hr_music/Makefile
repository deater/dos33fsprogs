LZSA = ~/research/lzsa/lzsa/lzsa
YM5_TO_RAW = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/ym5_to_raw
YM_TO_YM5 = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/ym_to_ym5
RAW_INTERLEAVE = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/raw_interleave

all:	lemm5.part1.lzsa lemm5.part2.lzsa lemm5.part3.lzsa \
	lemm2.part1.lzsa lemm2.part2.lzsa lemm2.part3.lzsa \
	lemm2.part4.lzsa lemm2.part5.lzsa lemm2.part6.lzsa \
	lemm2.part7.lzsa lemm2.part8.lzsa lemm2.part9.lzsa \
	lemm2.part10.lzsa lemm2.part11.lzsa lemm2.part12.lzsa \
	lemm2.part13.lzsa lemm2.part14.lzsa lemm2.part15.lzsa \
	lemm2.part16.lzsa lemm2.part17.lzsa lemm2.part18.lzsa

lemm5.raw:	lemm5.ym
	$(YM5_TO_RAW) ./lemm5.ym > lemm5.raw

lemm2.raw:	intro2.ym
	$(YM5_TO_RAW) ./intro2.ym > lemm2.raw

####

lemm5.part1:	lemm5.raw
	$(RAW_INTERLEAVE) -m 11 -c 512 ./lemm5

lemm5.part1.lzsa:	lemm5.part1
	$(LZSA) -r -f2 lemm5.part1 lemm5.part1.lzsa

lemm5.part2.lzsa:	lemm5.part2
	$(LZSA) -r -f2 lemm5.part2 lemm5.part2.lzsa

lemm5.part3.lzsa:	lemm5.part3
	$(LZSA) -r -f2 lemm5.part3 lemm5.part3.lzsa

lemm5.part4.lzsa:	lemm5.part4
	$(LZSA) -r -f2 lemm5.part4 lemm5.part4.lzsa

lemm5.part5.lzsa:	lemm5.part5
	$(LZSA) -r -f2 lemm5.part5 lemm5.part5.lzsa

####

lemm2.part1:	lemm2.raw
	$(RAW_INTERLEAVE) -m 11 -c 512 ./lemm2

lemm2.part1.lzsa:	lemm2.part1
	$(LZSA) -r -f2 lemm2.part1 lemm2.part1.lzsa

lemm2.part2.lzsa:	lemm2.part2
	$(LZSA) -r -f2 lemm2.part2 lemm2.part2.lzsa

lemm2.part3.lzsa:	lemm2.part3
	$(LZSA) -r -f2 lemm2.part3 lemm2.part3.lzsa

lemm2.part4.lzsa:	lemm2.part4
	$(LZSA) -r -f2 lemm2.part4 lemm2.part4.lzsa

lemm2.part5.lzsa:	lemm2.part5
	$(LZSA) -r -f2 lemm2.part5 lemm2.part5.lzsa

lemm2.part6.lzsa:	lemm2.part6
	$(LZSA) -r -f2 lemm2.part6 lemm2.part6.lzsa

lemm2.part7.lzsa:	lemm2.part7
	$(LZSA) -r -f2 lemm2.part7 lemm2.part7.lzsa

lemm2.part8.lzsa:	lemm2.part8
	$(LZSA) -r -f2 lemm2.part8 lemm2.part8.lzsa

lemm2.part9.lzsa:	lemm2.part9
	$(LZSA) -r -f2 lemm2.part9 lemm2.part9.lzsa

lemm2.part10.lzsa:	lemm2.part10
	$(LZSA) -r -f2 lemm2.part10 lemm2.part10.lzsa

lemm2.part11.lzsa:	lemm2.part11
	$(LZSA) -r -f2 lemm2.part11 lemm2.part11.lzsa

lemm2.part12.lzsa:	lemm2.part12
	$(LZSA) -r -f2 lemm2.part12 lemm2.part12.lzsa

lemm2.part13.lzsa:	lemm2.part13
	$(LZSA) -r -f2 lemm2.part13 lemm2.part13.lzsa

lemm2.part14.lzsa:	lemm2.part14
	$(LZSA) -r -f2 lemm2.part14 lemm2.part14.lzsa

lemm2.part15.lzsa:	lemm2.part15
	$(LZSA) -r -f2 lemm2.part15 lemm2.part15.lzsa

lemm2.part16.lzsa:	lemm2.part16
	$(LZSA) -r -f2 lemm2.part16 lemm2.part16.lzsa

lemm2.part17.lzsa:	lemm2.part17
	$(LZSA) -r -f2 lemm2.part17 lemm2.part17.lzsa

lemm2.part18.lzsa:	lemm2.part18
	$(LZSA) -r -f2 lemm2.part18 lemm2.part18.lzsa





####


clean:	
	rm -f *.lzsa *.part1 *.part2 *.part3 *.part4 *.part5 *.part6 *.part7 *.part8 *.part9 *.part10
