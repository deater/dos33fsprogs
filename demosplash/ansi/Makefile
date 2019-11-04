ANSI2PNG = ~/research/ansi2gif/ansi2gif.git/ansi2png

all:	kfest2020.png

kfest2020.png:	kfest2020.ans
	$(ANSI2PNG) --ysize auto kfest2020.ans  > kfest2020.png

clean:	
	rm -f kfest2020.png *~
