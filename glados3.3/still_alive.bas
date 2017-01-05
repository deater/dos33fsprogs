1 REM PORTAL CLOSING CREDITS APPLESOFT
2 REM BASED ON QBASIC VERSION BY Thomas Moss (spinneretsystems)
'
' Size Opt: Final Version = 20557
'	Move Line 20 to Line 8 = 20182
'
5 TEXT:PRINT CHR$(4)+"PR#3": REM 80 COLUMN MODE
7 HOME:C$=CHR$(13):GOTO 50
'
' SLOWTEXT 
'
8 FOR C = 1 TO LEN(T$):PRINT MID$(T$, C, 1);:FOR I = 1 TO 1:NEXT I: NEXT C:POKE 768,F:POKE 769,D:CALL 770:RETURN
'
10 REM SET LEFT WINDOW
11 POKE 32,2:POKE 33,35:POKE 34,1:POKE 35,21
12 RETURN
15 REM SET RIGHT WINDOW
16 POKE 32,39:POKE 33,40:POKE 34,1:POKE 35,23
17 RETURN
'
' Restore Cursor
'
18 X=PEEK(1403):Y=PEEK(37):RETURN
19 POKE 36,X:POKE 37,Y-1:RETURN
'
30 REM FASTTEXT
31 FOR C = 1 TO LEN(T$)
32 PRINT MID$(T$, C, 1);
33 FOR I = 1 TO 25:NEXT I
34 NEXT C
35 RETURN
'
' Assembly Language audio routine
' See http://eightbitsoundandfury.ld8.org/programming.html
50 FOR L = 770 TO 790: READ V: POKE L,V: NEXT L
51 DATA 173,48,192,136,208,5,206,1,3,240,9,202,208,245,174,0,3,76,2,3,96
55 PRINT " ------------------------------------ "
57 FOR I=1 TO 20: PRINT "|                                    |":NEXT I
60 PRINT " ------------------------------------ "
65 GOSUB 10
'
70 HOME
72 T$="Forms FORM-29827281-12:"+C$:GOSUB 30
74 T$="Test Assessment Report"+C$:GOSUB 30
76 PRINT:PRINT
78 FOR I=1 TO 1000: NEXT I
'
' This was a triumph.
'
80 T$="This ":D=54:F=85:GOSUB 8
82 T$="was ":F=91:GOSUB 8
84 T$="a ":F=102:GOSUB 8
86 T$="tri":GOSUB 8
89 T$="umph."+C$:F=91:GOSUB 8
90 FOR I=1 TO 800:NEXT
'
' I'm making a note here:
'
94 T$="I'm ":F=152:GOSUB 8
96 T$="ma":F=85:GOSUB 8
98 T$="king ":F=91:GOSUB 8
100 T$="a ":F=102:GOSUB 8
102 T$="note ":D=108:F=102:GOSUB 8
104 T$ = "here:"+C$:D=54:F=91:GOSUB 8
105 FOR I=1 TO 160: NEXT
'
' HUGE SUCCESS.
'
106 T$ = "HUGE ":D=108:F=114:GOSUB 8
108 T$ = "SUC":D=54:F=102:GOSUB 8
110 T$ = "CESS."+C$:D=108:F=152:GOSUB 8
111 FOR I=1 TO 480: NEXT
'
' It's hard to overstate
'
112 T$="It's ":D=54:F=152:GOSUB 8
114 T$="hard ":D=108:F=102:GOSUB 8
116 T$="to ":D=54:F=91:GOSUB 8
118 T$="o":D=162:F=85:GOSUB 8
120 T$="ver":D=54:F=91:GOSUB 8
122 T$="state"+C$:D=108:F=121:GOSUB 8
'
' my satisfaction.
'
124 T$="my ":D=162:F=114:GOSUB 8
126 T$="sa":D=108:F=102:GOSUB 8
128 T$="tis":D=54:F=152:GOSUB 8
130 T$="fac":D=108:F=152:GOSUB 8
132 T$="tion."+C$:F=91:GOSUB 8
133 FOR I=1 TO 720:NEXT
'
' APERTURE SCIENCE LOGO
134 GOSUB 18:GOSUB 15:HOME:GOSUB 2000:GOSUB 10:GOSUB 19:PRINT
'
' Aperture Science
136 T$="A":D=54:F=85:GOSUB 8
138 T$="per":F=91:GOSUB 8
140 T$="ture ":F=102:GOSUB 8
142 T$="Sci":GOSUB 8
144 T$="ence"+C$:F=91:GOSUB 8
145 FOR I=1 TO 800:NEXT
'
' We do what we must
'
146 T$="We ":F=152:GOSUB 8
148 T$="do ":F=85:GOSUB 8
150 T$="what ":F=91:GOSUB 8
152 T$="we ":F=102:GOSUB 8
154 T$="must"+C$:GOSUB 8
155 FOR I=1 TO 160: NEXT
'
' because we can.
'
156 T$="be":F=91:GOSUB 8
158 T$="cause ":F=114:GOSUB 8
159 FOR I=1 TO 160: NEXT
160 T$="we ":F=102:GOSUB 8
162 T$="can."+C$:D=162:F=152:GOSUB 8
163 FOR I=1 TO 560: NEXT
'
' For the good of all of us.
'
164 T$="For ":D=108:F=102:GOSUB 8
166 T$="the ":D=54:F=91:GOSUB 8
168 T$="good ":D=162:F=85:GOSUB 8
170 T$="of ":D=54:F=102:GOSUB 8
172 T$="all ":D=162:F=121:GOSUB 8
174 T$="of ":D=54:F=114:GOSUB 8
176 T$="us."+C$:F=102:GOSUB 8
'177 FOR I=1 TO 80: NEXT
'
' RADIATION
178 GOSUB 18:GOSUB 15:HOME:GOSUB 2100: GOSUB 10:GOSUB 19:PRINT
'
' Except the ones who are dead.
'
180 T$="Ex":F=152:GOSUB 8
182 T$="cept ":F=114:GOSUB 8
184 T$="the ":F=102:GOSUB 8
186 T$="ones ":F=96:GOSUB 8
188 T$="who ":F=102:GOSUB 8
190 T$="are ":F=114:GOSUB 8
192 T$="dead."+C$:F=128:GOSUB 8
193 FOR I=1 TO 160: NEXT
'
' APERTURE SCIENCE LOGO
194 GOSUB 18:GOSUB 15:HOME:GOSUB 2000: GOSUB 10:GOSUB 19:PRINT
'
' But there's no sense crying\nover every mistake.
'
196 PRINT
198 T$="But ":F=152:GOSUB 8
200 T$="there's ":F=143:GOSUB 8
202 T$="no ":D=108:F=128:GOSUB 8
204 T$="sense ":F=96:GOSUB 8
206 T$="cry":D=54:F=102:GOSUB 8
208 T$="ing"+C$:F=114:GOSUB 8
210 T$="o":GOSUB 8
212 T$="ver ":F=128:GOSUB 8
214 T$="e":F=114:GOSUB 8
216 T$="very ":F=128:GOSUB 8
218 T$="mis":D=108:F=128:GOSUB 8
220 T$="take."+C$:F=128:GOSUB 8
'
' You just keep on trying\ntill you run out of cake.
'
222 T$="You ":D=54:F=152:GOSUB 8
224 T$="just ":F=143:GOSUB 8
226 T$="keep ":D=108:F=128:GOSUB 8
228 T$="on ":F=96:GOSUB 8
230 T$="try":D=54:F=85:GOSUB 8
232 T$="ing"+C$:F=96:GOSUB 8
234 T$="till ":F=102:GOSUB 8
236 T$="you ":F=114:GOSUB 8
238 T$="run ":GOSUB 8
240 T$="out ":F=102:GOSUB 8
242 T$="of ":D=108:F=96:GOSUB 8
244 T$="cake."+C$:F=96:GOSUB 8
'
' ATOM
'
246 GOSUB 18:GOSUB 15:HOME:GOSUB 2200: GOSUB 10:GOSUB 19:PRINT
'
' And the Science gets done.
'
248 T$="And ":D=54:F=85:GOSUB 8
250 T$="the ":F=76:GOSUB 8
252 T$="Sci":F=72:GOSUB 8
254 T$="ence ":GOSUB 8
256 T$="gets ":D=108:F=76:GOSUB 8
258 T$="done."+C$:F=85:GOSUB 8
'
' And you make a neat gun
'
260 T$="And ":D=54:F=96:GOSUB 8
262 T$="you ":F=85:GOSUB 8
264 T$="make ":F=76:GOSUB 8
266 T$="a ":F=76:GOSUB 8
268 T$="neat ":D=108:F=85:GOSUB 8
270 T$="gun."+C$:F=96:GOSUB 8
'
' APERTURE SCIENCE LOGO
272 GOSUB 18:GOSUB 15:HOME:GOSUB 2000: GOSUB 10:GOSUB 19:PRINT
'
' For the people who are
'
274 T$="For ":D=54:F=114:GOSUB 8
276 T$="the ":F=128:GOSUB 8
278 T$="peo":F=114:GOSUB 8
280 T$="ple ":F=96:GOSUB 8
282 T$="who ":GOSUB 8
284 T$="are"+C$:D=108:F=102:GOSUB 8
'
' still alive.
'
286 T$="still ":D=54:F=102:GOSUB 8
288 T$="a":F=91:GOSUB 8
290 T$="live."+C$:D=162:F=91:GOSUB 8
291 FOR I=1 TO 1900: NEXT
'
'
'
292 HOME:C$=CHR$(13):X=FRE(0)
294 T$="Forms FORM-55551-5:"+C$:GOSUB 30
296 T$="Personnel File Addendum:"+C$:GOSUB 30
298 T$=C$+"Dear <<Subject Name Here>>":GOSUB 30
300 PRINT:PRINT
'
' I'm not even angry.
'
302 T$="I'm ":D=54:F=152:GOSUB 8
304 T$="not ":F=85:GOSUB 8
306 T$="e":F=91:GOSUB 8
308 T$="ven ":F=102:GOSUB 8
310 T$="an":GOSUB 8
312 T$="gry."+C$:F=91:GOSUB 8
313 FOR I=1 TO 800: NEXT
'
' I'm being so sincere right now.
'
314 T$="I'm ":F=85:GOSUB 8
316 T$="be":F=91:GOSUB 8
320 T$="ing ":F=102:GOSUB 8
322 T$="so ":D=162:F=102:GOSUB 8
324 T$="sin":D=54:F=91:GOSUB 8
326 T$="cere ":D=108:F=114:GOSUB 8
328 T$="right ":F=102:GOSUB 8
330 T$="now."+C$:F=152:GOSUB 8
331 FOR I=1 TO 560: NEXT
'
' Even though you broke my
'
332 T$="E":F=102:GOSUB 8
334 T$="ven ":D=54:F=91:GOSUB 8
336 T$="though ":D=162:F=85:GOSUB 8
338 T$="you ":D=108:F=102:GOSUB 8
340 T$="broke ":F=121:GOSUB 8
342 T$="my ":D=54:F=114:GOSUB 8
'
' HEART
344 GOSUB 18:GOSUB 15:HOME:GOSUB 2300: GOSUB 10:GOSUB 19:PRINT
345 POKE 36,X
'
' heart.\nAnd killed me.
'
346 T$="heart."+C$:D=162:F=102:GOSUB 8
348 T$="And ":D=54:F=152:GOSUB 8
350 T$="killed ":D=108:F=152:GOSUB 8
352 T$="me."+C$:D=54:F=91:GOSUB 8
353 FOR I=1 TO 720: NEXT
'
' EXPLOSION
'
354 GOSUB 18:GOSUB 15:HOME:GOSUB 2400: GOSUB 10:GOSUB 19:PRINT
'
' And tore me to pieces.
'
356 T$="And ":F=152:GOSUB 8
358 T$="tore ":F=85:GOSUB 8
360 T$="me ":F=91:GOSUB 8
362 T$="to ":F=102:GOSUB 8
364 T$="pie":GOSUB 8
366 T$="ces."+C$:F=91:GOSUB 8
367 FOR I=1 TO 800:NEXT
'
' And threw every peice into
'
368 T$="And ":F=152:GOSUB 8:REM SOUND 220, 4.8
370 T$="threw ":F=85:GOSUB 8
372 T$="ev":F=91:GOSUB 8
374 T$="ery ":F=102:GOSUB 8
376 T$="piece ":GOSUB 8
377 FOR I=1 TO 160: NEXT
378 T$="in":F=91:GOSUB 8
380 T$="to ":F=114:GOSUB 8
'381 FOR I=1 TO 160: NEXT
'
' FIRE
382 GOSUB 18:GOSUB 15:HOME:GOSUB 2500: GOSUB 10:GOSUB 19:PRINT
383 POKE 36,X
'
' a fire.
'
384 T$="a ":F=102:GOSUB 8
386 T$="fire."+C$:D=108:F=152:GOSUB 8
387 FOR I=1 TO 560:NEXT
'
' As they burned it hurt because
'
388 T$="As ":F=102:GOSUB 8
390 T$="they ":D=54:F=91:GOSUB 8
392 T$="burned ":D=162:F=85:GOSUB 8
394 T$="it ":D=108:F=102:GOSUB 8
396 T$="hurt ":F=121:GOSUB 8
398 T$="be":D=54:F=114:GOSUB 8
400 T$="cause"+C$:F=102:GOSUB 8
401 FOR I=1 TO 80: NEXT
'
' I was so happy for you!
'
402 T$="I ":F=152:GOSUB 8:REM SOUND 220, 4.8
404 T$="was ":F=114:GOSUB 8:REM SOUND 293.6, 4.8
406 T$="so ":F=102:GOSUB 8:REM SOUND 329.6, 4.8
408 T$="hap":F=96:GOSUB 8:REM SOUND 349.2, 4.8
410 T$="py ":F=102:GOSUB 8:REM SOUND 329.6, 4.8
412 T$="for ":F=114:GOSUB 8:REM SOUND 293.6, 4.8
414 T$="you!"+C$:F=128:GOSUB 8:REM SOUND 261.6, 14.4
'415 FOR I=1 TO 160: NEXT
'
' CHECK
416 GOSUB 18:GOSUB 15:HOME:GOSUB 2600: GOSUB 10:GOSUB 19:PRINT
'
' Now these points of data\nmake a beautiful line.
'
418 T$="Now ":F=152:GOSUB 8
420 T$="these ":F=143:GOSUB 8
422 T$="points ":D=108:F=128:GOSUB 8
424 T$="of ":F=96:GOSUB 8
426 T$="da":D=54:F=102:GOSUB 8
428 T$="ta"+C$:F=114:GOSUB 8
430 T$="make ":GOSUB 8
432 T$="a ":F=128:GOSUB 8
434 T$="beau":F=114:GOSUB 8
436 T$="ti":F=128:GOSUB 8
438 T$="ful ":D=108:F=128:GOSUB 8
440 T$="line."+C$:F=128:GOSUB 8
'
' And we're out of beta.\nWe're releasing on time.
'
442 T$="And ":D=54:F=152:GOSUB 8
444 T$="we're ":F=143:GOSUB 8
446 T$="out ":D=108:F=128:GOSUB 8
448 T$="of ":F=96:GOSUB 8
450 T$="be":D=54:F=85:GOSUB 8
452 T$="ta."+C$:F=96:GOSUB 8
454 T$="We're ":F=102:GOSUB 8
456 T$="re":F=114:GOSUB 8
458 T$="lea":GOSUB 8
460 T$="sing ":F=102:GOSUB 8
462 T$="on ":D=108:F=96:GOSUB 8
464 T$="time."+C$:F=96:GOSUB 8
'
' EXPLOSION
466 GOSUB 18:GOSUB 15:HOME:GOSUB 2400: GOSUB 10:GOSUB 19:PRINT
'
' So I'm GLaD. I got burned.
'
468 T$="So ":D=54:F=85:GOSUB 8
470 T$="I'm ":F=76:GOSUB 8
472 T$="GLaD. ":F=72:GOSUB 8
474  T$="I ":GOSUB 8
476 T$="got ": D=108:F=76:GOSUB 8
478 T$="burned."+C$:F=85:GOSUB 8
'
' ATOM
'
480 GOSUB 18:GOSUB 15:HOME:GOSUB 2200: GOSUB 10:GOSUB 19:PRINT
'
' Think of all the things we learned
'
482 T$="Think ":D=54:F=96:GOSUB 8
484 T$="of ":F=85:GOSUB 8
486 T$="all ":F=76:GOSUB 8
488 T$="the ":GOSUB 8
490 T$="things ":F=85:GOSUB 8
492 T$="we ":F=96:GOSUB 8
494 T$="learned"+C$:D=108:F=96:GOSUB 8
'
' APERTURE SCIENCE LOGO
'
496 GOSUB 18:GOSUB 15:HOME:GOSUB 2000: GOSUB 10:GOSUB 19:PRINT
'
' for the people who are
'
498 T$="for ":D=54:F=114:GOSUB 8
500 T$="the ":F=128:GOSUB 8
502 T$="peo":F=114:GOSUB 8
504 T$="ple ":F=96:GOSUB 8
506 T$="who ":GOSUB 8
510 T$="are"+C$: D=108:F=102:GOSUB 8
'
' still alive.
'
512 T$="still ":D=54:F=102:GOSUB 8
'
' FIXME: CAN WE DO ALIVE SLOWLY LIKE IN THE VIDEO?
'
513 T$="a":F=91:GOSUB 8
514 T$="live."+C$:D=162:F=91:GOSUB 8
'
' PAGE 3
'
516 HOME:C$=CHR$(13)
517 X=FRE(0)
518 T$="Forms FORM-55551-6:"+C$:GOSUB 30
520 T$="Personnel File Addendum ":GOSUB 30
522 T$="Addendum:"+C$:GOSUB 30
523 PRINT
524 T$="One last thing:"+C$:GOSUB 30
526 PRINT
'
' Go ahead and leave me
'
528 T$="Go ":D=54:F=85:GOSUB 8
530 T$="a":D=27:F=91:GOSUB 8
531 T$="head ":GOSUB 8
532 T$="and ":D=54:F=102:GOSUB 8
534 T$="leave ":D=108:F=102:GOSUB 8
536 T$="me"+C$:D=54:F=91:GOSUB 8
537 FOR I=1 TO 520:NEXT
'
'  I think I prefer to stay inside.
'
538 T$="I ":F=152:GOSUB 8
540 T$="think ":F=85:GOSUB 8
542 T$="I ":F=91:GOSUB 8
544 T$="pre":F=102:GOSUB 8
546 T$="fer ":F=102:GOSUB 8
547 FOR I=1 TO 160: NEXT
548 T$="to ":F=91:GOSUB 8
550 T$="stay ":F=114:GOSUB 8
551 FOR I=1 TO 160: NEXT
552 T$="in":F=102:GOSUB 8
554 T$="side."+C$:D=108:F=152:GOSUB 8
555 FOR I=1 TO 560: NEXT
'
' Maybe you'll find someone else
'
556 T$="May":F=102:GOSUB 8
558 T$="be ":D=54:F=91:GOSUB 8
560 T$="you'll ":D=162:F=85:GOSUB 8
562 T$="find ":D=108:F=102:GOSUB 8
564 T$="some":F=121:GOSUB 8
566 T$="one ":D=54:F=114:GOSUB 8
568 T$="else"+C$:D=162:F=102:GOSUB 8
570 T$="to ":D=54:F=152:GOSUB 8
572 T$="help ":D=108:F=152:GOSUB 8
574 T$="you."+C$:D=54:F=91:GOSUB 8
575 FOR I=1 TO 800:NEXT
'
' Black Mesa
'
576 GOSUB 18:GOSUB 15:HOME:GOSUB 2800: GOSUB 10:GOSUB 19:PRINT
'
' Maybe Black Mesa.
'
578 T$="May":F=85:GOSUB 8
580 T$="be ":F=91:GOSUB 8
582 T$="Black ":F=102:GOSUB 8
584 T$="Me":D=108:F=102:GOSUB 8
586 T$="sa.":D=54:F=91:GOSUB 8
587 FOR I=1 TO 800:NEXT I
'
' THAT WAS A JOKE.
'
588 T$=".."+C$:GOSUB 30
590 T$="THAT ":F=85:GOSUB 8
591 T$="WAS ":F=91:GOSUB 8
592 T$="A ":F=102:GOSUB 8
593 T$="JOKE.":F=102:GOSUB 8
594 FOR I=1 TO 160: NEXT
'
' HAHA
'
595 T$=" ":F=91:GOSUB 8
596 T$=" ":F=114:GOSUB 8
597 FOR I=1 TO 160: NEXT
'
' FAT CHANCE.
'
598 T$="FAT ":F=102:GOSUB 8
600 T$="CHANCE."+C$:D=108:F=152:GOSUB 8
601 FOR I=1 TO 560: NEXT
'
' Anyway, this cake is
'
602 T$="A":F=102:GOSUB 8
604 T$="ny":D=54:F=91:GOSUB 8
606 T$="way, ":D=162:F=85:GOSUB 8
608 T$="this ":D=108:F=102:GOSUB 8
610 T$="cake ":F=121:GOSUB 8
612 T$="is ":D=54:F=114:GOSUB 8
'
' CAKE
'
614 GOSUB 18:GOSUB 15:HOME:GOSUB 2900: GOSUB 10:GOSUB 19:PRINT
616 POKE 36,X
'
' great.
'
616 T$="great."+C$:F=102:GOSUB 8
617 FOR I=1 TO 80: NEXT
'
' It's so delicious and moist.
'
618 T$="It's ":F=152:GOSUB 8
620 T$="so ":F=114:GOSUB 8
622 T$="de":F=102:GOSUB 8
624 T$="li":F=96:GOSUB 8
626 T$="cious ":F=102:GOSUB 8
628 T$="and ":F=114:GOSUB 8
630 T$="moist."+C$:F=128:GOSUB 8
631 FOR I=1 TO 160: NEXT
'
' GLaDOS
'
632 GOSUB 18:GOSUB 15:HOME:GOSUB 3000: GOSUB 10:GOSUB 19:PRINT
'
' Look at me still talking.
'
634 T$="Look ":F=152:GOSUB 8
636 T$="at ":F=143:GOSUB 8
638 T$="me ":D=108:F=128:GOSUB 8
640 T$="still ":F=96:GOSUB 8
642 T$="tal":D=54:F=102:GOSUB 8
644 T$="king"+C$:F=114:GOSUB 8
'
' when there's 
'
646 T$="when ":F=114:GOSUB 8
648 T$="there's ":F=128:GOSUB 8
'
' RADIATION
650 GOSUB 18:GOSUB 15:HOME:GOSUB 2100: GOSUB 10:GOSUB 19:PRINT
652 POKE 36,X
'
'Science to do.
'
654 T$="Sci":F=114:GOSUB 8
656 T$="ence ":F=128:GOSUB 8
658 T$="to ":D=108:F=128:GOSUB 8
660 T$="do."+C$:F=128:GOSUB 8
'
' APERTURE SCIENCE LOGO
'
662 GOSUB 18:GOSUB 15:HOME:GOSUB 2000: GOSUB 10:GOSUB 19:PRINT
'
' When I look out there
'
664 T$="When ":D=54:F=152:GOSUB 8
666 T$="I ":F=143:GOSUB 8
668 T$="look ":D=108:F=128:GOSUB 8
670 T$="out ":F=96:GOSUB 8
672 T$="there, "+C$:D=54:F=85:GOSUB 8
'
' it makes me GLaD I'm not you."+C$
'
674 T$="it ":F=96:GOSUB 8
676 T$="Makes ":F=102:GOSUB 8
678 T$="me ":F=114:GOSUB 8
680 T$="GLaD ":F=114:GOSUB 8
682 T$="I'm ":F=102:GOSUB 8
684 T$="not ":D=108:F=96:GOSUB 8
686 T$="you."+C$:F=96:GOSUB 8
'
' ATOM
'
688 GOSUB 18:GOSUB 15:HOME:GOSUB 2200: GOSUB 10:GOSUB 19:PRINT
'
' I've experiments to run.
'
690 T$="I've ":D=54:F=85:GOSUB 8
692 T$="ex":F=76:GOSUB 8
694 T$="pe":F=72:GOSUB 8
696 T$="ri":F=72:GOSUB 8
698 T$="ments ":F=76:GOSUB 8
700 T$="to ":F=85:GOSUB 8
702 T$="run."+C$:D=108:F=85:GOSUB 8
'
' EXPLOSION
'
704 GOSUB 18:GOSUB 15:HOME:GOSUB 2400: GOSUB 10:GOSUB 19:PRINT
'
' There is research to be done"
'
706 T$="There ":D=54:F=96:GOSUB 8
708 T$="is ":F=85:GOSUB 8
710 T$="re":F=76:GOSUB 8
712 T$="search ":F=76:GOSUB 8
714 T$="to ":F=85:GOSUB 8
716 T$="be ":F=96:GOSUB 8
718 T$="done."+C$:D=108:F=96:GOSUB 8
'
' APERTURE SCIENCE LOGO
'
720 GOSUB 18:GOSUB 15:HOME:GOSUB 2000: GOSUB 10:GOSUB 19:PRINT
'
' On the people who are
'
722 T$="On ":D=54:F=114:GOSUB 8
724 T$="the ":F=128:GOSUB 8
726 T$="peo":F=114:GOSUB 8
728 T$="ple ":F=96:GOSUB 8
730 T$="who ":F=96:GOSUB 8
732 T$="are"+C$:D=108:F=102:GOSUB 8
'
' still alive.
'
734 T$="still ":D=54:F=102:GOSUB 8
736 T$="a":F=91:GOSUB 8
738 T$="live."+C$:D=162:F=91:GOSUB 8
739 FOR I=1 TO 160: NEXT
'
'
'
740 HOME:PRINT:PRINT:PRINT
'
' PS: And believe me I am\nstill alive.
'
742 T$="PS: And ":D=54:F=76:GOSUB 8
744 T$="be":F=76:GOSUB 8
746 T$="lieve ":F=68:GOSUB 8
748 T$="me ":F=76:GOSUB 8
750 T$="I ":F=91:GOSUB 8
752 T$="am"+C$:D=108:F=114:GOSUB 8
754 T$="still ":D=54:F=102:GOSUB 8
756 T$="a":F=91:GOSUB 8
758 T$="live."+C$:D=162:F=91:GOSUB 8
759 FOR I=1 TO 240:NEXT
'
' PPS: I'm doing Science and I'm\nstill alive.
'
760 T$="PPS: ":GOSUB 30
762 T$="I'm ":D=54:F=76:GOSUB 8
764 T$="do":F=76:GOSUB 8
766 T$="ing ":F=76:GOSUB 8
768 T$="Sci":F=68:GOSUB 8
770 T$="ence ":F=76:GOSUB 8
772 T$="and ":F=91:GOSUB 8
774 T$="I'm"+C$:D=108:F=114:GOSUB 8
776 T$="still ":D=54:F=102:GOSUB 8
778 T$="a":F=91:GOSUB 8
780 T$="live."+C$:D=162:F=91:GOSUB 8
781 FOR I=1 TO 240:NEXT
'
' PPPS: I feel FANTASTIC and I'm\nstill alive
'
782 T$="PPPS: ":GOSUB 30
784 T$="I ":D=54:F=76:GOSUB 8
786 T$="feel ":F=76:GOSUB 8
788 T$="FAN":F=76:GOSUB 8
790 T$="TAS":F=68:GOSUB 8
792 T$="TIC ":F=76:GOSUB 8
794 T$="and ":F=91:GOSUB 8
796 T$="I'm"+C$:D=108:F=114:GOSUB 8
798 T$="still ":D=54:F=102:GOSUB 8
800 T$="a":F=91:GOSUB 8
802 T$="live."+C$:D=162:F=91:GOSUB 8
803 FOR I=1 TO 320:NEXT
804 PRINT
'
' FINAL THOUGHT:
'
806 T$="FINAL THOUGHT:"+C$:GOSUB 30
'
' While you're dying I'll be\nstill alive.
'
808 T$="While ":D=54:F=76:GOSUB 8
810 T$="you're ":F=76:GOSUB 8
812 T$="dy":F=68:GOSUB 8
814 T$="ing ":F=76:GOSUB 8
816 T$="I'll ":F=91:GOSUB 8
818 T$="be"+C$:D=108:F=114:GOSUB 8
820 T$="still ":D=54:F=102:GOSUB 8
822 T$="a":F=91:GOSUB 8
824 T$="live":D=162:F=91:GOSUB 8
825 FOR I=1 TO 240:NEXT
'
' FINAL THOUGHT PS
'
826 T$=C$+C$+"FINAL THOUGHT PS:"+C$:GOSUB 30
'
' And when you're dead I will be\nstill alive
'
828 T$="And ":D=54:F=76:GOSUB 8
830 T$="when ":F=76:GOSUB 8
832 T$="you're ":F=76:GOSUB 8
834 T$="dead ":F=68:GOSUB 8
836 T$="I ":F=76:GOSUB 8
838 T$="will ":F=91:GOSUB 8
840 T$="be"+C$:D=108:F=114:GOSUB 8
842 T$="still ":D=54:F=102:GOSUB 8
844 T$="a":F=91:GOSUB 8
846 T$="live"+C$:D=162:F=91:GOSUB 8
847 FOR I=1 TO 240:NEXT
'
'
'
848 PRINT:PRINT
'
' STILL ALIVE
'
850 T$="STILL ":D=54:F=85:GOSUB 8
851 T$="A":F=76:GOSUB 8
852 T$="LIVE":D=162:F=76:GOSUB 8
853 FOR I=1 TO 240:NEXT
854 PRINT:PRINT
'
' STILL ALIVE
'
855 T$="   ":D=54:F=85:GOSUB 8
856 T$="   ":F=91:GOSUB 8
857 T$="   ":D=162:F=91:GOSUB 8
858 FOR I=1 TO 240:NEXT
'
'
'
860 FOR I=1 TO 500:NEXT I
862 HOME
864 FOR I=1 TO 1000:NEXT I
866 T$="THANK YOU FOR PARTICIPATING"+C$:GOSUB 30
868 T$="IN THIS"+C$:GOSUB 30
870 T$="ENRICHMENT CENTER ACTIVITY!!"+C$:GOSUB 30
872 PRINT:PRINT
874 FOR I=1 TO 3000: NEXT I
1000 PRINT CHR$(4)+"PR#0"
1001 TEXT:HOME
1999 END
'
'
'
2000 REM APERTURE
2001 PRINT "              .,-:;//;:=,"
2002 PRINT "          . :H@@@MM@M#H/.,+%;,"
2003 PRINT "       ,/X+ +M@@M@MM%=,-%HMMM@X/,"
2004 PRINT "     -+@MM; $M@@MH+-,;XMMMM@MMMM@+-"
2005 PRINT "    ;@M@@M- XM@X;. -+XXXXXHHH@M@M#@/."
2006 PRINT "  ,%MM@@MH ,@%=            .---=-=:=,."
2007 PRINT "  =@#@@@MX .,              -%HX$$%%%+;"
2008 PRINT " =-./@M@M$                  .;@MMMM@MM:"
2009 PRINT " X@/ -$MM/                    .+MM@@@M$"
2010 PRINT ",@M@H: :@:                    . =X#@@@@-";
2011 PRINT ",@@@MMX, .                    /H- ;@M@M=";
2012 PRINT ".H@@@@M@+,                    %MM+..%#$.";
2013 PRINT " /MMMM@MMH/.                  XM@MH; =;"
2014 PRINT "  /%+%$XHH@$=              , .H@@@@MX,"
2015 PRINT "   .=--------.           -%H.,@@@@@MX,"
2016 PRINT "   .%MM@@@HHHXX$$$%+- .:$MMX =M@@MM%."
2017 PRINT "     =XMMM@MM@MM#H;,-+HMM@M+ /MMMX="
2018 PRINT "       =%@M@M#@$-.=$@MM@@@M; %M%="
2019 PRINT "         ,:+$+-,/H#MMMMMMM@= =,"
2020 PRINT "               =++%%%%+/:-."
2030 RETURN
'
2100 REM RADIOACTIVE
2101 PRINT "             =+$HM####@H%;,"
2102 PRINT "          /H###############M$,"
2103 PRINT "          ,@################+"
2104 PRINT "           .H##############+"
2105 PRINT "             X############/"
2106 PRINT "              $##########/"
2107 PRINT "               %########/"
2108 PRINT "                /X/;;+X/"
2109 PRINT
2110 PRINT "                 -XHHX-"
2111 PRINT "                ,######,"
2112 PRINT "#############X  .M####M.  X#############";
2113 PRINT "##############-   -//-   -##############";
2114 PRINT "X##############%,      ,+##############X";
2115 PRINT "-##############X        X##############-";
2116 PRINT " %############%          %############%"
2117 PRINT "  %##########;            ;##########%"
2118 PRINT "   ;#######M=              =M#######;"
2119 PRINT "    .+M###@,                ,@###M+."
2120 PRINT "       :XH.                  .HX:"
2130 RETURN
'
2200 REM ATOM
2201 PRINT "                 =/;;/-"
2202 PRINT "                +:    //"
2203 PRINT "               /;      /;"
2204 PRINT "              -X        H."
2205 PRINT ".//;;;:;;-,   X=        :+   .-;:=;:;%;.";
2206 PRINT "M-       ,=;;;#:,      ,:#;;:=,       ,@";
2207 PRINT ":%           :%.=/++++/=.$=           %=";
2208 PRINT " ,%;         %/:+/;,,/++:+/         ;+."
2209 PRINT "   ,+/.    ,;@+,        ,%H;,    ,/+,"
2210 PRINT "      ;+;;/= @.  .H##X   -X :///+;"
2211 PRINT "      ;+=;;;.@,  .XM@$.  =X.//;=%/."
2212 PRINT "   ,;:      :@%=        =$H:     .+%-"
2213 PRINT " ,%=         %;-///==///-//         =%,"
2214 PRINT ";+           :%-;;;:;;;;-X-           +:";
2215 PRINT "@-      .-;;;;M-        =M/;;;-.      -X";
2216 PRINT " :;;::;;-.    %-        :+    ,-;;-;:=="
2217 PRINT "              ,X        H."
2218 PRINT "               ;/      %="
2219 PRINT "                //    +;"
2220 PRINT "                 ,////,"
2230 RETURN
'
2300 REM BROKEN HEART
2301 PRINT "                          .,---."
2302 PRINT "                        ,/XM#MMMX;,"
2303 PRINT "                      -%##########M%,"
2304 PRINT "                     -@######%  $###@="
2305 PRINT "      .,--,         -H#######$   $###M:"
2306 PRINT "   ,;$M###MMX;     .;##########$;HM###X=";
2307 PRINT " ,/@##########H=      ;################+";
2308 PRINT "-+#############M/,      %##############+";
2309 PRINT "%M###############=      /##############:";
2310 PRINT "H################      .M#############;.";
2311 PRINT "@###############M      ,@###########M:."
2312 PRINT "X################,      -$=X#######@:"
2313 PRINT "/@##################%-     +######$-"
2314 PRINT ".;##################X     .X#####+,"
2315 PRINT " .;H################/     -X####+."
2316 PRINT "   ,;X##############,       .MM/"
2317 PRINT "      ,:+$H@M#######M#$-    .$$="
2318 PRINT "           .,-=;+$@###X:    ;/=."
2319 PRINT "                  .,/X$;   .::,"
2320 PRINT "                      .,    .."
2330 RETURN
'
2400 REM EXPLOSION
2401 PRINT "            .+"
2402 PRINT "             /M;"
2403 PRINT "              H#@:              ;,"
2404 PRINT "              -###H-          -@/"
2405 PRINT "               %####$.  -;  .%#X"
2406 PRINT "                M#####+;#H :M#M."
2407 PRINT "..          .+/;%#########X###-"
2408 PRINT " -/%H%+;-,    +##############/"
2409 PRINT "    .:$M###MH$%+############X  ,--=;-"
2410 PRINT "        -/H#####################H+=."
2411 PRINT "           .+#################X."
2412 PRINT "         =%M####################H;."
2413 PRINT "            /@###############+;;/%%;,"
2414 PRINT "         -%###################$."
2415 PRINT "       ;H######################M="
2416 PRINT "    ,%#####MH$%;+#####M###-/@####%"
2417 PRINT "  :$H%+;=-      -####X.,H#   -+M##@-"
2418 PRINT " .              ,###;    ;      =$##+"
2419 PRINT "                .#H,               :XH,"
2420 PRINT "                 +                   .;-";
2430 RETURN
'
2500 REM FIRE
2501 PRINT "                     -$-"
2502 PRINT "                    .H##H,"
2503 PRINT "                   +######+"
2504 PRINT "                .+#########H."
2505 PRINT "              -$############@."
2506 PRINT "            =H###############@  -X:"
2507 PRINT "          .$##################:  @#@-"
2508 PRINT "     ,;  .M###################;  H###;"
2509 PRINT "   ;@#:  @###################@  ,#####:"
2510 PRINT " -M###.  M#################@.  ;######H"
2511 PRINT " M####-  +###############$   =@#######X"
2512 PRINT " H####$   -M###########+   :#########M,"
2513 PRINT "  /####X-   =########%   :M########@/."
2514 PRINT "    ,;%H@X;   .$###X   :##MM@%+;:-"
2515 PRINT "                 .."
2516 PRINT "  -/;:-,.              ,,-==+M########H"
2517 PRINT " -##################@HX%%+%%$%%%+:,,"
2518 PRINT "    .-/H%%%+%%$H@###############M@+=:/+:";
2519 PRINT "/XHX%:#####MH%=    ,---:;;;;/%%XHM,:###$";
2520 PRINT "$@#MX %+;-                           ."
2530 RETURN
'
2600 REM CHECK
2601 PRINT "                                     :X-";
2602 PRINT "                                  :X###"
2603 PRINT "                                ;@####@"
2604 PRINT "                              ;M######X"
2605 PRINT "                            -@########$"
2606 PRINT "                          .$##########@"
2607 PRINT "                         =M############-";
2608 PRINT "                        +##############$";
2609 PRINT "                      .H############$=."
2610 PRINT "         ,/:         ,M##########M;."
2611 PRINT "      -+@###;       =##########M;"
2612 PRINT "   =%M#######;     :#########M/"
2613 PRINT "-$M###########;   :#########/"
2614 PRINT " ,;X###########; =########$."
2615 PRINT "     ;H#########+#######M="
2616 PRINT "       ,+##############+"
2617 PRINT "          /M#########@-"
2618 PRINT "            ;M######%"
2619 PRINT "              +####:"
2620 PRINT "               ,$M-"
2630 RETURN
'
2800 REM BLACK MESA
2801 PRINT "           .-;+$XHHHHHHX$+;-."
2802 PRINT "        ,;X@@X%/;=----=:/%X@@X/,"
2803 PRINT "      =$@@%=.              .=+H@X:"
2804 PRINT "    -XMX:                      =XMX="
2805 PRINT "   /@@:                          =H@+"
2806 PRINT "  %@X,                            .$@$"
2807 PRINT " +@X.                               $@%"
2808 PRINT "-@@,                                .@@=";
2809 PRINT "%@%                                  +@$";
2810 PRINT "H@:                                  :@H";
2811 PRINT "H@:         :HHHHHHHHHHHHHHHHHHX,    =@H";
2812 PRINT "%@%         ;@M@@@@@@@@@@@@@@@@@H-   +@$";
2813 PRINT "=@@,        :@@@@@@@@@@@@@@@@@@@@@= .@@:";
2814 PRINT " +@X        :@@@@@@@@@@@@@@@M@@@@@@:%@%"
2815 PRINT "  $@$,      ;@@@@@@@@@@@@@@@@@M@@@@@@$."
2816 PRINT "   +@@HHHHHHH@@@@@@@@@@@@@@@@@@@@@@@+"
2817 PRINT "    =X@@@@@@@@@@@@@@@@@@@@@@@@@@@@X="
2818 PRINT "      :$@@@@@@@@@@@@@@@@@@@M@@@@$:"
2819 PRINT "        ,;$@@@@@@@@@@@@@@@@@@X/-"
2820 PRINT "           .-;+$XXHHHHHX$+;-."
2830 RETURN
'
2900 REM CAKE DELICIOUS AND MOIST
2901 PRINT "            ,:/+/-"
2902 PRINT "            /M/              .,-=;//;-"
2903 PRINT "       .:/= ;MH/,    ,=/+%$XH@MM#@:"
2904 PRINT "      -$##@+$###@H@MMM#######H:.    -/H#";
2905 PRINT " .,H@H@ X######@ -H#####@+-     -+H###@X";
2906 PRINT "  .,@##H;      +XM##M/,     =%@###@X;-"
2907 PRINT "X%-  :M##########$.    .:%M###@%:"
2908 PRINT "M##H,   +H@@@$/-.  ,;$M###@%,          -";
2909 PRINT "M####M=,,---,.-%%H####M$:          ,+@##";
2910 PRINT "@##################@/.         :%H##@$-"
2911 PRINT "M###############H,         ;HM##M$="
2912 PRINT "#################.    .=$M##M$="
2913 PRINT "################H..;XM##M$=          .:+";
2914 PRINT "M###################@%=           =+@MH%";
2915 PRINT "@################M/.          =+H#X%="
2916 PRINT "=+M##############M,       -/X#X+;."
2917 PRINT "  .;XM##########H=    ,/X#H+:,"
2918 PRINT "     .=+HM######M+/+HM@+=."
2919 PRINT "         ,:/%XM####H/."
2920 PRINT "              ,.:=-."
2930 RETURN
'
3000 REM GLaDOS
3001 PRINT "       #+ @      # #              M#@"
3002 PRINT " .    .X  X.%##@;# #   +@#######X. @#%"
3003 PRINT "   ,==.   ,######M+  -#####%M####M-    #";
3004 PRINT "  :H##M%:=##+ .M##M,;#####/+#######% ,M#";
3005 PRINT " .M########=  =@#@.=#####M=M#######=  X#";
3006 PRINT " :@@MMM##M.  -##M.,#######M#######. =  M";
3007 PRINT "             @##..###:.    .H####. @@ X,";
3008 PRINT "   ############: ###,/####;  /##= @#. M"
3009 PRINT "           ,M## ;##,@#M;/M#M  @# X#% X#"
3010 PRINT ".%=   ######M## ##.M#:   ./#M ,M #M ,#$"
3011 PRINT "##/         $## #+;#: #### ;#/ M M- @# :";
3012 PRINT "#+ #M@MM###M-;M #:$#-##$H# .#X @ + $#. #";
3013 PRINT "      ######/.: #%=# M#:MM./#.-#  @#: H#";
3014 PRINT "+,.=   @###: /@ %#,@  ##@X #,-#@.##% .@#";
3015 PRINT "#####+;/##/ @##  @#,+       /#M    . X,"
3016 PRINT "   ;###M#@ M###H .#M-     ,##M  ;@@; ###";
3017 PRINT "   .M#M##H ;####X ,@#######M/ -M###$  -H";
3018 PRINT "    .M###%  X####H  .@@MM@;  ;@#M@"
3019 PRINT "      H#M    /@####/      ,++.  / ==-,"
3020 PRINT "               ,=/:, .+X@MMH@#H  #####$=";
3030 RETURN

