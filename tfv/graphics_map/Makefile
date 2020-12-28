include ../../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

tfv_backgrounds.inc:	\
	map.lzsa landing.lzsa harfco.lzsa \
	belair.lzsa math_office.lzsa video_hr.lzsa \
	collegep.lzsa umcp.lzsa dining.lzsa metro.lzsa \
	talbot.lzsa
	echo "map_lzsa: .incbin \"map.lzsa\"" >> tfv_backgrounds.inc
	echo "landing_lzsa: .incbin \"landing.lzsa\"" >> tfv_backgrounds.inc
	echo "harfco_lzsa: .incbin \"harfco.lzsa\"" >> tfv_backgrounds.inc
	echo "belair_lzsa: .incbin \"belair.lzsa\"" >> tfv_backgrounds.inc
	echo "math_office_lzsa: .incbin \"math_office.lzsa\"" >> tfv_backgrounds.inc
	echo "video_hr_lzsa: .incbin \"video_hr.lzsa\"" >> tfv_backgrounds.inc
	echo "collegep_lzsa: .incbin \"collegep.lzsa\"" >> tfv_backgrounds.inc
	echo "umcp_lzsa: .incbin \"umcp.lzsa\"" >> tfv_backgrounds.inc
	echo "dining_lzsa: .incbin \"dining.lzsa\"" >> tfv_backgrounds.inc
	echo "metro_lzsa: .incbin \"metro.lzsa\"" >> tfv_backgrounds.inc
	echo "talbot_lzsa: .incbin \"talbot.lzsa\"" >> tfv_backgrounds.inc

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

clean:	
	rm -f *~ tfv_backgrounds.inc

