LZSA = ~/research/lzsa/lzsa/lzsa
YM5_TO_RAW = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/ym5_to_raw




all:	lemmings5.part1.lzsa lemmings5.part2.lzsa lemmings5.part3.lzsa \
	lemmings5.part4.lzsa lemmings5.part5.lzsa lemmings5.part6.lzsa \
	lemmings5.part7.lzsa lemmings5.part8.lzsa

Lemmings5.raw:	Lemmings5.ym
	$(YM5_TO_RAW) ./Lemmings5.ym > Lemmings5.raw


lemmings5.part1:	Lemmings5.raw
	dd conv=notrunc if=Lemmings5.raw of=lemmings5.part1 bs=4096 count=1 seek=0 skip=0

lemmings5.part1.lzsa:	lemmings5.part1
	$(LZSA) -r -f2 lemmings5.part1 lemmings5.part1.lzsa


lemmings5.part2:	Lemmings5.raw
	dd conv=notrunc if=Lemmings5.raw of=lemmings5.part2 bs=4096 count=1 seek=1 skip=1

lemmings5.part2.lzsa:	lemmings5.part2
	$(LZSA) -r -f2 lemmings5.part2 lemmings5.part2.lzsa


lemmings5.part3:	Lemmings5.raw
	dd conv=notrunc if=Lemmings5.raw of=lemmings5.part3 bs=4096 count=1 seek=2 skip=2

lemmings5.part3.lzsa:	lemmings5.part3
	$(LZSA) -r -f2 lemmings5.part3 lemmings5.part3.lzsa


lemmings5.part4:	Lemmings5.raw
	dd conv=notrunc if=Lemmings5.raw of=lemmings5.part4 bs=4096 count=1 seek=3 skip=3

lemmings5.part4.lzsa:	lemmings5.part4
	$(LZSA) -r -f2 lemmings5.part4 lemmings5.part4.lzsa


lemmings5.part5:	Lemmings5.raw
	dd conv=notrunc if=Lemmings5.raw of=lemmings5.part5 bs=4096 count=1 seek=4 skip=4

lemmings5.part5.lzsa:	lemmings5.part5
	$(LZSA) -r -f2 lemmings5.part5 lemmings5.part5.lzsa


lemmings5.part6:	Lemmings5.raw
	dd conv=notrunc if=Lemmings5.raw of=lemmings5.part6 bs=4096 count=1 seek=5 skip=5

lemmings5.part6.lzsa:	lemmings5.part6
	$(LZSA) -r -f2 lemmings5.part1 lemmings5.part1.lzsa


lemmings5.part7:	Lemmings5.raw
	dd conv=notrunc if=Lemmings5.raw of=lemmings5.part7 bs=4096 count=1 seek=6 skip=6

lemmings5.part7.lzsa:	lemmings5.part7
	$(LZSA) -r -f2 lemmings5.part7 lemmings5.part7.lzsa


lemmings5.part8:	Lemmings5.raw
	dd conv=notrunc if=Lemmings5.raw of=lemmings5.part8 bs=4096 count=1 seek=7 skip=7

lemmings5.part8.lzsa:	lemmings5.part8
	$(LZSA) -r -f2 lemmings5.part8 lemmings5.part8.lzsa


clean:	
	rm -f *.lzsa *.part1 *.part2 *.part3 *.part4 *.part5 *.part6 *.part7 *.part8
