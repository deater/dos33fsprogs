TEXT_TO_YM = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/text_to_ym
YM_TO_YM5 = ~/research/vmw-meter.git/ay-3-8910/conversion_tools/ym_to_ym5

all:	weave1.ym5

weave1.ym:	$(TEXT_TO_YM) weave1.txt
	$(TEXT_TO_YM) weave1.txt weave1

weave1.ym5:	$(YM_TO_YM5) weave1.ym
	$(YM_TO_YM5) weave1

