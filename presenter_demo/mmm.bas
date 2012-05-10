  10  DIM A(10,10): DIM B(10,10): DIM C(10,10)
  20  FOR I = 0 TO 9
  30  FOR J = 0 TO 9
  40 A(I,J) = I / 2 + J * 5
  50 B(I,J) = I / 4 * (I + 8) * J
  60  NEXT J,I
  70  PRINT  CHR$ (7);"START!"
 100  FOR J = 0 TO 9
 110  FOR I = 0 TO 9
 120 S = 0
 130  FOR K = 0 TO 9
 140 S = S + (A(K,J) * B(I,K))
 150  NEXT K
 160 C(I,J) = S
 170  NEXT I
 180  NEXT J
 190  PRINT  CHR$ (7);"STOP"
 200  FOR I = 0 TO 9
 210  FOR J = 0 TO 9
 220  PRINT C(I,J);" ";
 230  NEXT J
 240  PRINT 
 250  NEXT I
 300  PRINT "HOW MANY SECONDS? ";
 310  INPUT T
 320  PRINT 2000 / T;" FLOP/s"
 330  PRINT "Yes I know using BASIC is unfair"
 340  PRINT "But I am too lazy to code up a "
 350  PRINT "6502 FP implementaion in assembler"
