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
	lemm9.part7.lzsa \
	lemm11.part1.lzsa lemm11.part2.lzsa lemm11.part3.lzsa \
	lemm11.part4.lzsa lemm11.part5.lzsa lemm11.part6.lzsa \
	lemm11.part7.lzsa \
	lemm12.part1.lzsa lemm12.part2.lzsa lemm12.part3.lzsa \
	lemm12.part4.lzsa lemm12.part5.lzsa lemm12.part6.lzsa \
	lemm12.part7.lzsa lemm12.part8.lzsa \
	lemm13.part1.lzsa lemm13.part2.lzsa lemm13.part3.lzsa \
	lemm13.part4.lzsa lemm13.part5.lzsa lemm13.part6.lzsa \
	lemm13.part7.lzsa \
	lemm15.part1.lzsa lemm15.part2.lzsa lemm15.part3.lzsa \
	lemm15.part4.lzsa lemm15.part5.lzsa lemm15.part6.lzsa \
	lemm15.part7.lzsa lemm15.part8.lzsa lemm15.part9.lzsa


lemm5.raw:	lemm5.ym
	$(YM5_TO_RAW) ./lemm5.ym > lemm5.raw

lemm6.raw:	lemm6.ym
	$(YM5_TO_RAW) ./lemm6.ym > lemm6.raw

lemm8.raw:	lemm8.ym
	$(YM5_TO_RAW) ./lemm8.ym > lemm8.raw

lemm9.raw:	lemm9.ym
	$(YM5_TO_RAW) ./lemm9.ym > lemm9.raw

lemm11.raw:	lemm11.ym
	$(YM5_TO_RAW) ./lemm11.ym > lemm11.raw

lemm12.raw:	lemm12.ym
	$(YM5_TO_RAW) ./lemm12.ym > lemm12.raw

lemm13.raw:	lemm13.ym
	$(YM5_TO_RAW) ./lemm13.ym > lemm13.raw

lemm15.raw:	lemm15.ym
	$(YM5_TO_RAW) ./lemm15.ym > lemm15.raw

lemm17.raw:	lemm17.ym
	$(YM5_TO_RAW) ./lemm17.ym > lemm17.raw

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

lemm11.part1:	lemm11.raw
	$(RAW_INTERLEAVE) -m 11 -c 512 ./lemm11

lemm11.part1.lzsa:	lemm11.part1
	$(LZSA) -r -f2 lemm11.part1 lemm11.part1.lzsa

lemm11.part2.lzsa:	lemm11.part2
	$(LZSA) -r -f2 lemm11.part2 lemm11.part2.lzsa

lemm11.part3.lzsa:	lemm11.part3
	$(LZSA) -r -f2 lemm11.part3 lemm11.part3.lzsa

lemm11.part4.lzsa:	lemm11.part4
	$(LZSA) -r -f2 lemm11.part4 lemm11.part4.lzsa

lemm11.part5.lzsa:	lemm11.part5
	$(LZSA) -r -f2 lemm11.part5 lemm11.part5.lzsa

lemm11.part6.lzsa:	lemm11.part6
	$(LZSA) -r -f2 lemm11.part6 lemm11.part6.lzsa

lemm11.part7.lzsa:	lemm11.part7
	$(LZSA) -r -f2 lemm11.part7 lemm11.part7.lzsa

####

lemm12.part1:	lemm12.raw
	$(RAW_INTERLEAVE) -m 11 -c 512 ./lemm12

lemm12.part1.lzsa:	lemm12.part1
	$(LZSA) -r -f2 lemm12.part1 lemm12.part1.lzsa

lemm12.part2.lzsa:	lemm12.part2
	$(LZSA) -r -f2 lemm12.part2 lemm12.part2.lzsa

lemm12.part3.lzsa:	lemm12.part3
	$(LZSA) -r -f2 lemm12.part3 lemm12.part3.lzsa

lemm12.part4.lzsa:	lemm12.part4
	$(LZSA) -r -f2 lemm12.part4 lemm12.part4.lzsa

lemm12.part5.lzsa:	lemm12.part5
	$(LZSA) -r -f2 lemm12.part5 lemm12.part5.lzsa

lemm12.part6.lzsa:	lemm12.part6
	$(LZSA) -r -f2 lemm12.part6 lemm12.part6.lzsa

lemm12.part7.lzsa:	lemm12.part7
	$(LZSA) -r -f2 lemm12.part7 lemm12.part7.lzsa

lemm12.part8.lzsa:	lemm12.part8
	$(LZSA) -r -f2 lemm12.part8 lemm12.part8.lzsa




####

lemm13.part1:	lemm13.raw
	$(RAW_INTERLEAVE) -m 11 -c 512 ./lemm13

lemm13.part1.lzsa:	lemm13.part1
	$(LZSA) -r -f2 lemm13.part1 lemm13.part1.lzsa

lemm13.part2.lzsa:	lemm13.part2
	$(LZSA) -r -f2 lemm13.part2 lemm13.part2.lzsa

lemm13.part3.lzsa:	lemm13.part3
	$(LZSA) -r -f2 lemm13.part3 lemm13.part3.lzsa

lemm13.part4.lzsa:	lemm13.part4
	$(LZSA) -r -f2 lemm13.part4 lemm13.part4.lzsa

lemm13.part5.lzsa:	lemm13.part5
	$(LZSA) -r -f2 lemm13.part5 lemm13.part5.lzsa

lemm13.part6.lzsa:	lemm13.part6
	$(LZSA) -r -f2 lemm13.part6 lemm13.part6.lzsa

lemm13.part7.lzsa:	lemm13.part7
	$(LZSA) -r -f2 lemm13.part7 lemm13.part7.lzsa

lemm13.part8.lzsa:	lemm13.part8
	$(LZSA) -r -f2 lemm13.part8 lemm13.part8.lzsa


####

lemm15.part1:	lemm15.raw
	$(RAW_INTERLEAVE) -m 11 -c 512 ./lemm15

lemm15.part1.lzsa:	lemm15.part1
	$(LZSA) -r -f2 lemm15.part1 lemm15.part1.lzsa

lemm15.part2.lzsa:	lemm15.part2
	$(LZSA) -r -f2 lemm15.part2 lemm15.part2.lzsa

lemm15.part3.lzsa:	lemm15.part3
	$(LZSA) -r -f2 lemm15.part3 lemm15.part3.lzsa

lemm15.part4.lzsa:	lemm15.part4
	$(LZSA) -r -f2 lemm15.part4 lemm15.part4.lzsa

lemm15.part5.lzsa:	lemm15.part5
	$(LZSA) -r -f2 lemm15.part5 lemm15.part5.lzsa

lemm15.part6.lzsa:	lemm15.part6
	$(LZSA) -r -f2 lemm15.part6 lemm15.part6.lzsa

lemm15.part7.lzsa:	lemm15.part7
	$(LZSA) -r -f2 lemm15.part7 lemm15.part7.lzsa

lemm15.part8.lzsa:	lemm15.part8
	$(LZSA) -r -f2 lemm15.part8 lemm15.part8.lzsa

lemm15.part9.lzsa:	lemm15.part9
	$(LZSA) -r -f2 lemm15.part9 lemm15.part9.lzsa


####


clean:	
	rm -f *.lzsa *.part1 *.part2 *.part3 *.part4 *.part5 *.part6 *.part7 *.part8 *.part9 *.part10
