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
	lemm2.part16.lzsa lemm2.part17.lzsa lemm2.part18.lzsa \
	never.part1.lzsa never.part2.lzsa never.part3.lzsa \
	never.part4.lzsa never.part5.lzsa never.part6.lzsa \
	never.part7.lzsa never.part8.lzsa never.part9.lzsa \
	never.part10.lzsa never.part11.lzsa never.part12.lzsa \
	never.part13.lzsa never.part14.lzsa never.part15.lzsa \
	never.part16.lzsa never.part17.lzsa never.part18.lzsa

lemm5.raw:	lemm5.ym
	$(YM5_TO_RAW) ./lemm5.ym > lemm5.raw

lemm2.raw:	intro2.ym
	$(YM5_TO_RAW) ./intro2.ym > lemm2.raw

never.raw:	never.ym
	$(YM5_TO_RAW) ./never.ym > never.raw


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

never.part1:	never.raw
	$(RAW_INTERLEAVE) -m 11 -c 512 ./never

never.part1.lzsa:	never.part1
	$(LZSA) -r -f2 never.part1 never.part1.lzsa

never.part2.lzsa:	never.part2
	$(LZSA) -r -f2 never.part2 never.part2.lzsa

never.part3.lzsa:	never.part3
	$(LZSA) -r -f2 never.part3 never.part3.lzsa

never.part4.lzsa:	never.part4
	$(LZSA) -r -f2 never.part4 never.part4.lzsa

never.part5.lzsa:	never.part5
	$(LZSA) -r -f2 never.part5 never.part5.lzsa

never.part6.lzsa:	never.part6
	$(LZSA) -r -f2 never.part6 never.part6.lzsa

never.part7.lzsa:	never.part7
	$(LZSA) -r -f2 never.part7 never.part7.lzsa

never.part8.lzsa:	never.part8
	$(LZSA) -r -f2 never.part8 never.part8.lzsa

never.part9.lzsa:	never.part9
	$(LZSA) -r -f2 never.part9 never.part9.lzsa

never.part10.lzsa:	never.part10
	$(LZSA) -r -f2 never.part10 never.part10.lzsa

never.part11.lzsa:	never.part11
	$(LZSA) -r -f2 never.part11 never.part11.lzsa

never.part12.lzsa:	never.part12
	$(LZSA) -r -f2 never.part12 never.part12.lzsa

never.part13.lzsa:	never.part13
	$(LZSA) -r -f2 never.part13 never.part13.lzsa

never.part14.lzsa:	never.part14
	$(LZSA) -r -f2 never.part14 never.part14.lzsa

never.part15.lzsa:	never.part15
	$(LZSA) -r -f2 never.part15 never.part15.lzsa

never.part16.lzsa:	never.part16
	$(LZSA) -r -f2 never.part16 never.part16.lzsa

never.part17.lzsa:	never.part17
	$(LZSA) -r -f2 never.part17 never.part17.lzsa

never.part18.lzsa:	never.part18
	$(LZSA) -r -f2 never.part18 never.part18.lzsa






####


clean:	
	rm -f *.lzsa *.part1 *.part2 *.part3 *.part4 *.part5 *.part6 *.part7 *.part8 *.part9 *.part10
