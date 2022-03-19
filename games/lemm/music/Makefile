LZSA = ~/research/lzsa/lzsa/lzsa
YM5_TO_RAW = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/ym5_to_raw
YM_TO_YM5 = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/ym_to_ym5
RAW_INTERLEAVE = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/raw_interleave

all:	lemm5.part1.lzsa lemm5.part2.lzsa lemm5.part3.lzsa \
	lemm5.part4.lzsa lemm5.part5.lzsa \
	lemm6.part1.lzsa lemm6.part2.lzsa lemm6.part3.lzsa \
	lemm6.part4.lzsa lemm6.part5.lzsa lemm6.part6.lzsa \
	lemm6.part7.lzsa lemm6.part8.lzsa lemm6.part9.lzsa \
	lemm6.part10.lzsa \
	lemm8.part1.lzsa lemm8.part2.lzsa lemm8.part3.lzsa \
	lemm8.part4.lzsa lemm8.part5.lzsa lemm8.part6.lzsa \
	lemm8.part7.lzsa \
	lemm9.part1.lzsa lemm9.part2.lzsa lemm9.part3.lzsa \
	lemm9.part4.lzsa lemm9.part5.lzsa lemm9.part6.lzsa \
	lemm9.part7.lzsa



lemm5.raw:	lemm5.ym
	$(YM5_TO_RAW) ./lemm5.ym > lemm5.raw

lemm6.raw:	lemm6.ym
	$(YM5_TO_RAW) ./lemm6.ym > lemm6.raw

lemm8.raw:	lemm8.ym
	$(YM5_TO_RAW) ./lemm8.ym > lemm8.raw

lemm9.raw:	lemm9.ym
	$(YM5_TO_RAW) ./lemm9.ym > lemm9.raw

lemm10.raw:	lemm10.ym
	$(YM5_TO_RAW) ./lemm10.ym > lemm10.raw

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

lemm6.part1:	lemm6.raw
	$(RAW_INTERLEAVE) -m 11 -c 512 ./lemm6

lemm6.part1.lzsa:	lemm6.part1
	$(LZSA) -r -f2 lemm6.part1 lemm6.part1.lzsa

lemm6.part2.lzsa:	lemm6.part2
	$(LZSA) -r -f2 lemm6.part2 lemm6.part2.lzsa

lemm6.part3.lzsa:	lemm6.part3
	$(LZSA) -r -f2 lemm6.part3 lemm6.part3.lzsa

lemm6.part4.lzsa:	lemm6.part4
	$(LZSA) -r -f2 lemm6.part4 lemm6.part4.lzsa

lemm6.part5.lzsa:	lemm6.part5
	$(LZSA) -r -f2 lemm6.part5 lemm6.part5.lzsa

lemm6.part6.lzsa:	lemm6.part6
	$(LZSA) -r -f2 lemm6.part6 lemm6.part6.lzsa

lemm6.part7.lzsa:	lemm6.part7
	$(LZSA) -r -f2 lemm6.part7 lemm6.part7.lzsa

lemm6.part8.lzsa:	lemm6.part8
	$(LZSA) -r -f2 lemm6.part8 lemm6.part8.lzsa

lemm6.part9.lzsa:	lemm6.part9
	$(LZSA) -r -f2 lemm6.part9 lemm6.part9.lzsa

lemm6.part10.lzsa:	lemm6.part10
	$(LZSA) -r -f2 lemm6.part10 lemm6.part10.lzsa

####

lemm8.part1:	lemm8.raw
	$(RAW_INTERLEAVE) -m 11 -c 512 ./lemm8

lemm8.part1.lzsa:	lemm8.part1
	$(LZSA) -r -f2 lemm8.part1 lemm8.part1.lzsa

lemm8.part2.lzsa:	lemm8.part2
	$(LZSA) -r -f2 lemm8.part2 lemm8.part2.lzsa

lemm8.part3.lzsa:	lemm8.part3
	$(LZSA) -r -f2 lemm8.part3 lemm8.part3.lzsa

lemm8.part4.lzsa:	lemm8.part4
	$(LZSA) -r -f2 lemm8.part4 lemm8.part4.lzsa

lemm8.part5.lzsa:	lemm8.part5
	$(LZSA) -r -f2 lemm8.part5 lemm8.part5.lzsa

lemm8.part6.lzsa:	lemm8.part6
	$(LZSA) -r -f2 lemm8.part6 lemm8.part6.lzsa

lemm8.part7.lzsa:	lemm8.part7
	$(LZSA) -r -f2 lemm8.part7 lemm8.part7.lzsa

####

lemm9.part1:	lemm9.raw
	$(RAW_INTERLEAVE) -m 11 -c 512 ./lemm9

lemm9.part1.lzsa:	lemm9.part1
	$(LZSA) -r -f2 lemm9.part1 lemm9.part1.lzsa

lemm9.part2.lzsa:	lemm9.part2
	$(LZSA) -r -f2 lemm9.part2 lemm9.part2.lzsa

lemm9.part3.lzsa:	lemm9.part3
	$(LZSA) -r -f2 lemm9.part3 lemm9.part3.lzsa

lemm9.part4.lzsa:	lemm9.part4
	$(LZSA) -r -f2 lemm9.part4 lemm9.part4.lzsa

lemm9.part5.lzsa:	lemm9.part5
	$(LZSA) -r -f2 lemm9.part5 lemm9.part5.lzsa

lemm9.part6.lzsa:	lemm9.part6
	$(LZSA) -r -f2 lemm9.part6 lemm9.part6.lzsa

lemm9.part7.lzsa:	lemm9.part7
	$(LZSA) -r -f2 lemm9.part7 lemm9.part7.lzsa



####


clean:	
	rm -f *.lzsa *.part1 *.part2 *.part3 *.part4 *.part5 *.part6 *.part7 *.part8 *.part9 *.part10
