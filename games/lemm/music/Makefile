LZSA = ~/research/lzsa/lzsa/lzsa
YM5_TO_RAW = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/ym5_to_raw
YM_TO_YM5 = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/ym_to_ym5
RAW_INTERLEAVE = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/raw_interleave

all:	lemm5.part1.lzsa lemm5.part2.lzsa lemm5.part3.lzsa
#	lemm5.part4.lzsa lemm5.part5.lzsa lemm5.part6.lzsa \
#	lemm5.part7.lzsa lemm5.part8.lzsa

lemm5.raw:	lemm5.ym
	$(YM5_TO_RAW) ./lemm5.ym > lemm5.raw


lemm5.part1:	lemm5.raw
	$(RAW_INTERLEAVE) -m 11 -c 1024 ./lemm5

lemm5.part1.lzsa:	lemm5.part1
	$(LZSA) -r -f2 lemm5.part1 lemm5.part1.lzsa

#lemm5.part2:	lemm5.raw
#	dd conv=notrunc if=lemm5.raw of=lemm5.part2 bs=4096 count=1 seek=1 skip=1

lemm5.part2.lzsa:	lemm5.part2
	$(LZSA) -r -f2 lemm5.part2 lemm5.part2.lzsa


#lemm5.part3:	lemm5.raw
#	dd conv=notrunc if=lemm5.raw of=lemm5.part3 bs=4096 count=1 seek=2 skip=2

lemm5.part3.lzsa:	lemm5.part3
	$(LZSA) -r -f2 lemm5.part3 lemm5.part3.lzsa


#lemm5.part4:	lemm5.raw
#	dd conv=notrunc if=lemm5.raw of=lemm5.part4 bs=4096 count=1 seek=3 skip=3

#lemm5.part4.lzsa:	lemm5.part4
#	$(LZSA) -r -f2 lemm5.part4 lemm5.part4.lzsa


#lemm5.part5:	lemm5.raw
#	dd conv=notrunc if=lemm5.raw of=lemm5.part5 bs=4096 count=1 seek=4 skip=4

#lemm5.part5.lzsa:	lemm5.part5
#	$(LZSA) -r -f2 lemm5.part5 lemm5.part5.lzsa


#lemm5.part6:	lemm5.raw
#	dd conv=notrunc if=lemm5.raw of=lemm5.part6 bs=4096 count=1 seek=5 skip=5

#lemm5.part6.lzsa:	lemm5.part6
#	$(LZSA) -r -f2 lemm5.part1 lemm5.part1.lzsa


#lemm5.part7:	lemm5.raw
#	dd conv=notrunc if=lemm5.raw of=lemm5.part7 bs=4096 count=1 seek=6 skip=6

#lemm5.part7.lzsa:	lemm5.part7
#	$(LZSA) -r -f2 lemm5.part7 lemm5.part7.lzsa


#lemm5.part8:	lemm5.raw
#	dd conv=notrunc if=lemm5.raw of=lemm5.part8 bs=4096 count=1 seek=7 skip=7

#lemm5.part8.lzsa:	lemm5.part8
#	$(LZSA) -r -f2 lemm5.part8 lemm5.part8.lzsa


clean:	
	rm -f *.lzsa *.part1 *.part2 *.part3 *.part4 *.part5 *.part6 *.part7 *.part8
