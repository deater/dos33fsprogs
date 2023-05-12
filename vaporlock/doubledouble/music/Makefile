YM5_TO_RAW = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/ym5_to_raw
YM_TO_YM5 = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/ym_to_ym5
RAW_INTERLEAVE = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/raw_interleave
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	fighting.part1.zx02 fighting.part2.zx02 fighting.part3.zx02 \
	fighting.part4.zx02 fighting.part5.zx02 fighting.part6.zx02 \
	fighting.part7.zx02 fighting.part8.zx02 fighting.part9.zx02 \
	fighting.part10.zx02

fighting.raw:	fighting.ym
	$(YM5_TO_RAW) ./fighting.ym > fighting.raw

####

fighting.part1:	fighting.raw
	$(RAW_INTERLEAVE) -m 11 -c 512 ./fighting

fighting.part1.zx02:	fighting.part1
	$(ZX02)  fighting.part1 fighting.part1.zx02

fighting.part2.zx02:	fighting.part2
	$(ZX02)  fighting.part2 fighting.part2.zx02

fighting.part3.zx02:	fighting.part3
	$(ZX02)  fighting.part3 fighting.part3.zx02

fighting.part4.zx02:	fighting.part4
	$(ZX02)  fighting.part4 fighting.part4.zx02

fighting.part5.zx02:	fighting.part5
	$(ZX02)  fighting.part5 fighting.part5.zx02

fighting.part6.zx02:	fighting.part6
	$(ZX02)  fighting.part6 fighting.part6.zx02

fighting.part7.zx02:	fighting.part7
	$(ZX02)  fighting.part7 fighting.part7.zx02

fighting.part8.zx02:	fighting.part8
	$(ZX02)  fighting.part8 fighting.part8.zx02

fighting.part9.zx02:	fighting.part9
	$(ZX02)  fighting.part9 fighting.part9.zx02

fighting.part10.zx02:	fighting.part10
	$(ZX02)  fighting.part10 fighting.part10.zx02



####


clean:	
	rm -f *.zx02 *.part1 *.part2 *.part3 *.part4 *.part5 *.part6 *.part7 *.part8 *.part9 *.part10
