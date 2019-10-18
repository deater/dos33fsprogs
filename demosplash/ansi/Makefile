ANSI2PNG = ~/research/ansi2gif/ansi2gif.git/ansi2png

all:	kfest.png

kfest.png:	kfest.ans
	$(ANSI2PNG) --ysize auto kfest.ans  > kfest.png

clean:	
	rm -f kfest.png *~
